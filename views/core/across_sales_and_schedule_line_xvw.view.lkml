###################
# dimensions and measures that reference views:
#   sales_orders_v2
#   sales_order_schedule_line_sdt
###################

view: across_sales_and_schedule_line_xvw {
  fields_hidden_by_default: no


  dimension: fill_rate_item {
    type: number
    description: "Fill Rate for Item computed as Confirmed Quantity (BMENG) / Order Quantity (KWMENG)"
    sql: coalesce(safe_divide(${sales_order_schedule_line_sdt.confirmed_quantity_bmeng}, ${sales_orders_v2.cumulative_order_quantity_kwmeng}),0);;
    value_format_name: percent_1
 }

  measure: fill_rate {
    type: number
    description: "Fill Rate computed as Total Quantity Confirmed / Total Quantity Ordered"
    sql: safe_divide(${sales_order_schedule_line_sdt.total_quantity_confirmed},${sales_orders_v2.total_ordered_quantity}) ;;
    value_format_name: percent_1
  }

  measure: avg_fill_rate_item {
    type: average
    label: "Average Fill Rate per Order Item"
    description: "Fill Rate computed as Average of Item Fill Rate across all Order Items"
    sql: ${fill_rate_item} ;;
    value_format_name: percent_1
  }





   }