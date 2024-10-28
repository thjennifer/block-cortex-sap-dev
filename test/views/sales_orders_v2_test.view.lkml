include: "/views/core/sales_orders_v2_rfn.view"

view: +sales_orders_v2 {

  #### QA testing stuff
# {

  # dimension: check_sales_order_value_line_item_source_currency {
  #   hidden: no
  #   view_label: "zQA"
  #   type: number
  #   sql: ${cumulative_order_quantity_kwmeng} * ${net_price_netpr} ;;
  # }

  # dimension: is_different_item_value_local_currency {
  #   hidden: no
  #   view_label: "zQA"
  #   type: yesno
  #   sql: ${check_sales_order_value_line_item_source_currency}<>${sales_order_value_line_item_source_currency} ;;
  # }

  # dimension: is_hdr_and_item_currency_different {
  #   hidden: no
  #   view_label: "zQA"
  #   type: yesno
  #   sql: ${currency_waerk}<>${currency_hdr_waerk} ;;
  # }

  # dimension: is_item_netwr_different {
  #   hidden: no
  #   view_label: "zQA"
  #   type: yesno
  #   sql: ${net_price_netwr}<>${sales_order_value_line_item_source_currency} ;;
  # }

  # dimension: net_price_netwr {
  #   hidden: no
  #   view_label: "zQA"
  # }

  # measure: total_sales_order2 {
  #   hidden: no
  #   view_label: "zQA"
  #   type: max
  #   sql: ${net_value_of_the_sales_order_in_document_currency_netwr} ;;
  # }

  # dimension: item_fill_rate {
  #   hidden: no
  #   type: number
  #   view_label: "zQA"
  #   sql: safe_divide(coalesce(${cumulative_confirmed_quantity_kbmeng},0),${cumulative_order_quantity_kwmeng}) ;;
  #   value_format_name: percent_1
  # }

  # measure: avg_item_fill_rate {
  #   hidden: no
  #   type: average
  #   view_label: "zQA"
  #   sql: ${item_fill_rate} ;;
  #   value_format_name: percent_1

  # }




#}

   }
