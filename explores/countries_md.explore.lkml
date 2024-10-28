include: "/views/core/countries_md_rfn.view"
include: "/views/core/sales_orders_v2_rfn.view"
include: "/views/core/customers_md_rfn.view"

explore: countries_md {
  label: "Countries"
  sql_always_where: ${client_mandt} = '@{CLIENT_ID}' AND ${language_spras} = @{user_language};;
  always_join: [sales_orders_v2]


  join: customers_md {
    view_label: "Sales Orders"
    type: inner
    relationship: many_to_one
    sql_on: ${countries_md.client_mandt} = ${customers_md.client_mandt} AND
            ${countries_md.country_key_land1} = ${customers_md.country_key_land1}
            ;;
    fields: []
  }

  join: sales_orders_v2 {
    type: inner
    relationship: many_to_many
    sql_on: ${customers_md.client_mandt} = ${sales_orders_v2.client_mandt} AND
            ${customers_md.customer_number_kunnr} = ${sales_orders_v2.sold_to_party_kunnr};;
    fields: []
  }

}
