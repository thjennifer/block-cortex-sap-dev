include: "/views/core/sales_orders_v2_rfn.view"
include: "/views/core/currency_conversion_sdt.view"
include: "/views/core/shared_parameters_hlp.view"
include: "/views/core/convert_sales_to_target_currency_xvw.view"

explore: sales_orders_v2 {
  label: "Sales Orders"

  sql_always_where: ${client_mandt}='@{CLIENT}'
  ;;

  # and
  #     {% if sales_orders_v2.date_filter._is_filtered %}
  #     {% condition sales_orders_v2.date_filter %} timestamp(${sales_orders_v2.creation_date_erdat_raw}) {% endcondition %}
  #     {% else %}
  #     --filter to last 3 years by default
  #     ${sales_orders_v2.creation_date_erdat_raw} >= date_sub(current_date,interval 10 YEAR)
  #     {% endif %}

  # and {% if currency_conversion_sdt._in_query and sales_orders_v2.date_filter._is_filtered %}
  #     {% condition sales_orders_v2.date_filter %} timestamp(${currency_conversion_sdt.conv_date}) {% endcondition %}
  #     {% elsif currency_conversion_sdt._in_query %}
  #     --filter to last 3 years by default
  #     ${currency_conversion_sdt.conv_date} >= date_sub(current_date,interval 10 YEAR)
  #     {% else %} 1=1
  #     {% endif %}

  join: currency_conversion_sdt {
    type: inner
    relationship: many_to_one
    sql_on: ${sales_orders_v2.client_mandt}=${currency_conversion_sdt.client_mandt}
    and ${sales_orders_v2.currency_waerk}=${currency_conversion_sdt.from_currency_fcurr}
    and ${sales_orders_v2.creation_date_erdat_raw} = ${currency_conversion_sdt.conv_date};;
}

  join: convert_sales_to_target_currency {
    relationship: one_to_one
    sql:  ;;
  }



}
