######################
# SDT sums ConfirmedQuantity_BMENG to Client, SalesDocument_VBLEN and SalesDocumentItem_POSNR level
#
# Includes dimensions/measures that references another view:
#   fill_rate_item      -> sales_orders_v2.cumulative_order_quantity_kwmeng
#   fill_rate           -> sales_orders_v2.cumulative_order_quantity_kwmeng
#   avg_fill_rate_item  -> sales_orders_v2.cumulative_order_quantity_kwmeng
#
# always join this view in an Explore with sales_orders_v2
# or use fields: parameter to exclude these dimensions/measures from the explore
######################



view: sales_order_schedule_line_sdt {
  fields_hidden_by_default: yes


  derived_table: {
    sql: SELECT
              Client_MANDT,
              SalesDocument_VBELN,
              SalesDocumentItem_POSNR,
              COALESCE(SUM(ConfirmedQuantity_BMENG ), 0) AS ConfirmedQuantity_BMENG
          FROM `@{GCP_PROJECT_ID}.@{REPORTING_DATASET}.SalesOrderScheduleLine`
          GROUP BY
              Client_MANDT,
              SalesDocument_VBELN,
              SalesDocumentItem_POSNR ;;
    }

  dimension: key {
    hidden: yes
    primary_key: yes
    sql: concat(${client_mandt},${sales_document_vbeln},${sales_document_item_posnr}) ;;
  }

  dimension: client_mandt {
    hidden: yes
    type: string
    sql: ${TABLE}.Client_MANDT ;;
  }

  dimension: sales_document_vbeln {
    hidden: no
    type: string
    label: "Sales Document VBELN"
    sql: ${TABLE}.SalesDocument_VBELN ;;
  }

  dimension: sales_document_item_posnr {
    hidden: no
    type: string
    label: "Item POSNR"
    sql: ${TABLE}.SalesDocumentItem_POSNR ;;
  }

  dimension: confirmed_quantity_bmeng {
    hidden: no
    type: number
    view_label: "Sales Orders Items"
    label: "Confirmed Quantity BMENG"
    sql: ${TABLE}.ConfirmedQuantity_BMENG ;;
  }

  dimension: fill_rate_item {
    hidden: no
    type: number
    view_label: "Sales Orders Items"
    description: "Fill Rate for Item computed as Confirmed Quantity (BMENG) / Order Quantity (KWMENG)"
    sql: safe_divide(${sales_order_schedule_line_sdt.confirmed_quantity_bmeng}, ${sales_orders_v2.cumulative_order_quantity_kwmeng});;
    value_format_name: percent_1
  }

  dimension: fill_rate_item_nullif0 {
    hidden: no
    type: number
    view_label: "Sales Orders Items"
    description: "Fill Rate for Item computed as Confirmed Quantity (BMENG) / Order Quantity (KWMENG) and applying NULLIF 0 function to both numerator and denominator"
    sql: nullif(${sales_order_schedule_line_sdt.confirmed_quantity_bmeng},0) / nullif(${sales_orders_v2.cumulative_order_quantity_kwmeng},0);;
    value_format_name: percent_1
  }

  measure: total_quantity_confirmed {
    hidden: no
    type: sum
    view_label: "Sales Orders Items"
    sql: ${confirmed_quantity_bmeng} ;;
  }

  measure: fill_rate_total_quantities {
    hidden: no
    type: number
    view_label: "Sales Orders Items"
    description: "Fill Rate computed as Total Quantity Confirmed / Total Quantity Ordered"
    sql: safe_divide(${sales_order_schedule_line_sdt.total_quantity_confirmed},${sales_orders_v2.total_quantity_ordered}) ;;
    value_format_name: percent_1
  }

  measure: avg_fill_rate_item {
    hidden: no
    type: average
    view_label: "Sales Orders Items"
    label: "Average Fill Rate per Order Item"
    description: "Fill Rate computed as Average of Item Fill Rate across all Order Items (using Safe Divide)"
    sql: ${fill_rate_item} ;;
    value_format_name: percent_1
  }

  measure: avg_fill_rate_item_nullif0 {
    hidden: no
    type: average
    view_label: "Sales Orders Items"
    label: "Average Fill Rate per Order Item (using NULLIF 0)"
    sql: ${fill_rate_item_nullif0} ;;
    value_format_name: percent_1
  }


  measure: count {
    hidden: yes
    type: count

  }

  set: fields_for_sales_explore {
    fields: [confirmed_quantity_bmeng,
             fill_rate_item,
             total_quantity_confirmed,
             fill_rate_total_quantities,
             avg_fill_rate_item,
             avg_fill_rate_item_nullif0
            ]
  }


  dimension: is_diff_bmeng_kbmeng {
    hidden: no
    type: yesno
    view_label: "zQA"
    sql: ${sales_orders_v2.cumulative_confirmed_quantity_kbmeng} <> ${sales_order_schedule_line_sdt.confirmed_quantity_bmeng};;
  }

  }