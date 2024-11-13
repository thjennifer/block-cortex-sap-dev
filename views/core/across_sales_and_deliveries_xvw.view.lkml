###################
# dimensions and measures that reference views:
#   sales_orders_v2
#   deliveries
#
###################

view: across_sales_and_deliveries_xvw {

  measure: fill_rate_using_deliveries {
    type: number
    sql: safe_divide(${deliveries.total_delivered_quantity},${sales_orders_v2.total_ordered_quantity}) ;;
    value_format_name: percent_1
  }

  measure: blocked_sales_order_count {
    hidden: no
    type: count_distinct
    sql:  ${sales_orders_v2.sales_document_vbeln};;
    filters: [deliveries.is_blocked: "Yes",sales_orders_v2.document_category_vbtyp: "C"]
  }

  measure: count_blocked_order_items {
    hidden: no
    type: count_distinct
    sql:  concat(${sales_orders_v2.sales_document_vbeln},${sales_orders_v2.item_posnr});;
    filters: [deliveries.is_blocked: "Yes"]
  }

  measure: difference_order_qty_delivery_qty {
    type: number
    sql: ${sales_orders_v2.total_ordered_quantity} - ${deliveries.total_delivered_quantity};;
    value_format_name: decimal_0
  }

  measure: difference_delivery_qty_order_qty {
    type: number
    sql:  ${deliveries.total_delivered_quantity} - ${sales_orders_v2.total_ordered_quantity};;
    value_format_name: decimal_0
  }

  measure: percent_difference_order_qty_delivery_qty {
    type: number
    sql: 1 - safe_divide(${deliveries.total_delivered_quantity},${sales_orders_v2.total_ordered_quantity});;
    value_format_name: percent_1
  }



}