include: "/views/base/one_touch_order.view"

######################
# includes a measure that references another view:
#   percent_one_touch_orders references sales_orders_v2.count_sales_documents
#
# always join this view in an Explore with sales_orders_v2
# or use fields: parameter to exclude percent_one_touch_orders from explore
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

  measure: count_one_touch_orders {
    hidden: no
    type: count_distinct
    sql: ${vbapsales_document_vbeln} ;;
  }

  measure: percent_one_touch_orders {
    hidden: no
    type: number
    sql: safe_divide(${count_one_touch_orders},${sales_orders_v2.count_sales_documents}) ;;
    value_format_name: percent_1
  }


}
