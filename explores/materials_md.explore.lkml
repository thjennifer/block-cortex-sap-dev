include: "/views/core/materials_md_rfn.view"
include: "/views/core/sales_orders_v2_rfn.view"

explore: materials_md {
  label: "Materials"

  sql_always_where: ${language_spras} = @{user_language} AND ${client_mandt} = '@{CLIENT_ID}';;

  always_join: [sales_orders_v2]

  join: sales_orders_v2 {
    type: inner
    relationship: one_to_many
    sql_on: ${materials_md.client_mandt} = ${sales_orders_v2.client_mandt} AND
            ${materials_md.material_number_matnr} = ${sales_orders_v2.material_number_matnr} ;;
    fields: []
  }


}