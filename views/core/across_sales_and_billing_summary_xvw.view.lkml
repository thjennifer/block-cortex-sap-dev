###################
# dimensions and measures that reference views:
#   sales_orders_v2
#   sales_order_item_billing_summary
#   sales_order_item_delivery_summary
###################

view: across_sales_and_billing_summary_xvw {

  label: "Sales Orders"

 dimension: key {
  primary_key: yes
  sql: concat(${sales_orders_v2.client_mandt},${sales_orders_v2.sales_document_vbeln},${sales_orders_v2.item_posnr}) ;;
  }

  dimension: is_order_closed {
    group_label: "Order Status"
    type: yesno
    sql: ${sales_order_item_delivery_summary_ndt.is_order_delivered_in_full} = true AND
         ${sales_order_item_billing_summary_sdt.is_order_billed_in_full} = true ;;
  }

  dimension: order_status {
    group_label: "Order Status"
    type: string
    sql:  case when ${sales_order_item_delivery_summary_ndt.is_order_any_item_cancelled} = true then "Cancelled"
               when ${is_order_closed} = true then "Closed"
               when ${is_order_closed} = false then "Open"

          end ;;
  }

  dimension: order_status_with_symbols {
    group_label: "Order Status"
    type: string
    sql: ${order_status} ;;
    html: {% if value == "Open" %}{%assign sym = "〇" %}{% assign color = "#98B6B1" %}
          {% elsif value == "Closed" %}{%assign sym = "◉"%}{% assign color = "#BFBDC1" %}
          {% elsif value == "Cancelled" %}{%assign sym = "X"%}{% assign color = "#EB9486" %}
            {% else %}
             {%assign sym = "" %}{% assign color = "#080808" %}
            {%endif%}<p style="color: {{color}}"><b> {{sym}} {{value}}</b> </p>;;
  }

  dimension: item_billed_amount_target_currency {
    hidden: no
    type: number
    view_label: "Sales Orders Items"
    label: "Item Billed Amount (Target Currency)@{label_append_sap_code}"
    description: "Item Billed Quantity * Net Price (Target Currency)"
    sql:  ${sales_orders_v2.item_net_price_target_currency_netpr} * ${sales_order_item_billing_summary_sdt.billing_quantity};;
    value_format_name: decimal_2
  }

  dimension: item_delivered_amount_target_currency {
    hidden: no
    type: number
    view_label: "Sales Orders Items"
    label: "Item Billed Amount (Target Currency)@{label_append_sap_code}"
    description: "Item Delivered Quantity * Net Price (Target Currency)"
    sql:  ${sales_orders_v2.item_net_price_target_currency_netpr} * ${sales_order_item_delivery_summary_ndt.item_delivered_quantity};;
    value_format_name: decimal_2
  }

  measure: max_order_status {
    type: string
    sql: max(${order_status}) ;;
  }

#########################################################
# MEASURES: Amounts in Target Currency
#{
  measure: total_billed_amount_target_currency {
    hidden: no
    type: sum
    view_label: "Sales Orders Items"
    # label: "@{label_currency}Total Sales Amount ({{currency}})"
    label: "@{label_currency_defaults}@{label_currency_field_name}@{label_currency_if_selected}"
    sql: ${item_billed_amount_target_currency} ;;
    # sql_distinct_key: ${sales_orders_v2.key} ;;
    value_format_name: decimal_2
  }

  measure: total_billed_amount_target_currency_formatted {
    hidden: no
    type: number
    view_label: "Sales Orders Items"
    label: "@{label_currency_defaults}@{label_currency_field_name}@{label_currency_if_selected}"
    # label: "@{label_currency}Total Sales ({{currency}}) Formatted"
    sql: ${total_billed_amount_target_currency} ;;
    value_format_name: format_large_numbers_d1
  }

  measure: total_delivered_amount_target_currency {
    hidden: no
    type: sum
    view_label: "Sales Orders Items"
    # label: "@{label_currency}Total Sales Amount ({{currency}})"
    label: "@{label_currency_defaults}@{label_currency_field_name}@{label_currency_if_selected}"
    sql: ${item_delivered_amount_target_currency} ;;
    # sql_distinct_key: ${sales_orders_v2.key} ;;
    value_format_name: decimal_2
  }

  measure: total_delivered_amount_target_currency_formatted {
    hidden: no
    type: number
    view_label: "Sales Orders Items"
    label: "@{label_currency_defaults}@{label_currency_field_name}@{label_currency_if_selected}"
    # label: "@{label_currency}Total Sales ({{currency}}) Formatted"
    sql: ${total_delivered_amount_target_currency} ;;
    value_format_name: format_large_numbers_d1
  }

#} end amounts in target currency

  }
