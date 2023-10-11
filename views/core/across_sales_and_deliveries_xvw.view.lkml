###################
# dimensions and measures that reference views:
#   sales_orders_v2
#   deliveries
###################

view: across_sales_and_deliveries_xvw {

  dimension: key {
    primary_key: yes
    hidden: yes
    # sql: concat(${sales_orders_v2.client_mandt},${sales_orders_v2.sales_document_vbeln},${sales_orders_v2.item_posnr},${deliveries.delivery_vbeln}) ;;
    sql: concat(${deliveries.client_mandt},${deliveries.sales_order_number_vgbel},${deliveries.delivery_item_posnr},${deliveries.delivery_vbeln}) ;;

  }


  dimension: is_in_full {
    type: yesno
    sql: ${deliveries.is_delivered} and ${sales_orders_v2.cumulative_order_quantity_kwmeng}=${deliveries.actual_quantity_delivered_in_sales_units_lfimg} ;;
  }

  dimension: is_otif {
    label: "Is OTIF Delivery"
    description: "Delivery is On Time and In Full"
    type: yesno
    sql: ${is_in_full} and ${deliveries.is_on_time} ;;
  }

  dimension: order_cycle_time {
    hidden: no
    label: "Order Cycle Time (Days)"
    sql: case when ${deliveries.actual_goods_movement_date_wadat_ist_raw} is not null then
        timestamp_diff(timestamp(${deliveries.proof_of_delivery_timestamp}),${sales_orders_v2.creation_timestamp},DAY)
        end;;
  }

  measure: count_in_full_deliveries {
    hidden: yes
    description: "Count of Deliveries where Quantity is Delivered in Full"
    type: count_distinct
    sql: ${deliveries.delivery_vbeln} ;;
    filters: [is_in_full: "Yes"]
  }

  measure: count_otif_deliveries {
    hidden: yes
    label: "Count OTIF Deliveries"
    description: "Count of Deliveries On Time and In Full"
    type: count_distinct
    sql: ${deliveries.delivery_vbeln} ;;
    filters: [is_otif: "Yes"]
  }

  measure: percent_in_full_deliveries {
    description: "Percent of Deliveries where Quantity is Delivered in Full"
    type: number
    sql: safe_divide(${count_in_full_deliveries},${deliveries.count_deliveries}) ;;
    value_format_name: percent_1
  }

  measure: percent_otif_deliveries {
    label: "Percent OTIF Deliveries"
    description: "Percent of Deliveries On Time and In Full"
    type: number
    sql: safe_divide(${count_otif_deliveries},${deliveries.count_deliveries}) ;;
    value_format_name: percent_1
  }

  measure: avg_distinct_order_cycle_time {
    type: average_distinct
    sql_distinct_key: ${deliveries.delivery_vbeln} ;;
    sql: ${order_cycle_time} ;;
    value_format_name: decimal_1
  }

  measure: avg_order_cycle_time {
    type: average
    sql: ${order_cycle_time} ;;
    value_format_name: decimal_1
  }

  measure: fill_rate_using_deliveries {
    type: number
    sql: safe_divide(${deliveries.total_quantity_delivered},${sales_orders_v2.total_quantity_ordered}) ;;
    value_format_name: percent_1
  }

  measure: count_blocked_orders {
    hidden: no
    type: count_distinct
    sql:  ${sales_orders_v2.sales_document_vbeln};;
    filters: [deliveries.is_blocked: "Yes"]
  }

  measure: count_blocked_order_items {
    hidden: no
    type: count_distinct
    sql:  concat(${sales_orders_v2.sales_document_vbeln},${sales_orders_v2.item_posnr});;
    filters: [deliveries.is_blocked: "Yes"]
  }

  # measure: avg_order_cycle_time_per_item {
  #   type: average
  #   sql: ${order_cycle_time} ;;
  # }


}
