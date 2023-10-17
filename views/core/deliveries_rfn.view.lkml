include: "/views/base/deliveries.view"

view: +deliveries {
  fields_hidden_by_default: yes

  dimension: key {
    hidden: yes
    primary_key: yes
    sql: concat(${client_mandt},${delivery_vbeln},${delivery_item_posnr}) ;;
  }

#### ID fields
#{
  dimension: client_mandt {
    hidden: yes
    label: "Client MANDT"
  }

  dimension: delivery_vbeln {
    hidden: no
    label: "Delivery VBELN"
  }

  dimension: delivery_item_posnr {
    hidden: no
    view_label: "Delivery Items"
    label: "Delivery Item POSNR"
  }

  dimension: material_number_matnr {
    hidden: no
    view_label: "Delivery Items"
    label: "Material Number MATNR"
  }

  dimension: sales_order_number_vgbel {
    hidden: no
    }

  dimension: sales_order_item_vgpos {
    hidden: no
    }
# } end ID fields

#### Create and Delivery Dates
#{
  dimension_group: date_created_erdat {
    hidden: no
    label: "Creation ERDAT"
    description: "Creation Date ERDAT"
  }

  dimension: create_time_erzet {
    hidden: no
    label: "Creation Time ERZET"
  }

  dimension: create_timestamp {
    hidden: yes
    type: date_time
    label: "Delivery Create Timestamp"
    sql: timestamp(concat(${date_created_erdat_raw},' ',${create_time_erzet})) ;;
  }

  dimension_group: delivery_date_lfdat {
    hidden: no
    label: "Delivery LFDAT"
  }

  dimension: delivery_time_lfuhr {
    hidden: no
    label: "Delivery Time LFUHR"
  }

  dimension_group: date__proof_of_delivery___podat {
    hidden: no
    label: "Proof of Delivery PODAT"
    }

  dimension: proof_of_delivery_timestamp {
    type: date_time
    hidden: no
    sql: timestamp(concat(${date__proof_of_delivery___podat_raw},' ',${confirmation_time_potim})) ;;
  }

  dimension_group: planned_goods_movement_date_wadat {
    hidden: no
    label: "Goods Movement (Planned) WADAT"
    }

  dimension_group: actual_goods_movement_date_wadat_ist {
    label: "Goods Movement (Actual) WADAT IST"
    hidden: no
    }

#} end dates

#### Delivery Statuses: OnTime, Late
#{
  dimension: delivery_type_lfart {
    hidden: no
    label: "Delivery Type LFART"
  }

  # dimension: is_delivered {
  #   hidden: no
  #   type: yesno
  #   sql: ${date__proof_of_delivery___podat_raw} is not null  ;;
  # }

  # dimension: is_on_time {
  #   hidden: no
  #   type: yesno
  #   sql: ${date__proof_of_delivery___podat_raw} <= ${delivery_date_lfdat_raw} and
  #       ${is_delivered};;
  # }

  # dimension: is_late {
  #   hidden: no
  #   type: yesno
  #   sql: ${date__proof_of_delivery___podat_raw} > ${delivery_date_lfdat_raw} and
  #       ${is_delivered};;
  # }

  # dimension: is_return {
  #   #logic in deliveries table/view:
  #   #  IF(likp.VBTYP IN ('H', 'K', 'N', 'O', 'T', '6') OR lips.SHKZG IN ('B', 'S', 'X'), 'X', '')
  #   # replace 'X' with Yes else No
  #   hidden: no
  #   type: yesno
  #   sql: ${TABLE}.IS_RETURN = 'X';;
  # }

  dimension: is_blocked {
    hidden: no
    type: yesno
    sql: (${delivery_block_document_header_lifsk} is not null or
         ${billing_block_in_sd_document_faksk} is not null)
    ;;
  }

#} end delivery statuses



#### Delivery Quantity, Price and Value
#{

  dimension: sd_document_currency_waerk {
    hidden: no
    label: "Currency (Document) WAERK"
  }

  dimension: actual_quantity_delivered_in_sales_units_lfimg {
    hidden: no
    view_label: "Delivery Items"
    label: "Quantity Delivered LFIMG"
    description: "Actual Quantity Delivered in Sales Units LFMIG"
    }

  dimension: net_price_netpr {
    hidden: no
    view_label: "Delivery Items"
    label: "Net Price of Item NETPR"
    description: "Net Price of Item (Document Currency)"
    value_format_name: decimal_2
  }

  dimension: net_value_in_document_currency_netwr {
    hidden: no
    view_label: "Delivery Items"
    label: "Net Value of Item NETWR"
    description: "Net Value of Item (Document Currency)"
  }


#}

  measure: count_delivery_line_items {
    type: count
    hidden: no
    label: "Count of Delivery Line Items"
    description: "Count of Orders & Items"
  }

  measure: count_delivery_vbeln {
    hidden: no
    label: "Count Delivery VBELN"
    description: "Count of Orders (complete and in-progress)"
    type: count_distinct
    sql: ${delivery_vbeln} ;;
  }

  # measure: count_deliveries {
  #   hidden: no
  #   description: "Count of Completed Deliveries"
  #   type: count_distinct
  #   sql: ${delivery_vbeln} ;;
  #   filters: [is_delivered: "Yes"]
  # }

  # measure: count_on_time_deliveries {
  #   hidden: no
  #   type: count_distinct
  #   sql: ${delivery_vbeln} ;;
  #   filters: [is_delivered: "Yes",is_on_time: "Yes"]
  # }

  # measure: count_late_deliveries {
  #   hidden: no
  #   type: count_distinct
  #   sql: ${delivery_vbeln} ;;
  #   filters: [is_delivered: "Yes",is_late: "Yes"]
  # }


  # measure: percent_on_time_deliveries {
  #   hidden: no
  #   label: "Percent On Time Deliveries"
  #   type: number
  #   sql: safe_divide(${count_on_time_deliveries},${count_deliveries}) ;;
  #   value_format_name: percent_1
  # }

  # measure: percent_late_deliveries {
  #   hidden: no
  #   type: number
  #   sql: safe_divide(${count_late_deliveries},${count_deliveries}) ;;
  #   value_format_name: percent_1
  # }

  measure: total_quantity_delivered {
    hidden: no
    type: sum
    sql: ${actual_quantity_delivered_in_sales_units_lfimg} ;;
  }

  measure: min_delivery_date_lfdat {
    hidden: no
    type: date
    sql: min(${delivery_date_lfdat_raw}) ;;
  }

  measure: max_delivery_date_lfdat {
    hidden: no
    type: date
    sql: max(${delivery_date_lfdat_raw}) ;;
  }

  measure: max_proof_of_delivery_date_podat  {
    hidden: no
    type: date_time
    sql: max(${date__proof_of_delivery___podat_raw}) ;;
  }

  measure: max_proof_of_delivery_timestamp  {
    hidden: no
    type: date_time
    sql: max(${proof_of_delivery_timestamp}) ;;
  }

  # measure: test_min_on_time {
  #   hidden: no
  #   type: min
  #   sql: ${is_on_time} ;;
  # }

  # set: fields_for_sales {
  #   fields: [ is_delivered,
  #             is_on_time,
  #             is_late,
  #             is_return,
  #             is_blocked,
  #             count_delivery_vbeln,
  #             count_delivery_line_items,
  #             count_deliveries,
  #             count_on_time_deliveries,
  #             count_late_deliveries,
  #             percent_on_time_deliveries,
  #             percent_late_deliveries,
  #             total_quantity_delivered,
  #             date__proof_of_delivery___podat_date,
  #             proof_of_delivery_timestamp,
  #             delivery_date_lfdat_date,
  #             test_min_on_time
  #             ]
  # }

}
