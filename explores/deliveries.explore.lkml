include: "/views/core/deliveries_rfn.view"
include: "/views/core/sales_orders_v2_rfn.view"
include: "/views/core/across_sales_and_deliveries_xvw.view"

explore: deliveries {
  sql_always_where: ${client_mandt} = '@{CLIENT_ID}' ;;

  join: sales_orders_v2 {
    type: left_outer
    relationship: one_to_one
    sql_on: ${deliveries.client_mandt} = ${sales_orders_v2.client_mandt} and
            ${deliveries.sales_order_number_vgbel} = ${sales_orders_v2.sales_document_vbeln} and
            ${deliveries.sales_order_item_vgpos} = ${sales_orders_v2.item_posnr} ;;
    fields: [sales_orders_v2.cumulative_order_quantity_kwmeng]
  }

  join: across_sales_and_deliveries_xvw {
    view_label: "Deliveries"
    relationship: one_to_one
    sql:  ;;
  }


}
