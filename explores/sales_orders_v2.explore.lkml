# base view
include: "/views/core/sales_orders_v2_rfn.view"

# other facts
include: "/views/core/one_touch_order_rfn.view"
include: "/views/core/currency_conversion_sdt.view"
include: "/views/core/sales_order_schedule_line_sdt.view"
include: "/views/core/deliveries_rfn.view"
include: "/views/core/sales_order_item_delivery_summary_ndt.view"
include: "/views/core/returns_sdt.view.lkml"
include: "/views/core/sales_order_item_billing_summary_sdt.view"
include: "/views/core/sales_order_partner_function_sdt.view"
include: "/views/core/sales_order_item_partner_function_sdt.view"
include: "/views/core/sales_order_pricing_sdt.view"

# included _md views for labels
include: "/views/core/materials_md_rfn.view"
include: "/views/core/sales_organizations_md_rfn.view"
include: "/views/core/distribution_channels_md_rfn.view"
include: "/views/core/divisions_md_rfn.view"
include: "/views/core/customers_md_rfn.view"
include: "/views/core/countries_md_rfn.view"

# field-only views
include: "/views/core/otc_common_parameters_xvw.view"
include: "/views/core/across_sales_and_deliveries_xvw.view"
include: "/views/core/across_sales_and_returns_xvw.view"
include: "/views/core/across_sales_and_billing_summary_xvw.view"

# dashboard navigation
include: "/views/core/otc_dashboard_navigation_ext.view"

explore: sales_orders_v2 {
  label: "Sales Orders"
  # persist_for: "2 minutes"
  sql_always_where: ${sales_orders_v2.client_mandt}='@{CLIENT_ID}'

 -- and
--      {% if sales_orders_v2.date_filter._is_filtered %}
--      {% condition sales_orders_v2.date_filter %} timestamp(${sales_orders_v2.creation_date_erdat_raw}) {% endcondition %}
--      {% else %}
      --filter to last 3 years by default
--      ${sales_orders_v2.creation_date_erdat_raw} >= date_sub(current_date,interval 3 YEAR)
--      {% endif %}
;;
  # and {% if currency_conversion_sdt._in_query and sales_orders_v2.date_filter._is_filtered %}
  #     {% condition sales_orders_v2.date_filter %} timestamp(${currency_conversion_sdt.conv_date}) {% endcondition %}
  #     {% elsif currency_conversion_sdt._in_query %}
  #     --filter to last 3 years by default
  #     ${currency_conversion_sdt.conv_date} >= date_sub(current_date,interval 10 YEAR)
  #     {% else %} 1=1
  #     {% endif %}

  join: otc_dashboard_navigation_ext {
    relationship: one_to_one
    sql:  ;;
  }

  join: otc_common_parameters_xvw {
    relationship: one_to_one
    sql:  ;;
}

  # join: language_map_sdt {
  #   type: cross
  #   relationship: many_to_one
  #   fields: []
  # }

  join: currency_conversion_sdt {
    type: inner
    relationship: many_to_one
    sql_on: ${sales_orders_v2.client_mandt}=${currency_conversion_sdt.client_mandt} AND
            ${sales_orders_v2.currency_waerk}=${currency_conversion_sdt.from_currency_fcurr} AND
            ${sales_orders_v2.creation_date_erdat_raw} = ${currency_conversion_sdt.conv_date};;
    fields: []
  }

  join: materials_md {
    view_label: "Sales Orders Items"
    type: left_outer
    relationship: one_to_many
    sql_on: ${sales_orders_v2.material_number_matnr}=${materials_md.material_number_matnr} AND
            ${sales_orders_v2.client_mandt}=${materials_md.client_mandt} AND
            ${materials_md.language_spras} = @{user_language}
             ;;
    fields: []
      }

  join: sales_organizations_md {
    view_label: "Sales Orders"
    type: left_outer
    relationship: many_to_one
    sql_on: ${sales_orders_v2.client_mandt} = ${sales_organizations_md.client_mandt} AND
            ${sales_orders_v2.sales_organization_vkorg} = ${sales_organizations_md.sales_org_vkorg} AND
            ${sales_organizations_md.language_spras} = @{user_language}
             ;;
    # required_joins: [language_map_sdt]
    fields: [sales_organizations_md.sales_org_name_vtext]
  }

  join: distribution_channels_md {
    view_label: "Sales Orders"
    type: left_outer
    relationship: many_to_one
    sql_on: ${sales_orders_v2.client_mandt} = ${distribution_channels_md.client_mandt} AND
            ${sales_orders_v2.distribution_channel_vtweg} = ${distribution_channels_md.distribution_channel_vtweg} AND
            ${distribution_channels_md.language_spras} = @{user_language}
            ;;
    # required_joins: [language_map_sdt]
      fields: [distribution_channels_md.distribution_channel_name_vtext]
    }

  join: divisions_md {
    view_label: "Sales Orders"
    type: left_outer
    relationship: many_to_one
    sql_on: ${sales_orders_v2.client_mandt} = ${divisions_md.client_mandt} AND
            ${sales_orders_v2.division_spart} = ${divisions_md.division_spart} AND
            ${divisions_md.language_spras} = @{user_language}
            ;;
    # required_joins: [language_map_sdt]
      # fields: [divisions_md.division_name_vtext]
    fields: []
    }

  join: customers_md {
    view_label: "Sales Orders"
    type: left_outer
    relationship: many_to_one
    sql_on: ${sales_orders_v2.client_mandt} = ${customers_md.client_mandt} AND
            ${sales_orders_v2.sold_to_party_kunnr} = ${customers_md.customer_number_kunnr} AND
            ${customers_md.language_key_spras} = @{user_language}
           ;;
    fields: [customers_md.customer_name]
  }

  join: countries_md {
    view_label: "Sales Orders"
    type: left_outer
    relationship: many_to_one
    sql_on: ${sales_orders_v2.client_mandt} = ${countries_md.client_mandt} AND
            ${customers_md.country_key_land1} = ${countries_md.country_key_land1} AND
            ${countries_md.language_spras} = @{user_language}
            ;;
    fields: [countries_md.country_name_landx]
  }

  join: one_touch_order {
    view_label: "Sales Orders"
    type: left_outer
    relationship: one_to_one
    sql_on: ${sales_orders_v2.client_mandt} = ${one_touch_order.vbapclient_mandt} and
            ${sales_orders_v2.sales_document_vbeln} = ${one_touch_order.vbapsales_document_vbeln} and
            ${sales_orders_v2.item_posnr} = ${one_touch_order.vbapsales_document_item_posnr};;
  }

  join: sales_order_schedule_line_sdt {
    view_label: "Sales Orders"
    type: left_outer
    relationship: one_to_one
    sql_on: ${sales_orders_v2.client_mandt} = ${sales_order_schedule_line_sdt.client_mandt} and
            ${sales_orders_v2.sales_document_vbeln} = ${sales_order_schedule_line_sdt.sales_document_vbeln} and
            ${sales_orders_v2.item_posnr} = ${sales_order_schedule_line_sdt.sales_document_item_posnr} ;;
    fields: [sales_order_schedule_line_sdt.fields_for_sales_explore*]
  }

  join: deliveries {
    type: left_outer
    relationship: one_to_many
    sql_on: ${sales_orders_v2.client_mandt} = ${deliveries.client_mandt} and
            ${sales_orders_v2.sales_document_vbeln} = ${deliveries.sales_order_number_vgbel} and
            ${sales_orders_v2.item_posnr} = ${deliveries.sales_order_item_vgpos} ;;
    # fields: [deliveries.fields_for_sales*]
  }

  join: sales_order_item_delivery_summary_ndt {
    view_label: "Sales Orders Items"
    type: inner
    relationship: one_to_one
    sql_on: ${sales_orders_v2.client_mandt} = ${sales_order_item_delivery_summary_ndt.client_mandt} and
            ${sales_orders_v2.sales_document_vbeln} = ${sales_order_item_delivery_summary_ndt.sales_document_vbeln} and
            ${sales_orders_v2.item_posnr} = ${sales_order_item_delivery_summary_ndt.item_posnr} ;;
  }

  join: returns_sdt {
    view_label: "Returns"
    type: left_outer
    relationship: one_to_many
    sql_on:  ${sales_orders_v2.client_mandt} = ${returns_sdt.client_mandt} and
            ${sales_orders_v2.sales_document_vbeln} = ${returns_sdt.reference_sales_document_vbeln} and
            ${sales_orders_v2.item_posnr} = ${returns_sdt.reference_item_posnr} ;;
    # fields: [returns_sdt.is_return]
  }

  join: sales_order_item_billing_summary_sdt {
    view_label: "Sales Orders Items"
    type: left_outer
    relationship: one_to_one
    sql_on:   ${sales_orders_v2.client_mandt} = ${sales_order_item_billing_summary_sdt.client_mandt} and
              ${sales_orders_v2.sales_document_vbeln} = ${sales_order_item_billing_summary_sdt.sales_document_vbeln} and
              ${sales_orders_v2.item_posnr} = ${sales_order_item_billing_summary_sdt.item_posnr} ;;
  }

  join: sales_order_partner_function_sdt {
    view_label: "Sales Orders"
    type: left_outer
    relationship: many_to_one
    sql_on: ${sales_orders_v2.client_mandt} = ${sales_order_partner_function_sdt.client_mandt} and
            ${sales_orders_v2.sales_document_vbeln} = ${sales_order_partner_function_sdt.sales_document_vbeln} ;;
  }

  join: sales_order_item_partner_function_sdt {
    view_label: "Sales Orders Items"
    type: left_outer
    relationship: many_to_one
    sql_on: ${sales_orders_v2.client_mandt} = ${sales_order_item_partner_function_sdt.client_mandt} and
            ${sales_orders_v2.sales_document_vbeln} = ${sales_order_item_partner_function_sdt.sales_document_vbeln} and
            ${sales_orders_v2.item_posnr} = ${sales_order_item_partner_function_sdt.item_posnr};;
  }

  join: sales_order_pricing_sdt {
    view_label: "Sales Orders Items"
    type: left_outer
    relationship: one_to_many
    sql_on: ${sales_orders_v2.client_mandt}=${sales_order_pricing_sdt.client_mandt} AND
            ${sales_orders_v2.condition_number_knumv}=${sales_order_pricing_sdt.number_of_the_document_condition_knumv} AND
            ${sales_orders_v2.item_posnr} = ${sales_order_pricing_sdt.condition_item_number_kposn};;
  }


  join: across_sales_and_deliveries_xvw {
    view_label: "Deliveries"
    relationship: one_to_one
    sql:  ;;
  }

  join: across_sales_and_returns_xvw {
    relationship: one_to_one
    sql:  ;;
  }

  join: across_sales_and_billing_summary_xvw {
    relationship: one_to_one
    sql:  ;;
  }





}
