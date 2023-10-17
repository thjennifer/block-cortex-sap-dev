include: "/explores/sales_orders_v2.explore.lkml"


view: sales_order_item_delivery_summary_ndt {

  fields_hidden_by_default: yes

  derived_table: {
    explore_source: sales_orders_v2 {
      column: client_mandt {field: sales_orders_v2.client_mandt}
      column: sales_document_vbeln {field: sales_orders_v2.sales_document_vbeln}
      column: item_posnr {field: sales_orders_v2.item_posnr}
      column: total_quantity_ordered {}
      column: total_quantity_delivered { field: deliveries.total_quantity_delivered }
      column: min_delivery_date_lfdat { field: deliveries.min_delivery_date_lfdat }
      column: max_proof_of_delivery_date_podat { field: deliveries.max_proof_of_delivery_date_podat }
      derived_column: is_order_in_full {
        sql: min(total_quantity_ordered = total_quantity_delivered) over (partition by  client_mandt, sales_document_vbeln)  ;;
      }
      derived_column: is_order_on_time {
        sql: min(if(max_proof_of_delivery_date_podat is null,null, max_proof_of_delivery_date_podat <= min_delivery_date_lfdat)) over (partition by  client_mandt, sales_document_vbeln) ;;
      }
      derived_column: is_order_late {
        sql: max(if(max_proof_of_delivery_date_podat is null,null,max_proof_of_delivery_date_podat > min_delivery_date_lfdat)) over (partition by client_mandt,  sales_document_vbeln) ;;
      }
      derived_column: is_order_delivered {
        sql: min(max_proof_of_delivery_date_podat is not null) over (partition by client_mandt, sales_document_vbeln) ;;
      }
      derived_column: is_order_any_item_delivered {
        sql: max(max_proof_of_delivery_date_podat is not null) over (partition by client_mandt, sales_document_vbeln) ;;
      }
      bind_all_filters: yes
    }

  }

  dimension: key {
    primary_key: yes
    type: string
    sql: concat(${client_mandt},${sales_document_vbeln},${item_posnr}) ;;
  }

  dimension: client_mandt {}

  dimension: sales_document_vbeln {
    label: "Sales Document VBELN"
    description: "Sales Order Number"
  }
  dimension: item_posnr {
    label: "Item POSNR"
    description: "Item Number"
  }

  dimension: total_quantity_ordered {
    label: "Total Quantity Ordered"
    description: "Line Item Quantity Ordered"
    type: number
  }
  dimension: total_quantity_delivered {
    description: "Line Item Quantity Delivered"
    type: number
  }
  dimension: min_delivery_date_lfdat {
    description: "Line Item's Minimum Delivery Date LFDAT"
    type: number
  }
  dimension: max_proof_of_delivery_date_podat {
    description: "Line Item's Maximum Proof of Delivery Date PODAT"
    type: number
  }

  # dimension: is_item_delivered {
  #   type: yesno
  #   sql: ${max_proof_of_delivery_date_podat} is not null ;;
  # }

  # dimension: is_item_in_full {
  #   type: yesno
  #   sql: ${total_quantity_delivered} = ${total_quantity_ordered} ;;
  # }

  # dimension: is_item_on_time {
  #   type: yesno
  #   sql: ${max_proof_of_delivery_date_podat} <= ${min_delivery_date_lfdat} ;;
  # }

  # dimension: is_item_late {
  #   type: yesno
  #   sql: ${max_proof_of_delivery_date_podat} > ${min_delivery_date_lfdat} ;;
  # }

  dimension: is_order_in_full {
    hidden: no
    description: "Delivered Quantity equals Ordered Quantity for all items in order"
    type: yesno
    sql: ${TABLE}.is_order_in_full ;;
  }

  dimension: is_order_on_time {
    label: "Is Order On Time (Yes / No)"
    hidden: no
    description: "All items in order have been delivered on time (Proof of Delivery before or on Requested Delivery Date)"
    type: string
    sql: case ${TABLE}.is_order_on_time
            when true then 'Yes'
            when false then 'No'
            when null then null
        end
    ;;
  }

  dimension: is_order_otif {
    label: "Is Order OTIF (Yes / No)"
    hidden: no
    type: string
    sql: case when ${TABLE}.is_order_on_time is null then null
              when ${TABLE}.is_order_in_full = true and ${TABLE}.is_order_on_time = true then 'Yes'
            else 'No'
        end
        ;;
  }


  dimension: is_order_late {
    hidden: no
    label: "Is Order Late (Yes / No)"
    description: "At least 1 item in order has been delivered late (Proof of Delivery after Requested Delivery Date)"
    type: string
    sql: case ${TABLE}.is_order_late
            when true then 'Yes'
            when false then 'No'
            when null then null
        end
      ;;
  }

  dimension: is_order_delivered {
    hidden: no
    description: "All items in order have been delivered with valid Proof of Delivery Date"
    type: yesno
    sql: ${TABLE}.is_order_delivered ;;
  }

  dimension: is_order_any_item_delivered {
    hidden: no
    description: "At least 1 item in order has been delivered with valid Proof of Delivery Date"
    type: yesno
    sql: ${TABLE}.is_order_any_item_delivered ;;
  }

  measure: count_orders_delivered {
    type: count_distinct
    sql: ${sales_document_vbeln} ;;
    filters: [is_order_delivered: "Yes"]
  }

  measure: count_orders_delivered_on_time {
    type: count_distinct
    sql: ${sales_document_vbeln} ;;
    filters: [is_order_delivered: "Yes",is_order_on_time: "Yes"]
  }

  measure: count_orders_delivered_late {
    type: count_distinct
    sql: ${sales_document_vbeln} ;;
    filters: [is_order_delivered: "Yes",is_order_late: "Yes"]
  }

  measure: count_orders_delivered_in_full {
    type: count_distinct
    sql: ${sales_document_vbeln} ;;
    filters: [is_order_delivered: "Yes",is_order_in_full: "Yes"]
  }

  measure: count_orders_delivered_otif {
    type: count_distinct
    sql: ${sales_document_vbeln} ;;
    filters: [is_order_delivered: "Yes",is_order_otif: "Yes"]
  }

  measure: percent_orders_delivered_on_time {
    hidden: no
    description: "% of orders delivered on time"
    type: number
    sql: safe_divide(${count_orders_delivered_on_time}, ${count_orders_delivered}) ;;
    value_format_name: percent_1
  }

  measure: percent_orders_delivered_late {
    hidden: no
    description: "% of orders delivered late"
    type: number
    sql: safe_divide(${count_orders_delivered_late}, ${count_orders_delivered}) ;;
    value_format_name: percent_1
  }

  measure: percent_orders_delivered_in_full {
    hidden: no
    description: "% of orders delivered in full (delivered quantity equals ordered quantity for all items in order)"
    type: number
    sql: safe_divide(${count_orders_delivered_in_full}, ${count_orders_delivered}) ;;
    value_format_name: percent_1
  }

  measure: percent_orders_delivered_otif {
    hidden: no
    description: "% of orders delivered in full (delivered quantity equals ordered quantity for all items in order)"
    type: number
    sql: safe_divide(${count_orders_delivered_otif}, ${count_orders_delivered}) ;;
    value_format_name: percent_1
  }

}
