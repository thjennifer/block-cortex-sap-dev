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

  # dimension: item_net_price_target_currency_netpr {
  #   hidden: no
  #   type: number
  #   view_label: "Sales Orders Items"
  #   label: "Item Price (Target Currency) NETPR"
  #   description: "Net Price of Item (Target Currency)"
  #   sql: ${sales_orders_v2.net_price_netpr} * ${currency_conversion_sdt.exchange_rate_ukurs} ;;
  #   value_format_name: decimal_2
  # }

  # dimension: item_net_value_target_currency_netwr {
  #   hidden: no
  #   type: number
  #   view_label: "Sales Orders Items"
  #   label: "Item Sales (Target Currency) NETWR"
  #   description: "Item Qty * Net Price (Target Currency)"
  #   sql:  ${item_net_price_target_currency_netpr} * ${sales_orders_v2.cumulative_order_quantity_kwmeng};;
  #   value_format_name: decimal_2

  # }

  # measure: total_sales_amount_target_currency {
  #   hidden: no
  #   type: sum
  #   view_label: "Sales Orders"
  #   label: "@{label_currency}Total Sales ({{currency}})"
  #   sql: ${item_net_value_target_currency_netwr} ;;
  #   filters: [sales_orders_v2.document_category_vbtyp: "C"]
  #   value_format_name: decimal_2
  #   sql_distinct_key: ${sales_orders_v2.key};;
  #   link: {
  #     label: "Show Orders"
  #     url: "{{ dummy_set_details_sales_performance._link}}"
  #     # &f[sales_order_item_delivery_summary_ndt.is_order_late]=Yes"
  #   }
  # }

  # measure: total_sales_amount_target_currency_formatted {
  #   hidden: no
  #   type: number
  #   view_label: "Sales Orders"
  #   label: "@{label_currency}Total Sales ({{currency}}) Formatted"
  #   sql: ${total_sales_amount_target_currency} ;;
  #   value_format_name: format_large_numbers_d1
  #   # sql_distinct_key: ${sales_orders_v2.key};;
  #   link: {
  #     label: "Show Orders"
  #     url: "{{ dummy_set_details_sales_performance._link}}"
  #     # &f[sales_order_item_delivery_summary_ndt.is_order_late]=Yes"
  #   }
  # }

  # measure: avg_sales_per_order_target_currency {
  #   hidden: no
  #   type: number
  #   view_label: "Sales Orders"
  #   label: "@{label_currency}Average Sales per Order ({{currency}})"
  #   sql: safe_divide(${total_sales_amount_target_currency},${sales_orders_v2.sales_order_count});;
  #   # sql_distinct_key: ${sales_orders_v2.key};;
  #   value_format_name: "format_large_numbers_d1"
  #   link: {
  #     label: "Show Orders"
  #     url: "{{ dummy_set_details_sales_performance._link}}"
  #     # &f[sales_order_item_delivery_summary_ndt.is_order_late]=Yes"
  #   }

  #   ## dynamic capture of filters with link
  #   # link: {
  #   #   label: "Open Order Details Dashboard"
  #   #   icon_url: "/favicon.ico"
  #   #   url: "
  #   #   @{link_build_variable_defaults}
  #   #   {% assign link = link_generator._link %}
  #   #   {% assign filters_mapping = '@{link_map_otc_sales_orders_to_order_details}' | append: '||across_sales_and_billing_summary_xvw.order_status|Order Status||deliveries.is_blocked|Is Blocked' %}

  #   #   {% assign model = _model._name %}
  #   #   {% assign target_dashboard = _model._name | append: '::otc_order_details' %}

  #   #   {% assign default_filters_override = false %}

  #   #   @{link_build_dashboard_url}
  #   #   "
  #   # }

  # }

  # # measure: test_avg {
  # #   hidden: no
  # #   type: average_distinct
  # #   view_label: "Sales Orders"
  # #   sql: ${item_net_price_target_currency_netpr} ;;
  # #   sql_distinct_key: ${sales_orders_v2.key};;
  # # }

  # measure: percent_of_total_sales_amount_target_currency {
  #   hidden: no
  #   view_label: "Sales Orders"
  #   label: "Percent of Total Sales (Target Currency)"
  #   type: percent_of_total
  #   sql: ${total_sales_amount_target_currency} ;;
  #   # sql_distinct_key: ${sales_orders_v2.key};;
  # }

  # set: set_details_sales_performance {
  #   fields: [sales_orders_v2.sales_document_vbeln,
  #           set_product*,
  #           sales_order_item_partner_function_sdt.customer_names_sold_to,
  #           sales_organizations_md.sales_org_name_vtext,
  #           distribution_channels_md.distribution_channel_name_vtext,
  #           divisions_md.division_name_vtext,
  #           sales_orders_v2.order_date_as_string,
  #           sales_orders_v2.total_quantity_ordered,
  #           total_sales_amount_target_currency,
  #           sales_orders_v2.base_unit_of_measure_meins

  #           ]
  # }


  set: set_product {
    fields: [sales_orders_v2.material_number_matnr, materials_md.material_text_maktx]
  }

  # measure: dummy_set_details_sales_performance {
  #   hidden:yes
  #   drill_fields: [set_details_sales_performance*]
  #   sql: 1=1 ;;
  # }

  # measure: dummy_set_product {
  #   hidden:yes
  #   drill_fields: [set_product*]
  #   sql: 1=1 ;;
  # }

  # measure: dummy_set_product_with_late {
  #   hidden:yes
  #   drill_fields: [set_product*,percent_orders_delivered_late]
  #   sql: 1=1 ;;
  # }

  measure: link_generator {
    hidden: yes
    type: number
    sql: 1 ;;
    drill_fields: [link_generator]
  }

}