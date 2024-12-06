###################
# dimensions and measures that reference views:
#   sales_orders_v2
#   deliveries
#
###################

view: across_sales_and_deliveries_xvw {

  measure: fill_rate_using_deliveries {
    type: number
    sql: safe_divide(${deliveries.total_delivered_quantity},${sales_orders_v2.total_ordered_quantity}) ;;
    value_format_name: percent_1
  }

  measure: blocked_order_count {
    hidden: no
    type: count_distinct
    description: "Count of orders with a least one item blocked in delivery or billing"
    sql:  ${sales_orders_v2.sales_document_vbeln};;
    filters: [deliveries.is_blocked: "Yes"]
#--> opens order line details with filter is blocked = Yes
    link: {
      label: "Order Line Details"
      icon_url: "/favicon.ico"
      url: "
        @{link_build_variable_defaults}
        {% assign link = link_generator._link %}
        {% assign source_to_destination_filters_mapping = '@{link_map_otc_sales_orders_to_order_details}'%}
        @{link_map_otc_target_dash_id_order_details}
        {% assign default_filters='is_blocked=Yes'%}
        {% assign use_default_filters_to_override = true %}
        @{link_build_dashboard_url}
      "
    }
#--> returns table showing blocked order count and percent of total by has_backorder and is_held
    link: {
      label: "Show Sources of Blocks"
      url: "
      @{link_build_variable_defaults}
      {% assign link = link_generator._link %}
      {% assign drill_fields = 'deliveries.is_blocked_in_delivery, deliveries.is_blocked_in_billing, sales_orders_v2.sales_order_count, sales_orders_v2.percent_of_sales_orders' %}
      {% assign default_filters = 'deliveries.is_blocked=Yes' %}
      @{link_vis_table}
      @{link_build_explore_url}
      "
    }
#--> returns table of blocked orders
    link: {
      label: "Show Blocked Orders"
      url: "
      @{link_build_variable_defaults}
      {% assign link = link_generator._link %}
      {% assign drill_fields = 'sales_orders_v2.sales_document_vbeln, sales_orders_v2.document_category_vbtyp, across_sales_and_billing_summary_xvw.order_status_with_symbols, sales_orders_v2.creation_date_erdat_date, sales_orders_v2.customer_name, sales_orders_v2.total_sales_amount_target_currency, deliveries.is_blocked_in_delivery, deliveries.is_blocked_in_billing' %}
      {% assign default_filters = 'deliveries.is_blocked=Yes' %}
      {% assign sorts = 'sales_orders_v2.total_sales_amount_target_currency+desc' %}
      @{link_vis_table}
      @{link_build_explore_url}
      "
    }
  }

  measure: count_blocked_order_items {
    hidden: no
    type: count_distinct
    sql:  concat(${sales_orders_v2.sales_document_vbeln},${sales_orders_v2.item_posnr});;
    filters: [deliveries.is_blocked: "Yes"]
  }

  measure: difference_order_qty_delivery_qty {
    type: number
    sql: ${sales_orders_v2.total_ordered_quantity} - ${deliveries.total_delivered_quantity};;
    value_format_name: decimal_0
#--> returns a table listing order lines sorted in descending order by difference between ordered and fulfilled quantity, ordered amount and ordered date
    link: {
      label: "Show Orders with Differences"
      url: "
      @{link_build_variable_defaults}
      {% assign link = link_generator._link %}
      {%- assign header_drill = 'sales_orders_v2.sales_document_vbeln,
        sales_orders_v2.document_category_vbtyp,
        across_sales_and_billing_summary_xvw.order_status_with_symbols,
        sales_orders_v2.creation_date_erdat_date,
        sales_orders_v2.customer_name' -%}
      {%- assign line_drill = 'sales_orders_v2.item_posnr,
        sales_orders_v2.material_text_maktx,
        sales_orders_v2.base_unit_of_measure_mein,
        sales_orders_v2.total_ordered_quantity,
        deliveries.total_delivered_quantity,
        across_sales_and_deliveries_xvw.difference_order_qty_delivery_qty' -%}
      {% assign drill_fields = header_drill | append: ',' | append: line_drill %}
      {% assign sorts = 'across_sales_and_deliveries_xvw.difference_order_qty_delivery_qty+desc,sales_orders_v2.creation_date_erdat_date+desc' %}
      {% assign cell_visualization = '\"across_sales_and_deliveries_xvw.difference_order_qty_delivery_qty\":{\"is_active\":true}' %}
      @{link_vis_table_assign_cell_visualization}
      @{link_build_explore_url}
      "
    }
  }

  # {% assign line_drill = 'sales_orders_v2.item_posnr, sales_orders_v2.material_text_maktx,sales_orders_v2.total_ordered_quantity, returns_sdt.total_returned_quantity, sales_orders_v2.base_unit_of_measure_meins,sales_orders_v2.total_sales_amount_target_currency,across_sales_and_returns_xvw.total_returned_amount_target_currency, returns_sdt.is_return' %}
  #     {% assign drill_fields = header_drill | append: ',' | append: line_drill | append: ',' %}
  #     {% assign default_filters = 'returns_sdt.is_return=Yes' %}
  #     {% assign cell_visualization = '\"sales_orders_v2.total_sales_amount_target_currency\":{\"is_active\":true},\"across_sales_and_returns_xvw.total_returned_amount_target_currency\":{\"is_active\":true}' %}
  #     {% assign sorts='across_sales_and_returns_xvw.total_returned_amount_target_currency+desc,sales_orders_v2.sales_document_vbeln, sales_orders_v2.item_posnr' %}
  #     @{link_vis_table_assign_cell_visualization}
  #     @{link_build_explore_url}

  measure: difference_delivery_qty_order_qty {
    type: number
    sql:  ${deliveries.total_delivered_quantity} - ${sales_orders_v2.total_ordered_quantity};;
    value_format_name: decimal_0
  }

  measure: percent_difference_order_qty_delivery_qty {
    type: number
    sql: 1 - safe_divide(${deliveries.total_delivered_quantity},${sales_orders_v2.total_ordered_quantity});;
    value_format_name: percent_1
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
