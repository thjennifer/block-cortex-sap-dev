###################
# dimensions and measures that reference views:
#   sales_orders_v2
#   returns_sdt
###################

view: across_sales_and_returns_xvw {

  label: "Sales Orders Items"

  measure: count_returns {
    type: count_distinct
    sql: ${returns_sdt.reference_sales_document_vbeln};;
    filters: [sales_orders_v2.document_category_vbtyp: "C"]
  }



  measure: percent_orders_with_return {
    hidden: no
    description: "Percent of Orders with at least 1 item returned"
    type: number
    sql:  safe_divide(${count_returns},${sales_orders_v2.count_orders});;
    value_format_name: percent_1
  }




  }
