###################
# dimensions and measures that reference views:
#   sales_orders_v2
#   currency_conversion_sdt
###################

view: across_sales_and_currency_conversion_xvw {

  dimension: key {
    primary_key: yes
    hidden: yes
    sql: 1 ;;
  }

  dimension: item_net_price_global_netpr {
    hidden: no
    type: number
    view_label: "Sales Orders Items"
    label: "Item Price (Global Currency) NETPR"
    description: "Net Price of Item (Global Currency)"
    sql: ${sales_orders_v2.net_price_netpr} * ${currency_conversion_sdt.exchange_rate_ukurs} ;;
    value_format_name: decimal_2
  }

  dimension: item_net_value_global_netwr {
    hidden: no
    type: number
    view_label: "Sales Orders Items"
    label: "Item Sales (Global Currency) NETWR"
    description: "Item Qty * Net Price (Global Currency)"
    sql:  ${item_net_price_global_netpr} * ${sales_orders_v2.cumulative_order_quantity_kwmeng};;
    value_format_name: decimal_2

  }

  measure: total_net_value_global {
    hidden: no
    type: sum
    view_label: "Sales Orders"
    label: "Total Sales (Global Currency {% parameter currency_conversion_sdt.select_global_currency %})"
    sql: ${item_net_value_global_netwr} ;;
    filters: [sales_orders_v2.document_category_vbtyp: "C"]
    value_format_name: "format_large_numbers_d1"
    sql_distinct_key: ${sales_orders_v2.key};;
  }

  measure: avg_net_value_per_order_global {
    hidden: no
    type: number
    view_label: "Sales Orders"
    label: "Average Sales per Order (Global Currency {% parameter currency_conversion_sdt.select_global_currency %})"
    sql: safe_divide(${total_net_value_global},${sales_orders_v2.count_orders});;
    sql_distinct_key: ${sales_orders_v2.key};;
    value_format_name: "format_large_numbers_d1"
  }

  measure: test_avg {
    hidden: no
    type: average_distinct
    view_label: "Sales Orders"
    sql: ${item_net_price_global_netpr} ;;
    sql_distinct_key: ${sales_orders_v2.key};;
  }

  measure: percent_of_total_net_value_global {
    hidden: no
    view_label: "Sales Orders"
    label: "Percent of Total Sales (Global)"
    type: percent_of_total
    sql: ${total_net_value_global} ;;
    sql_distinct_key: ${sales_orders_v2.key};;
  }

}
