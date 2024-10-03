include: "/explores/sales_orders_v2.explore.lkml"


view: sales_order_item_delivery_summary_ndt {

  fields_hidden_by_default: yes

  derived_table: {
    explore_source: sales_orders_v2 {
      column: client_mandt {field: sales_orders_v2.client_mandt}
      column: sales_document_vbeln {field: sales_orders_v2.sales_document_vbeln}
      column: document_category_vbtyp { field: sales_orders_v2.document_category_vbtyp}
      column: item_posnr {field: sales_orders_v2.item_posnr}
      column: material_number_matnr { field: sales_orders_v2.material_number_matnr}
      column: is_item_cancelled { field: sales_orders_v2.is_item_cancelled }
      # column: creation_date_erdat_date {field: sales_orders_v2.creation_date_erdat_date}
      column: creation_timestamp { field: sales_orders_v2.creation_timestamp }
      column: requested_delivery_date_vdatu { field: sales_orders_v2.requested_delivery_date_vdatu_raw }
      column: total_quantity_ordered { field: sales_orders_v2.total_quantity_ordered }
      column: total_quantity_delivered { field: deliveries.total_quantity_delivered }
      column: min_delivery_date_lfdat { field: deliveries.min_delivery_date_lfdat }
      column: max_proof_of_delivery_date_podat { field: deliveries.max_proof_of_delivery_date_podat }
      column: max_proof_of_delivery_timestamp { field: deliveries.max_proof_of_delivery_timestamp }
      column: min_actual_goods_movement_date_wadat_ist { field: deliveries.min_actual_goods_movement_date_wadat_ist }

      derived_column: is_order_delivered_in_full {
        sql: min(total_quantity_ordered = total_quantity_delivered) over (partition by  client_mandt, sales_document_vbeln)  ;;
      }
      derived_column: is_order_on_time {
        sql: min(if(max_proof_of_delivery_date_podat is null,null, max_proof_of_delivery_date_podat <= requested_delivery_date_vdatu)) over (partition by  client_mandt, sales_document_vbeln) ;;
      }
      derived_column: is_order_late {
        sql: max(if(max_proof_of_delivery_date_podat is null,null,max_proof_of_delivery_date_podat > requested_delivery_date_vdatu)) over (partition by client_mandt,  sales_document_vbeln) ;;
      }
      derived_column: is_order_delivered {
        sql: min(max_proof_of_delivery_date_podat is not null) over (partition by client_mandt, sales_document_vbeln) ;;
      }
      derived_column: is_order_any_item_delivered {
        sql: max(max_proof_of_delivery_date_podat is not null) over (partition by client_mandt, sales_document_vbeln) ;;
      }

      derived_column: is_order_any_item_cancelled {
        sql: max(is_item_cancelled) over (partition by client_mandt, sales_document_vbeln);;
      }

      derived_column: is_order_cancelled {
        sql:min(is_item_cancelled) over (partition by client_mandt, sales_document_vbeln);;
      }
      # bind_all_filters: yes causes a circular reference if fields based on NDT included as a filter (eg., order_status)
      bind_filters: {from_field:  sales_orders_v2.creation_date_erdat_date
                     to_field:    sales_orders_v2.creation_date_erdat_date}
      bind_filters: {from_field:  countries_md.country_name_landx
                     to_field:    countries_md.country_name_landx}
      bind_filters: {from_field:  sales_organizations_md.sales_org_name_vtext
                     to_field:    sales_organizations_md.sales_org_name_vtext}
      bind_filters: {from_field:  distribution_channels_md.distribution_channel_name_vtext
                     to_field:    distribution_channels_md.distribution_channel_name_vtext}
      bind_filters: {from_field:  divisions_md.division_name_vtext
                     to_field:    divisions_md.division_name_vtext}
      bind_filters: {from_field:  materials_md.material_text_maktx
                     to_field:    materials_md.material_text_maktx}
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

  dimension: document_category_vbtyp {
    type: string
  }

  dimension: item_posnr {
    label: "Item POSNR"
    description: "Item Number"
  }

  dimension: requested_delivery_date_vdatu {
    label: "Requested Delivery Date (VADTU)"
    type: date
  }

  dimension: requested_delivery_date_as_string {
    hidden: yes
    label: "Requested Delivery Date"
    sql: STRING(${requested_delivery_date_vdatu}) ;;
  }

  dimension: material_number_matnr {}

  # dimension: creation_date_erdat_date {
  #   type: date
  # }

  dimension: creation_timestamp {
    hidden: no
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
    hidden: no
    type: date
  }

  dimension: max_proof_of_delivery_date_podat {
    hidden: no
    label: "Max Proof of Delivery Date (PODAT)"
    description: "Line Item's Maximum Proof of Delivery Date PODAT"
    type: date
  }

  dimension: max_proof_of_delivery_date_as_string {
    hidden: yes
    label: "Max Proof of Delivery Date"
    sql: STRING(${max_proof_of_delivery_date_podat}) ;;
  }

  dimension: max_proof_of_delivery_timestamp {
    hidden: no
    description: "Line Item's Maximum Proof of Delivery Date & Time PODAT"
    type: date_time
    sql: timestamp(${TABLE}.max_proof_of_delivery_timestamp) ;;
  }

  dimension: min_actual_goods_movement_date_wadat_ist {
    hidden: no
    description: "Line Item's Maximum Goods Movement Date (WADAT IST)"
    type: date
    sql: ${TABLE}.min_actual_goods_movement_date_wadat_ist ;;
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

  dimension: is_order_delivered_in_full {
    view_label: "Deliveries"
    group_label: "Status"
    hidden: no
    description: "Delivered Quantity equals Ordered Quantity for all items in order"
    type: yesno
    sql: ${TABLE}.is_order_delivered_in_full ;;
  }

  dimension: is_order_on_time {
    view_label: "Deliveries"
    group_label: "Status"
    label: "Is Order On Time (Yes / No)"
    hidden: no
    description: "All items in order have been delivered on time (Proof of Delivery before or on Requested Delivery Date)"
    type: string
    # sql: ${TABLE}.is_order_on_time ;;
    sql: case ${TABLE}.is_order_on_time
            when true then 'Yes'
            when false then 'No'
            when null then null
        end
    ;;
  }

  dimension: is_order_otif {
    view_label: "Deliveries"
    group_label: "Status"
    label: "Is Order OTIF (Yes / No)"
    hidden: no
    type: string
    sql: case when ${TABLE}.is_order_on_time is null then null
              when ${TABLE}.is_order_delivered_in_full = true and ${TABLE}.is_order_on_time = true then 'Yes'
            else 'No'
        end
        ;;
  }


  dimension: is_order_late {
    view_label: "Deliveries"
    group_label: "Status"
    hidden: no
    label: "Is Order Late"
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
    view_label: "Deliveries"
    group_label: "Status"
    description: "All items in order have been delivered with valid Proof of Delivery Date"
    type: yesno
    sql: ${TABLE}.is_order_delivered ;;
  }

  dimension: is_order_any_item_delivered {
    hidden: no
    view_label: "Deliveries"
    group_label: "Status"
    description: "At least 1 item in order has been delivered with valid Proof of Delivery Date"
    type: yesno
    sql: ${TABLE}.is_order_any_item_delivered ;;
  }

  dimension: is_order_any_item_cancelled {
    hidden: no
    view_label: "Deliveries"
    group_label: "Status"
    type: yesno
    description: "At least 1 item in order has been cancelled"
    sql: ${TABLE}.is_order_any_item_cancelled ;;

  }

  dimension: is_order_cancelled {
    hidden: no
    view_label: "Deliveries"
    group_label: "Status"
    description: "All items in order have been cancelled"
    type: yesno
    sql: ${TABLE}.is_order_cancelled ;;
    }

  dimension: item_order_cycle_time {
    view_label: "Delivery Items"
    hidden: no
    label: "Order Cycle Time (Days)"
    sql: case when ${min_actual_goods_movement_date_wadat_ist} is not null then
        timestamp_diff(timestamp(${max_proof_of_delivery_timestamp}),timestamp(${creation_timestamp}),DAY)
        end;;
  }

  dimension: days_late {
    type: number
    sql: date_diff(${max_proof_of_delivery_date_podat},${requested_delivery_date_vdatu},DAY) ;;
  }

  measure: count_orders_delivered {
    type: count_distinct
    view_label: "Deliveries"
    sql: ${sales_document_vbeln} ;;
    filters: [is_order_delivered: "Yes"]
  }

  measure: count_orders_delivered_on_time {
    type: count_distinct
    view_label: "Deliveries"
    sql: ${sales_document_vbeln} ;;
    filters: [is_order_delivered: "Yes",is_order_on_time: "Yes"]
  }

  measure: count_orders_delivered_late {
    type: count_distinct
    view_label: "Deliveries"
    sql: ${sales_document_vbeln} ;;
    filters: [is_order_delivered: "Yes",is_order_late: "Yes"]
  }

  measure: count_orders_delivered_in_full {
    type: count_distinct
    view_label: "Deliveries"
    sql: ${sales_document_vbeln} ;;
    filters: [is_order_delivered: "Yes",is_order_delivered_in_full: "Yes"]
  }

  measure: count_orders_delivered_otif {
    type: count_distinct
    view_label: "Deliveries"
    sql: ${sales_document_vbeln} ;;
    filters: [is_order_delivered: "Yes",is_order_otif: "Yes"]
  }

  # measure: percent_orders_delivered_on_time {
  #   hidden: no
  #   description: "% of orders delivered on time"
  #   type: number
  #   sql: safe_divide(${count_orders_delivered_on_time}, ${count_orders_delivered}) ;;
  #   value_format_name: percent_1
  # }

  # measure: percent_orders_delivered_late {
  #   hidden: no
  #   description: "% of orders delivered late"
  #   type: number
  #   sql: safe_divide(${count_orders_delivered_late}, ${count_orders_delivered}) ;;
  #   value_format_name: percent_1
  # }

  # measure: percent_orders_delivered_in_full {
  #   hidden: no
  #   description: "% of orders delivered in full (delivered quantity equals ordered quantity for all items in order)"
  #   type: number
  #   sql: safe_divide(${count_orders_delivered_in_full}, ${count_orders_delivered}) ;;
  #   value_format_name: percent_1
  # }

  # measure: percent_orders_delivered_otif {
  #   hidden: no
  #   description: "% of orders delivered in full (delivered quantity equals ordered quantity for all items in order)"
  #   type: number
  #   sql: safe_divide(${count_orders_delivered_otif}, ${count_orders_delivered}) ;;
  #   value_format_name: percent_1
  # }

  measure: percent_orders_delivered_on_time {
    hidden: no
    view_label: "Deliveries"
    description: "% of orders delivered on time"
    type: number
    sql: safe_divide(${count_orders_delivered_on_time}, ${sales_orders_v2.sales_order_count}) ;;
    value_format_name: percent_1
  }

  measure: percent_orders_delivered_late {
    hidden: no
    view_label: "Deliveries"
    description: "% of orders delivered late"
    type: number
    sql: safe_divide(${count_orders_delivered_late}, ${sales_orders_v2.sales_order_count}) ;;
    value_format_name: percent_1
    # drill_fields: [material_number_matnr, materials_md.material_text_maktx , percent_orders_delivered_late]
    link: {
      label: "Show Top 10 products with highest Late Delivery Rate"
      url: "{{ dummy_set_product_with_late._link }}&limit=10"
    }

    link: {
      label: "Show Late Orders"
      url: "{{ dummy_set_details_late_deliveries._link}}&f[sales_order_item_delivery_summary_ndt.is_order_late]=Yes"
    }
  }

  measure: percent_orders_delivered_in_full {
    hidden: no
    view_label: "Deliveries"
    description: "% of orders delivered in full (delivered quantity equals ordered quantity for all items in order)"
    type: number
    sql: safe_divide(${count_orders_delivered_in_full}, ${sales_orders_v2.sales_order_count}) ;;
    value_format_name: percent_1
  }

  measure: percent_orders_delivered_otif {
    hidden: no
    view_label: "Deliveries"
    label: "Percent Orders Delivered OTIF"
    description: "% of orders delivered in full (delivered quantity equals ordered quantity for all items in order)"
    type: number
    sql: safe_divide(${count_orders_delivered_otif}, ${sales_orders_v2.sales_order_count}) ;;
    value_format_name: percent_1
  }


  measure: avg_order_cycle_time {
    hidden: no
    type: average
    view_label: "Delivery Items"
    label: "Item Average Cycle Time per Order (Days)"
    description: "Item's Average Cycle Time per Order (Days between Order and Delivery). Must always include Item Number or Name with this measure."
    sql: ${item_order_cycle_time} ;;
    value_format_name: decimal_1
    required_fields: [material_number_matnr]
    ## dynamic capture of filters with link
    link: {
      label: "Show Order Details"
      icon_url: "/favicon.ico"
      url: "
        @{link_build_variable_defaults}
        {% assign link = link_generator._link %}
        {% assign filters_mapping = '@{link_map_otc_sales_orders_to_order_details}' %}

        {% assign model = _model._name %}
        {% assign target_dashboard = _model._name | append: '::otc_order_details' %}

        {% assign default_filters_override = false %}

        @{link_build_dashboard_url}
      "
      }
  }

  measure: sum_total_quantity_delivered {
    hidden: yes
    view_label: "Deliveries"
    label: "Total Quantity Delivered"
    type: sum
    sql: ${total_quantity_delivered} ;;
  }

  measure: max_days_late {
    type: max
    sql: ${days_late} ;;
  }

  set: set_details_late_deliveries {
    fields: [sales_document_vbeln,  sales_order_item_partner_function_sdt.customer_names_ship_to, set_product*, is_order_late, requested_delivery_date_as_string, max_proof_of_delivery_date_as_string, max_days_late, sum_total_quantity_delivered]
  }

  set: set_product {
    fields: [material_number_matnr, materials_md.material_text_maktx]
  }

  measure: dummy_set_details_late_deliveries {
    hidden:yes
    drill_fields: [set_details_late_deliveries*]
    sql: 1=1 ;;
  }

  measure: dummy_set_product {
    hidden:yes
    drill_fields: [set_product*]
    sql: 1=1 ;;
  }

  measure: dummy_set_product_with_late {
    hidden:yes
    drill_fields: [set_product*,percent_orders_delivered_late]
    sql: 1=1 ;;
  }

  measure: link_generator {
    hidden: yes
    type: number
    sql: 1 ;;
    drill_fields: [link_generator]
  }


}
