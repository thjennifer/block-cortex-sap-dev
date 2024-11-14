###################
# dimensions and measures that reference views:
#   sales_orders_v2
#   returns_sdt
###################

view: across_sales_and_returns_xvw {

  label: "Sales Orders Items"

  dimension: key {
    hidden: yes
    primary_key: yes
    sql: concat(${sales_orders_v2.client_mandt},${sales_orders_v2.sales_document_vbeln},${sales_orders_v2.item_posnr}) ;;
  }

  dimension: item_returned_amount_target_currency {
    hidden: no
    type: number
    view_label: "Sales Orders Items"
    label: "Item Billed Amount (Target Currency)@{label_append_sap_code}"
    description: "Item Billed Quantity * Net Price (Target Currency)"
    sql:  ${sales_orders_v2.item_net_price_target_currency_netpr} * ${returns_sdt.return_item_quantity};;
    value_format_name: decimal_2
  }

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
#-->  returns table of 50 items sorted in descending order of has return sales order percent
    link: {
      label: "Show Top 50 Items with Highest Return Rate"
      url: "
      @{link_build_variable_defaults}
      {% assign link = link_generator._link %}
      {% assign drill_fields = 'sales_orders_v2.item_posnr, sales_orders_v2.material_text_maktx, sales_orders_v2.division_name_vtext, across_sales_and_returns_xvw.has_return_sales_order_percent,across_sales_and_returns_xvw.total_returned_amount_target_currency,sales_orders_v2.sales_order_count' %}
      {% assign limit = 50 %}
      {% assign default_filters = 'sales_orders_v2.sales_document_category_type_vbtyp=C,across_sales_and_returns_xvw.has_return_sales_order_percent=%3E%200' %}
      @{link_vis_table}
      @{link_build_explore_url}
      "
    }
#-->  returns table of 50 sold to customers sorted in descending order of has return sales order percent
    link: {
      label: "Show Top 50 Customers with Highest Return Rate"
      url: "
      @{link_build_variable_defaults}
      {% assign link = link_generator._link %}
      {% assign drill_fields = 'sales_orders_v2.sold_to_party_kunnr, sales_orders_v2.customer_name, across_sales_and_returns_xvw.has_return_sales_order_percent,across_sales_and_returns_xvw.total_returned_amount_target_currency,sales_orders_v2.sales_order_count' %}
      {% assign limit = 50 %}
      {% assign default_filters = 'sales_orders_v2.sales_document_category_type_vbtyp=C,across_sales_and_returns_xvw.has_return_sales_order_percent=%3E%200' %}
      @{link_vis_table}
      @{link_build_explore_url}
      "
    }

    link: {
      label: "Show Orders and Lines with Returns"
      url: "
      @{link_build_variable_defaults}
      {% assign link = link_generator._link %}
      {% assign header_drill = 'sales_orders_v2.sales_document_vbeln, sales_orders_v2.document_category_vbtyp, across_sales_and_billing_summary_xvw.order_status_with_symbols, sales_orders_v2.creation_date_erdat_date, sales_orders_v2.customer_name' %}
      {% assign line_drill = 'sales_orders_v2.item_posnr, sales_orders_v2.material_text_maktx,sales_orders_v2.total_ordered_quantity, returns_sdt.total_returned_quantity, sales_orders_v2.base_unit_of_measure_meins,sales_orders_v2.total_sales_amount_target_currency,across_sales_and_returns_xvw.total_returned_amount_target_currency, returns_sdt.is_return' %}
      {% assign drill_fields = header_drill | append: ',' | append: line_drill | append: ',' %}
      {% assign default_filters = 'returns_sdt.is_return=Yes' %}
      {% assign cell_visualization = '\"sales_orders_v2.total_sales_amount_target_currency\":{\"is_active\":true},\"across_sales_and_returns_xvw.total_returned_amount_target_currency\":{\"is_active\":true}' %}
      {% assign sorts='across_sales_and_returns_xvw.total_returned_amount_target_currency+desc,sales_orders_v2.sales_document_vbeln, sales_orders_v2.item_posnr' %}
      @{link_vis_table_assign_cell_visualization}
      @{link_build_explore_url}
      "
    }
  }

# # {% assign cell_visualization = '\"sales_orders__lines.total_sales_amount_target_currency\":{\"is_active\":true},\"sales_orders__lines.total_shipped_amount_target_currency\":{\"is_active\":true}' %}
#   constant: link_vis_table_assign_cell_visualization {
#     value: "{% assign vis_config = '{\"type\":\"looker_grid\",\"series_cell_visualizations\":{' | append: cell_visualization | append: '}}' | url_encode | prepend: '&vis_config=' %}"
#   }
  measure: total_returned_amount_target_currency {
    hidden: no
    type: sum
    label: "@{label_currency_defaults}@{label_currency_field_name}@{label_currency_if_selected}"
    sql: ${item_returned_amount_target_currency} ;;
    value_format_name: decimal_2
  }

  # across_sales_and_billing_summary_xvw.order_status_with_symbols,
  #           deliveries.is_blocked_with_symbols,
  #           sales_orders_v2.sales_document_vbeln,
  #           sales_orders_v2.item_posnr,
  #           sales_orders_v2.material_text_maktx,
  #           sales_order_item_partner_function_sdt.customer_names_sold_to,
  #           sales_order_item_partner_function_sdt.customer_names_ship_to,
  #           sales_order_item_partner_function_sdt.customer_names_bill_to,
  #           sales_orders_v2.creation_date_erdat_date,
  #           sales_orders_v2.requested_delivery_date_vdatu_date,
  #           sales_order_item_delivery_summary_ndt.max_proof_of_delivery_date_podat,
  #           sales_orders_v2.base_unit_of_measure_meins,
  #           sales_orders_v2.currency_hdr_waerk,
  #           sales_orders_v2.target_currency,
  #           sales_orders_v2.exchange_rate_ukurs,
  #           sales_orders_v2.total_ordered_quantity,
  #           sales_order_item_delivery_summary_ndt.total_delivered_quantity,
  #           sales_orders_v2.total_sales_amount_in_source_currency,
  #           sales_orders_v2.total_sales_amount_target_currency


  set: set_details_orders_with_returns {
    fields: [sales_orders_v2.sales_document_vbeln,
             sales_order_item_partner_function_sdt.customer_names_ship_to,
             sales_orders_v2.order_date_as_string,
             set_product*,
             returns_sdt.is_return,
             returns_sdt.return_sales_document_vbeln,
             returns_sdt.return_order_date_as_string,
             sales_orders_v2.total_ordered_quantity,
             returns_sdt.total_returned_quantity
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

#########################################################
# MEASURES: Helper
#{
# Hidden measures used to support url link generation
  measure: link_generator {
    hidden: yes
    type: number
    sql: 1 ;;
    drill_fields: [link_generator]
  }
#} end helper measures


  }
