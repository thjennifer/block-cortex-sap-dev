###################
# dimensions and measures that reference views:
#   sales_orders_v2
#   convert_sales_to_target_currency
###################

view: convert_sales_to_target_currency {

  dimension: net_price_global_netpr {
    hidden: no
    type: number
    view_label: "Sales Orders Items"
    label: "Net Price of Item (Global Currency) NETPR"
    description: "Net Price of Item (Global Currency)"
    sql: ${sales_orders_v2.net_price_netpr} * ${currency_conversion_sdt.exchange_rate_ukurs} ;;
    value_format_name: decimal_2
  }

  dimension: sales_order_value_line_item_global_currency {
    hidden: no
    type: number
    view_label: "Sales Orders Items"
    label: "Net Value of Item (Global Currency) NETWR"
    description: "Item Qty * Net Price (Global Currency)"
    sql:  ${net_price_global_netpr} * ${sales_orders_v2.cumulative_order_quantity_kwmeng};;
    value_format_name: decimal_2
  }

  measure: total_net_value_global {
    hidden: no
    type: sum
    view_label: "Sales Orders"
    label: "Total Net Value (Global Currency)"
    sql: ${sales_order_value_line_item_global_currency} ;;
    value_format_name: "format_large_numbers_d1"
  }

}
