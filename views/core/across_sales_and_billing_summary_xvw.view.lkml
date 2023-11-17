###################
# dimensions and measures that reference views:
#   sales_orders_v2
#   sales_order_item_billing_summary
#   sales_order_item_delivery_summary
###################

view: across_sales_and_billing_summary_xvw {

  label: "Sales Orders"

  dimension: is_order_closed {
    group_label: "Order Status"
    type: yesno
    sql: ${sales_order_item_delivery_summary_ndt.is_order_in_full} = true AND
         ${sales_order_item_billing_summary_sdt.is_order_and_billing_quantity_equal} = true ;;
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

  }
