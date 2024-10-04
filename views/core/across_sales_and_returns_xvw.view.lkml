###################
# dimensions and measures that reference views:
#   sales_orders_v2
#   returns_sdt
###################

view: across_sales_and_returns_xvw {

  label: "Sales Orders Items"

  measure: has_return_sales_order_count {
    type: count_distinct
    sql: ${returns_sdt.reference_sales_document_vbeln};;
    filters: [sales_orders_v2.document_category_vbtyp: "C"]
  }



  measure: has_return_sales_order_percent {
    hidden: no
    description: "Percent of Sales Orders with at least 1 item returned"
    type: number
    sql:  safe_divide(${has_return_sales_order_count},${sales_orders_v2.sales_order_count});;
    value_format_name: percent_1
    link: {
      label: "Show Top 10 products with highest Return Rate"
      url: "{{ dummy_set_product_with_return._link }}&limit=10"
    }

    link: {
      label: "Show Orders with Returns"
      # url: "{{ dummy_set_details._link }}&f[Is+Order+Late]=\"Yes\""
      # url: "{{ dummy_set_details._link}}&f[sales_order_item_delivery_summary_ndt.test_dimension]=odd"
      url: "{{ dummy_set_details_orders_with_returns._link}}&f[returns_sdt.is_return]=Yes"
      # url: "{{ link }}&f[view_name.status]=active&f[view_name.count]=%3E1"
    }
  }


  set: set_details_orders_with_returns {
    fields: [sales_orders_v2.sales_document_vbeln,
             sales_order_item_partner_function_sdt.customer_names_ship_to,
             sales_orders_v2.order_date_as_string,
             set_product*,
             returns_sdt.is_return,
             returns_sdt.return_sales_document_vbeln,
             returns_sdt.return_order_date_as_string,
             sales_orders_v2.total_ordered_quantity,
             returns_sdt.total_quantity_returned
             ]
  }


  set: set_product {
    fields: [sales_orders_v2.material_number_matnr, materials_md.material_text_maktx]
  }

  measure: dummy_set_details_orders_with_returns {
    hidden:yes
    drill_fields: [set_details_orders_with_returns*]
    sql: 1=1 ;;
  }

  measure: dummy_set_product {
    hidden:yes
    drill_fields: [set_product*]
    sql: 1=1 ;;
  }

  measure: dummy_set_product_with_return {
    hidden:yes
    drill_fields: [set_product*,has_return_sales_order_percent]
    sql: 1=1 ;;
  }



  }