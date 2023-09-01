include: "/views/core/sales_orders_v2_rfn.view"
include: "/views/core/materials_md_rfn.view"
include: "/views/core/sales_organizations_md_rfn.view"
include: "/views/core/distribution_channels_md_rfn.view"
include: "/views/core/divisions_md_rfn.view"
include: "/views/core/customers_md_rfn.view"
include: "/views/core/countries_md_rfn.view"
include: "/views/core/currency_conversion_sdt.view"
include: "/views/core/convert_sales_to_target_currency_xvw.view"
include: "/views/core/language_map_sdt.view"

explore: sales_orders_v2 {
  label: "Sales Orders"

  sql_always_where: ${sales_orders_v2.client_mandt}='@{CLIENT}'
  ;;

  # and
  #     {% if sales_orders_v2.date_filter._is_filtered %}
  #     {% condition sales_orders_v2.date_filter %} timestamp(${sales_orders_v2.creation_date_erdat_raw}) {% endcondition %}
  #     {% else %}
  #     --filter to last 3 years by default
  #     ${sales_orders_v2.creation_date_erdat_raw} >= date_sub(current_date,interval 10 YEAR)
  #     {% endif %}

  # and {% if currency_conversion_sdt._in_query and sales_orders_v2.date_filter._is_filtered %}
  #     {% condition sales_orders_v2.date_filter %} timestamp(${currency_conversion_sdt.conv_date}) {% endcondition %}
  #     {% elsif currency_conversion_sdt._in_query %}
  #     --filter to last 3 years by default
  #     ${currency_conversion_sdt.conv_date} >= date_sub(current_date,interval 10 YEAR)
  #     {% else %} 1=1
  #     {% endif %}

  join: language_map_sdt {
    type: cross
    relationship: many_to_one
    fields: []
  }

  join: currency_conversion_sdt {
    type: inner
    relationship: many_to_one
    sql_on: ${sales_orders_v2.client_mandt}=${currency_conversion_sdt.client_mandt} and
            ${sales_orders_v2.currency_waerk}=${currency_conversion_sdt.from_currency_fcurr} and
            ${sales_orders_v2.creation_date_erdat_raw} = ${currency_conversion_sdt.conv_date};;
  }

  join: materials_md {
    view_label: "Sales Orders Items"
    type: left_outer
    relationship: one_to_many
    sql_on: ${sales_orders_v2.material_number_matnr}=${materials_md.material_number_matnr} and
            ${sales_orders_v2.client_mandt}=${materials_md.client_mandt} and
            ${language_map_sdt.language_spras} = ${materials_md.language_spras};;
    fields: [material_text_maktx]

  }

  join: sales_organizations_md {
    view_label: "Sales Orders"
    type: left_outer
    relationship: many_to_one
    sql_on: ${sales_orders_v2.client_mandt} = ${sales_organizations_md.client_mandt} and
            ${sales_orders_v2.sales_organization_vkorg} = ${sales_organizations_md.sales_org_vkorg} and
            ${language_map_sdt.language_spras} = ${sales_organizations_md.language_spras};;
    # required_joins: [language_map_sdt]
    fields: [sales_organizations_md.sales_org_name_vtext]
  }

  join: distribution_channels_md {
    view_label: "Sales Orders"
    type: left_outer
    relationship: many_to_one
    sql_on: ${sales_orders_v2.client_mandt} = ${distribution_channels_md.client_mandt} and
            ${sales_orders_v2.distribution_channel_vtweg} = ${distribution_channels_md.distribution_channel_vtweg} and
            ${language_map_sdt.language_spras} = ${distribution_channels_md.language_spras};;
    # required_joins: [language_map_sdt]
      fields: [distribution_channels_md.distribution_channel_name_vtext]
    }

  join: divisions_md {
    view_label: "Sales Orders"
    type: left_outer
    relationship: many_to_one
    sql_on: ${sales_orders_v2.client_mandt} = ${divisions_md.client_mandt} and
            ${sales_orders_v2.division_spart} = ${divisions_md.division_spart} and
            ${language_map_sdt.language_spras} = ${divisions_md.language_spras};;
    # required_joins: [language_map_sdt]
      fields: [divisions_md.division_name_vtext]
    }

  join: customers_md {
    view_label: "Sales Orders"
    type: left_outer
    relationship: many_to_one
    sql_on: ${sales_orders_v2.client_mandt} = ${customers_md.client_mandt} and
            ${sales_orders_v2.sold_to_party_kunnr} = ${customers_md.customer_number_kunnr};;
    fields: [customers_md.name1_name1]
  }

  join: countries_md {
    view_label: "Sales Orders"
    type: left_outer
    relationship: many_to_one
    sql_on: ${sales_orders_v2.client_mandt} = ${countries_md.client_mandt} and
            ${customers_md.country_key_land1} = ${countries_md.country_key_land1} and
            ${language_map_sdt.language_spras} = ${countries_md.language_spras};;
    fields: [countries_md.country_name_landx]
  }

  join: convert_sales_to_target_currency {
    relationship: one_to_one
    sql:  ;;
  }



}
