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
    hidden: no
    label: "Client MANDT"}

  dimension: sales_document_vbeln {
    hidden: no
    label: "Sales Document VBELN"
    description: "Sales Order Number"
    }

  dimension: item_posnr {
    hidden: no
    view_label: "Sales Orders Items"
    label: "Item POSNR"
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

  dimension: document_category_vbtyp {
    hidden: no
    label: "Document Category@{SAP_LABEL}"
    description: "Document Category (C, M, J, etc)"
  }

  # {% if _user_attributes['sap_show_labels'] == 'Yes' %}
  #           {% assign sap_label = _field._name | split:'_' | last | upcase %}
  #           {% else %}{% assign sap_label = '' %}
  #           {% endif %}{{sap_label}}

  dimension: currency_hdr_waerk {
    hidden: no
    label: "Currency (header)"
    description: "SD Document Currency at header level"
  }

  dimension: sales_document_type_auart {
    hidden: no
    label: "Sales Document Type AUART"
  }

  ## don't think this is needed---Total for Sales Order but does not apply Currency Decimal fix like item-level NETWR
  dimension: net_value_of_the_sales_order_in_document_currency_netwr {
    hidden: yes
    label: "Net Value of Sales Order NETWR"
    description: "Net Value of Sales Order in Document Currency"
  }


#### Item Net Price, Quantity and Total Sales Value
# {
  dimension: net_price_netpr {
    hidden: no
    view_label: "Sales Orders Items"
    label: "Net Price of Item NETPR"
    description: "Net Price of Item (Document Currency)"
    value_format_name: decimal_2
  }

  dimension: cumulative_order_quantity_kwmeng {
    hidden: no
    view_label: "Sales Orders Items"
    label: "Order Quantity of Item KWMENG"
  }

  dimension: currency_waerk {
    hidden: no
    view_label: "Sales Orders Items"
    label: "Currency (item)"
    description: "Document Currency at item level"
  }

  dimension: sales_order_value_line_item_source_currency {
    view_label: "Sales Orders Items"
    label: "Net Value of Item NETWR"
    description: "Item Qty * Net Price (Document Currency)"
    hidden: no
  }

  dimension: base_unit_of_measure_meins {
    hidden: no
    view_label: "Sales Orders Items"
    label: "Base Unit of Measure MEINS"
  }

 dimension: sales_unit_vrkme {
    hidden: no
    view_label: "Sales Orders Items"
    label: "Sales Unit VRKME"
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
