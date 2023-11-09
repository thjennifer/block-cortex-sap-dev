###################
# dimensions and measures that reference views:
#   sales_orders_v2
#   sales_order_item_billing_summary
#   sales_order_item_delivery_summary
###################

view: across_sales_and_billing_summary_xvw {

  dimension: is_order_closed {
    type: yesno
    sql: ${sales_order_item_delivery_summary.is_order_filled} = ${sales_order_item_billing_summary.is_order_qty_equal_billing_qty} ;;
  }



  }
