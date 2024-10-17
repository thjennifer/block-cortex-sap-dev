include: "/views/core/divisions_md_rfn.view"
include: "/views/core/sales_orders_v2_rfn.view"

explore: divisions_md {
  label: "Divisions"

  sql_always_where: ${language_spras} = @{user_language} AND ${client_mandt} = '@{CLIENT_ID}';;

  # always_join: [sales_orders_v2]

  # join: sales_orders_v2 {
  #   type: inner
  #   relationship: one_to_many
  #   sql_on: ${divisions_md.client_mandt} = ${sales_orders_v2.client_mandt} AND
  #           ${divisions_md.division_spart} = ${sales_orders_v2.division_spart} ;;
  #   fields: []
  # }


}
