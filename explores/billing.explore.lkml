include: "/views/core/billing_rfn.view"
include: "/views/core/sales_orders_v2_rfn.view"

include: "/views/core/customers_md_rfn.view"
include: "/views/core/divisions_md_rfn.view"
include: "/views/core/materials_md_rfn.view"
include: "/views/core/countries_md_rfn.view"
include: "/views/core/sales_organizations_md_rfn.view"
include: "/views/core/distribution_channels_md_rfn.view"

include: "/views/core/currency_conversion_sdt.view"
include: "/views/core/sales_order_pricing_sdt.view"
include: "/views/core/otc_common_parameters_xvw.view"
include: "/views/core/otc_dashboard_navigation_ext.view"

explore: billing {

  sql_always_where: ${billing.client_mandt}='@{CLIENT_ID}' AND ${is_cancelled} = FALSE ;;

  # join: sales_orders_v2 {
  #   relationship: many_to_one
  #   type: left_outer
  #   sql_on: ${billing.client_mandt} = ${sales_orders_v2.client_mandt} AND
  #           ${billing.sales_document_aubel} = ${sales_orders_v2.sales_document_vbeln} AND
  #           ${billing.sales_document_item_aupos} = ${sales_orders_v2.item_posnr} ;;
  #   fields: []
  # }

  join: customers_md {
    view_label: "Billing"
    type: left_outer
    relationship: many_to_one
    sql_on: ${billing.client_mandt} = ${customers_md.client_mandt} AND
            ${billing.sold_to_party_kunag} = ${customers_md.customer_number_kunnr} AND
            ${customers_md.language_key_spras} = @{user_language};;
    fields: []
  }

  join: divisions_md {
    view_label: "Billing Items"
    type: left_outer
    relationship: many_to_one
    sql_on: ${billing.client_mandt} = ${divisions_md.client_mandt} AND
            ${billing.division_spart} = ${divisions_md.division_spart} AND
            ${divisions_md.language_spras} = @{user_language};;
    fields: []
    }

  join: materials_md {
    view_label: "Billing Items"
    type: left_outer
    relationship: one_to_many
    sql_on: ${billing.client_mandt}=${materials_md.client_mandt} AND
            ${billing.material_number_matnr}=${materials_md.material_number_matnr} AND
            ${materials_md.language_spras} = @{user_language};;
    fields: []
  }

  join: countries_md {
    view_label: "Billing"
    type: left_outer
    relationship: many_to_one
    sql_on: ${billing.client_mandt} = ${countries_md.client_mandt} AND
            ${customers_md.country_key_land1} = ${countries_md.country_key_land1} AND
            ${countries_md.language_spras} = @{user_language};;
    fields: [countries_md.country_name_landx]
  }

  join: sales_organizations_md {
    view_label: "Billing"
    type: left_outer
    relationship: many_to_one
    sql_on: ${billing.client_mandt} = ${sales_organizations_md.client_mandt} AND
            ${billing.sales_organization_vkorg} = ${sales_organizations_md.sales_org_vkorg} AND
            ${sales_organizations_md.language_spras} = @{user_language};;
    fields: [sales_organizations_md.sales_org_name_vtext]
  }

  join: distribution_channels_md {
    view_label: "Billing"
    type: left_outer
    relationship: many_to_one
    sql_on: ${billing.client_mandt} = ${distribution_channels_md.client_mandt} AND
            ${billing.distribution_channel_vtweg} = ${distribution_channels_md.distribution_channel_vtweg} AND
            ${distribution_channels_md.language_spras} = @{user_language};;
    fields: [distribution_channels_md.distribution_channel_name_vtext]
  }


  join: otc_common_parameters_xvw {
    relationship: one_to_one
    sql:  ;;
  }

  join: otc_dashboard_navigation_ext {
    relationship: one_to_one
    sql:  ;;
  }

  join: currency_conversion_sdt {
    type: inner
    relationship: many_to_one
    sql_on: ${billing.client_mandt}=${currency_conversion_sdt.client_mandt} AND
              ${billing.source_currency_waerk}=${currency_conversion_sdt.from_currency_fcurr} AND
              ${billing.billing_date_fkdat_raw} = ${currency_conversion_sdt.conv_date};;
    fields: []
  }

  join: sales_order_pricing_sdt {
    view_label: "Billing Items"
    type: left_outer
    relationship: one_to_many
    sql_on: ${billing.client_mandt}=${sales_order_pricing_sdt.client_mandt} AND
            ${billing.number_of_the_document_condition_knumv}=${sales_order_pricing_sdt.number_of_the_document_condition_knumv} AND
            ${billing.sales_document_item_aupos} = ${sales_order_pricing_sdt.condition_item_number_kposn};;
  }

}
