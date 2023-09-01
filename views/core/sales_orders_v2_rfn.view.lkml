include: "/views/base/sales_orders_v2.view"

view: +sales_orders_v2 {
  view_label: "Sales Orders"

  fields_hidden_by_default: yes

  dimension: key {
    type: string
    primary_key: yes
    sql: CONCAT(${client_mandt},${sales_document_vbeln},${item_posnr});;
  }

#### ID fields
# {

  dimension: client_mandt {
    hidden: yes
    label: "Client@{SAP_LABEL}"}

  dimension: sales_document_vbeln {
    hidden: no
    label: "Sales Document@{SAP_LABEL}"
    description: "Sales Order Number"
    }

  dimension: item_posnr {
    hidden: no
    view_label: "Sales Orders Items"
    label: "Item@{SAP_LABEL}"
    description: "Item Number"
  }

#}

#### Filters & Parameters
#{

  # filter: date_filter {
  #   hidden: no
  #   view_label: "Filters"
  #   type: date
  #   # for tables partitioned by date capture start and end dates and apply as a templated filter
  #   # in the Explore's sql_always_where statement
  # }

#}

#### Dates & Times
#{
  dimension_group: creation_date_erdat {
    hidden: no
    label: "Creation ERDAT"
    description: "Sales Order Creation Date ERDAT"
  }

  dimension: creation_time_erzet {
    hidden: no
    label: "Creation Time ERZET"
    type: string
    sql: ${TABLE}.CreationTime_ERZET ;;
  }

  dimension_group: requested_delivery_date_vdatu {
    hidden: no
    label: "Requested Delivery VDATU"
    description: "Requested Delivery Date VDATU"
  }
#} end dates & times

#### Types, Categories and other Document Groupings
#{

  dimension: sales_document_type_auart {
    hidden: no
    label: "Sales Document Type@{SAP_LABEL}"
  }

  dimension: document_category_vbtyp {
    hidden: no
    label: "Sales Document Category@{SAP_LABEL}"
    description: "Document Category (C, M, J, etc)"
  }

  dimension: sales_organization_vkorg {
    hidden: no
    label: "Sales Organization@{SAP_LABEL}"
  }

  dimension: distribution_channel_vtweg {
    hidden: no
    label: "Distribution Channel@{SAP_LABEL}"
  }

  dimension: division_hdr_spart {
    hidden: no
    label: "Division (header)@{SAP_LABEL}"
  }

  dimension: sales_group_vkgrp {
    hidden: no
    label: "Sales Group@{SAP_LABEL}"
    }

  dimension: sales_office_vkbur {
    hidden: no
    label: "Sales Office@{SAP_LABEL}"
  }

  dimension: cost_center_hdr_kostl {
    hidden: no
    label: "Cost Center (header)@{SAP_LABEL}"
  }

  dimension: currency_hdr_waerk {
    hidden: no
    label: "Currency (header)@{SAP_LABEL}"
    description: "SD Document Currency at header level"
  }

  #}


  #### Customer dimensions

  dimension: sold_to_party_kunnr {
    hidden: no
    label: "Sold to Party@{SAP_LABEL}"
  }

  ## don't think this is needed---Total for Sales Order but does not apply Currency Decimal fix like item-level NETWR
  dimension: net_value_of_the_sales_order_in_document_currency_netwr {
    hidden: yes
    label: "Net Value of Sales Order@{SAP_LABEL}"
    description: "Net Value of Sales Order in Document Currency"
  }


#### Item Net Price, Quantity and Total Sales Value
# {
  dimension: net_price_netpr {
    hidden: no
    view_label: "Sales Orders Items"
    label: "Net Price of Item@{SAP_LABEL}"
    description: "Net Price of Item (Document Currency)"
    value_format_name: decimal_2
  }

  dimension: cumulative_order_quantity_kwmeng {
    hidden: no
    view_label: "Sales Orders Items"
    label: "Order Quantity of Item@{SAP_LABEL}"
  }

  dimension: currency_waerk {
    hidden: yes
    view_label: "Sales Orders Items"
    label: "Currency (item)"
    description: "Document Currency at item level"
  }

  dimension: sales_order_value_line_item_source_currency {
    view_label: "Sales Orders Items"
    label: "Net Value of Item@{SAP_LABEL}"
    description: "Item Qty * Net Price (Document Currency)"
    hidden: no
  }

  dimension: base_unit_of_measure_meins {
    hidden: no
    view_label: "Sales Orders Items"
    label: "Base Unit of Measure@{SAP_LABEL}"
  }

 dimension: sales_unit_vrkme {
    hidden: no
    view_label: "Sales Orders Items"
    label: "Sales Unit@{SAP_LABEL}"
    }

# }

  measure: count {
    hidden: no
    label: "Count Order Items"
    description: "Count of Orders & Items"
    }

  measure: count_orders {
    hidden: no
    type: count_distinct
    description: "Count of Sales Document VBELN when Document Category VBTYP = C"
    sql: ${sales_document_vbeln} ;;
    filters: [document_category_vbtyp: "C"]
  }

  measure: total_net_value {
    hidden: no
    type: sum
    label: "Total Net Value"
    description: "Total Net Value (Document Currency)"
    sql: ${sales_order_value_line_item_source_currency} ;;
    value_format_name: "format_large_numbers_d1"
  }

  measure: total_quantity {
    hidden: no
    type: sum
    label: "Total Quantity"
    sql: ${cumulative_order_quantity_kwmeng} ;;
  }

  measure: count_customers {
    hidden: no
    type: count_distinct
    description: "Total Customer Count (disctinct count of Sold to Party KUNNR)"
    sql: ${sold_to_party_kunnr} ;;
  }


#### QA testing stuff
# {

  dimension: check_sales_order_value_line_item_source_currency {
    hidden: no
    view_label: "zQA"
    type: number
    sql: ${cumulative_order_quantity_kwmeng} * ${net_price_netpr} ;;
  }

  dimension: is_different_item_value_local_currency {
    hidden: no
    view_label: "zQA"
    type: yesno
    sql: ${check_sales_order_value_line_item_source_currency}<>${sales_order_value_line_item_source_currency} ;;
  }

  dimension: is_hdr_and_item_currency_different {
    hidden: no
    view_label: "zQA"
    type: yesno
    sql: ${currency_waerk}<>${currency_hdr_waerk} ;;
  }

  dimension: is_item_netwr_different {
    hidden: no
    view_label: "zQA"
    type: yesno
    sql: ${net_price_netwr}<>${sales_order_value_line_item_source_currency} ;;
  }

  dimension: net_price_netwr {
    hidden: no
    view_label: "zQA"
  }

  measure: total_sales_order2 {
    hidden: no
    view_label: "zQA"
    type: max
    sql: ${net_value_of_the_sales_order_in_document_currency_netwr} ;;
  }



#}



  }
