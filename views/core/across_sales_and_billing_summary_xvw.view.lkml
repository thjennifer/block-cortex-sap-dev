###################
# dimensions and measures that reference views:
#   sales_orders_v2
#   sales_order_item_billing_summary
#   sales_order_item_delivery_summary
###################

view: across_sales_and_billing_summary_xvw {

  dimension: is_order_closed {
    type: yesno
    sql: ${sales_order_item_delivery_summary_ndt.is_order_in_full} = true AND
         ${sales_order_item_billing_summary_sdt.is_order_and_billing_quantity_equal} = true ;;
  }

  dimension: order_status {
    type: string
    sql:  case when ${sales_order_item_delivery_summary_ndt.is_order_any_item_cancelled} = true then "Cancelled"
               when ${is_order_closed} = true then "Closed"
               when ${is_order_closed} = false then "Open"
          end ;;
  }


  }
