include: "/views/base/one_touch_order.view"

######################
# includes a measure that references another view:
#   one_touch_sales_order_percent references sales_orders_v2.sales_order_count and sales_orders_v2.document_category_vbtyp
#
# always join this view in an Explore with sales_orders_v2
# or use fields: parameter to exclude one_touch_sales_order_percent from explore
######################

view: +one_touch_order {
  fields_hidden_by_default: yes

  dimension: key {
    hidden: yes
    primary_key: yes
    sql: concat(${vbapclient_mandt},${vbapsales_document_vbeln},${vbapsales_document_item_posnr}) ;;
  }

  dimension: is_one_touch_order {
    hidden: no
    type: yesno
    sql: ${vbapsales_document_vbeln} is not null ;;
  }

  measure: one_touch_sales_order_count {
    hidden: no
    type: count_distinct
    sql: ${vbapsales_document_vbeln} ;;
    filters: [sales_orders_v2.document_category_vbtyp: "C"]
  }

  measure: one_touch_sales_order_percent {
    hidden: no
    type: number
    sql: safe_divide(${one_touch_sales_order_count},${sales_orders_v2.sales_order_count}) ;;
    value_format_name: percent_1
  }


}