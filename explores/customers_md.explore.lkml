include: "/views/core/customers_md_rfn.view"
include: "/views/core/sales_orders_v2_rfn.view"

explore: customers_md {
  label: "Customers"

  sql_always_where: ${client_mandt} = '@{CLIENT_ID}' AND ${language_key_spras} = @{user_language};;

  # always_join: [sales_orders_v2]

  # join: sales_orders_v2 {
  #   type: inner
  #   relationship: one_to_many
  #   sql_on: ${customers_md.client_mandt} = ${sales_orders_v2.client_mandt} AND
  #           ${customers_md.customer_number_kunnr} = ${sales_orders_v2.sold_to_party_kunnr} ;;
  #   fields: []
  # }


}
