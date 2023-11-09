###################
# dimensions and measures that reference views:
#   sales_orders_v2
#   returns_sdt
###################

view: across_sales_and_returns_xvw {

  label: "Sales Orders Items"

  measure: percent_orders_with_return {
    hidden: no
    description: "Percent of Orders with at least 1 item returned"
    type: number
    sql:  safe_divide(${returns_sdt.count_returns},${sales_orders_v2.count_orders});;
    value_format_name: percent_1
  }


  }
