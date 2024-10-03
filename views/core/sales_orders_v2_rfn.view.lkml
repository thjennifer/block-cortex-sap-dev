#########################################################{
# PURPOSE
# provides Sales Order Line Items (both Header and Line Items)
#
# SOURCE
# Refines view sales_orders_v2
#
# REFERENCED BY
# Explore sales_orders_v2
#
# DERIVED DIMENSIONS
# creation_timestamp
#
# KEYS TO USING
#   - Fields are hidden by default so must change "hidden" property to "no" to include field in an Explore
#   - This refinement view only includes fields added or edited. Full list of fields available are found in the base view
#   - Header-level dimensions and measures shown in Explore under view Label Sales Orders
#   - Item-level dimensions and measures shown in Explore under view label Sales Orders Items
#
#########################################################}

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
    label: "Client@{label_sap_code}"}

  dimension: sales_document_vbeln {
    hidden: no
    label: "Sales Document@{label_sap_code}"
    description: "Sales Order Number"
    }

  dimension: item_posnr {
    hidden: no
    view_label: "Sales Orders Items"
    label: "Item@{label_sap_code}"
    description: "Item Number"
  }

#}

#### Filters & Parameters
#{

  filter: date_filter {
    hidden: no
    view_label: "🔍 Filters & 🛠 Tools"
    type: date
    # for tables partitioned by date capture start and end dates and apply as a templated filter
    # in the Explore's sql_always_where statement
  }

#}

#### Header Dates & Times
#{
  dimension_group: creation_date_erdat {
    hidden: no
    label: "Creation ERDAT"
    description: "Sales Order Creation Date ERDAT"
  }

  dimension: order_date_as_string {
    label: "Order Date"
    hidden: no
    type: string
    sql: STRING(${creation_date_erdat_raw}) ;;
  }

  dimension: creation_time_erzet {
    hidden: no
    label: "Creation Time ERZET"
    type: string
    sql: ${TABLE}.CreationTime_ERZET ;;
  }

  dimension: creation_timestamp {
    hidden: yes
    sql: timestamp(concat(${creation_date_erdat_raw},' ',${creation_time_erzet})) ;;
  }

  dimension_group: requested_delivery_date_vdatu {
    hidden: no
    label: "Requested Delivery VDATU"
    description: "Requested Delivery Date VDATU"
  }
#} end dates & times

#### Header Sold to Party, Type, Category, Distribution Channel and other Document Attributes
#{

  dimension: sold_to_party_kunnr {
    hidden: no
    label: "Sold to Party@{label_sap_code}"
  }

  dimension: sales_document_type_auart {
    hidden: no
    label: "Sales Document Type@{label_sap_code}"
  }

  dimension: document_category_vbtyp {
    hidden: no
    label: "Sales Document Category@{label_sap_code}"
    description: "Document Category (C, M, J, etc)"
  }

  dimension: sales_organization_vkorg {
    hidden: no
    label: "Sales Organization@{label_sap_code}"
  }

  dimension: distribution_channel_vtweg {
    hidden: no
    label: "Distribution Channel@{label_sap_code}"
  }

  dimension: division_hdr_spart {
    hidden: no
    label: "Division (header)@{label_sap_code}"
  }

  dimension: sales_group_vkgrp {
    hidden: no
    label: "Sales Group@{label_sap_code}"
    }

  dimension: sales_office_vkbur {
    hidden: no
    label: "Sales Office@{label_sap_code}"
  }

  dimension: cost_center_hdr_kostl {
    hidden: no
    label: "Cost Center (header)@{label_sap_code}"
  }

  dimension: currency_hdr_waerk {
    hidden: no
    label: "Currency (header)@{label_sap_code}"
    description: "SD Document Currency at header level"
  }


  #}


#### Item Net Price, Quantity and Total Sales Value
# {
  dimension: net_price_netpr {
    hidden: no
    view_label: "Sales Orders Items"
    label: "Item Price (Document Currency)@{label_sap_code}"
    description: "Net Price of Item (Document Currency)"
    value_format_name: decimal_2
  }

  dimension: item_net_price_target_currency_netpr {
    hidden: no
    type: number
    view_label: "Sales Orders Items"
    label: "Item Price (Target Currency) NETPR"
    description: "Net Price of Item (Target Currency)"
    sql: ${sales_orders_v2.net_price_netpr} * ${currency_conversion_sdt.exchange_rate_ukurs} ;;
    value_format_name: decimal_2
  }

  dimension: item_net_value_target_currency_netwr {
    hidden: no
    type: number
    view_label: "Sales Orders Items"
    label: "Item Sales (Target Currency) NETWR"
    description: "Item Qty * Net Price (Target Currency)"
    sql:  ${item_net_price_target_currency_netpr} * ${cumulative_order_quantity_kwmeng};;
    value_format_name: decimal_2

  }

  dimension: cumulative_order_quantity_kwmeng {
    hidden: no
    view_label: "Sales Orders Items"
    label: "Order Quantity of Item@{label_sap_code}"
  }

  dimension: cumulative_confirmed_quantity_kbmeng {
    hidden: no
    view_label: "Sales Orders Items"
    label: "Confirmed Quantity of Item@{label_sap_code}"
    description: "Confirmed Quantity of Item in Sale Unit of Measure"
  }

  dimension: currency_waerk {
    hidden: yes
    view_label: "Sales Orders Items"
    label: "Currency (item)"
    description: "Document Currency at item level"
  }

  dimension: sales_order_value_line_item_source_currency {
    view_label: "Sales Orders Items"
    label: "Sales Amount"
    description: "Item Qty * Net Price (Document/Document Currency)"
    hidden: no
  }

  dimension: base_unit_of_measure_meins {
    hidden: no
    view_label: "Sales Orders Items"
    label: "Base UoM"
    description: "Base Unit of Measure@{label_sap_code}"
  }

  dimension: sales_unit_vrkme {
    hidden: no
    view_label: "Sales Orders Items"
    label: "Sales Unit@{label_sap_code}"
    }

  dimension: rejection_reason_abgru {
    hidden: no
    view_label: "Sales Orders Items"
    label: "Rejection Reason@{label_sap_code}"
  }

  dimension: is_item_cancelled {
    hidden: no
    type: yesno
    view_label: "Sales Orders Items"
    sql: ${rejection_reason_abgru} is not null and ${rejection_reason_abgru} <> '' ;;
  }

# }

  measure: order_line_count {
    hidden: no
    label: "Count Document Line Items"
    description: "Count of Order Documents & Items"
    }

  measure: sales_order_count {
    hidden: no
    type: count_distinct
    description: "Distinct count of Sales Document VBELN when Document Category VBTYP = C"
    sql: ${sales_document_vbeln} ;;
    filters: [document_category_vbtyp: "C"]
  }

  measure: sales_order_count_formatted {
    hidden: yes
    type: number
    sql: ${sales_order_count} ;;
    #  url: "{%assign model = _model._name %}/dashboards/{{model}}::otc_order_details?Order+Date=+2022%2F01%2F01+to+2022%2F12%2F31&Country={{_filters['countries_md.country_name_landx'] | url_encode}}&Sales+Org={{_filters['sales_organizations_md.sales_org_name_vtext'] | url_encode}}&Distribution+Channel={{_filters['distribution_channels_md.distribution_channel_name_vtext'] | url_encode}}&Division={{_filters['divisions_md.division_name_vtext'] | url_encode}}&Product={{_filters['materials_md.material_text_maktx'] | url_encode}}&Target+Currency={{_filters['currency_conversion_sdt.select_target_currency'] | url_encode}}
 # url: "/dashboards/cortex_sap_operational_v2::otc_order_details?Order+Status={{across_sales_and_billing_summary_xvw.order_status._value))"

    # link: {
    #   label: "Show Order Details"
    #   url: "/dashboards/cortex_sap_operational_v2::otc_order_details?Order+Status={{ across_sales_and_billing_summary_xvw.order_status._value }}"

    #   icon_url: "/favicon.ico"
    # }

    # ## opens drill modal with the selected filters
    # link: {
    #   label: "testing url"
    #   url: "{{link}}"
    # }
    # drill_fields: [sales_document_vbeln]

    ## dynamic capture of filters with link
    link: {
      label: "Open Order Details Dashboard"
      icon_url: "/favicon.ico"
      url: "
      @{link_build_variable_defaults}
      {% assign link = link_generator._link %}
      {% assign filters_mapping = '@{link_map_otc_sales_orders_to_order_details}' | strip_new_lines | append: '||across_sales_and_billing_summary_xvw.order_status|Order Status||deliveries.is_blocked|Is Blocked' %}

      {% assign model = _model._name %}
      {% assign target_dashboard = _model._name | append: '::otc_order_details' %}

      {% assign default_filters_override = false %}

      @{link_build_dashboard_url}
      "
    }
  }
# {% assign filters_mapping = 'sales_orders_v2.creation_date_erdat_date|Order Date||divisions_md.division_name_vtext|Division||countries_md.country_name_landx|Country||materials_md.material_text_maktx|Product||sales_organizations_md.sales_org_name_vtext|Sales Org||distribution_channels_md.distribution_channel_name_vtext|Distribution Channel||currency_conversion_sdt.select_target_currency|Target Currency||across_sales_and_billing_summary_xvw.order_status|Order Status' %}

  # {% assign default_filters = ''%}

# constant: link_map_otc_sales_orders_to_order_details {
#   value: "Order+Date|sales_orders_v2.creation_date_erdat_date ||
#       Division|divisions_md.division_name_vtext ||
#       Country|countries_md.country_name_landx ||
#       Sales+Org|sales_organizations_md.sales_org_name_vtext ||
#       Distribution+Channel|distribution_channels_md.distribution_channel_name_vtext ||
#       Product|materials_md.material_text_maktx ||
#       Target+Currency|currency_conversion_sdt.select_target_currency"
# }
  # Division|divisions_md.division_name_vtext||Country|countries_md.country_name_landx||Product|materials_md.material_text_maktx

  measure: count_sales_documents {
    hidden: no
    type: count_distinct
    label: "Count Sales Documents"
    description: "Distinct count of Sales Document VBELN"
    sql: ${sales_document_vbeln} ;;
  }

  measure: total_net_value {
    hidden: no
    type: sum
    label: "Total Sales (Document Currency)"
    description: "Total Sales (Document/Document Currency)"
    sql: ${sales_order_value_line_item_source_currency} ;;
    value_format_name: "format_large_numbers_d1"
  }

  measure: total_quantity_ordered {
    hidden: no
    type: sum
    sql: ${cumulative_order_quantity_kwmeng} ;;
  }

  measure: count_customers {
    hidden: no
    type: count_distinct
    description: "Total Customer Count (distinct count of Sold to Party KUNNR)"
    sql: ${sold_to_party_kunnr} ;;
  }

  measure: count_items_cancelled {
    hidden: no
    type: count
    filters: [is_item_cancelled: "Yes"]
  }

  measure: count_orders_with_cancellation {
    hidden: no
    description: "Count of Orders with at Least 1 Item Cancelled"
    type: count_distinct
    sql: ${sales_document_vbeln} ;;
    filters: [is_item_cancelled: "Yes", document_category_vbtyp: "C"]
  }


  measure: percent_orders_with_cancellation {
    hidden: no
    type: number
    sql: safe_divide(${count_orders_with_cancellation}, ${sales_order_count});;
    value_format_name: percent_1
  }





  measure: total_sales_amount_target_currency {
    hidden: no
    type: sum
    view_label: "Sales Orders"
    label: "@{label_currency}Total Sales ({{currency}})"
    sql: ${item_net_value_target_currency_netwr} ;;
    filters: [sales_orders_v2.document_category_vbtyp: "C"]
    value_format_name: decimal_2
    # sql_distinct_key: ${sales_orders_v2.key};;
    # link: {
    #   label: "Show Orders"
    #   url: "{{ dummy_set_details_sales_performance._link}}"
    #   # &f[sales_order_item_delivery_summary_ndt.is_order_late]=Yes"
    # }
  }

  measure: total_sales_amount_target_currency_formatted {
    hidden: no
    type: number
    view_label: "Sales Orders"
    label: "@{label_currency_defaults}@{label_currency_field_name}@{label_currency_if_selected}"
    # label: "@{label_currency}Total Sales ({{currency}}) Formatted"
    sql: ${total_sales_amount_target_currency} ;;
    value_format_name: format_large_numbers_d1
    # sql_distinct_key: ${sales_orders_v2.key};;
    # link: {
    #   label: "Show Orders"
    #   url: "{{ dummy_set_details_sales_performance._link}}"
    #   # &f[sales_order_item_delivery_summary_ndt.is_order_late]=Yes"
    # }
  }

  measure: cumulative_sales_amount_target_currency {
    hidden: no
    type: running_total
    group_label: "Sales Orders"
    label: "@{label_currency_defaults}@{label_currency_field_name}@{label_currency_if_selected}"
    description: "Cumulative sum of sales amount in target currency"
    sql: ${total_sales_amount_target_currency} ;;
    direction: "column"
    value_format_name: decimal_2
  }

  measure: avg_sales_per_order_target_currency {
    hidden: no
    type: number
    view_label: "Sales Orders"
    label: "@{label_currency}Average Sales per Order ({{currency}})"
    sql: safe_divide(${total_sales_amount_target_currency},${sales_orders_v2.sales_order_count});;
    # sql_distinct_key: ${sales_orders_v2.key};;
    value_format_name: decimal_2
    }

  measure: avg_sales_per_order_target_currency_formatted {
    hidden: no
    type: number
    view_label: "Sales Orders"
    label: "@{label_currency_defaults}@{label_currency_field_name}@{label_currency_if_selected}"
    # label: "@{label_currency}Average Sales per Order ({{currency}}) Formatted"
    sql: ${avg_sales_per_order_target_currency};;
    value_format_name: format_large_numbers_d1
  }
    # link: {
    #   label: "Show Orders"
    #   url: "{{ dummy_set_details_sales_performance._link}}"
    #   # &f[sales_order_item_delivery_summary_ndt.is_order_late]=Yes"
    # }

    ## dynamic capture of filters with link
    # link: {
    #   label: "Open Order Details Dashboard"
    #   icon_url: "/favicon.ico"
    #   url: "
    #   @{link_build_variable_defaults}
    #   {% assign link = link_generator._link %}
    #   {% assign filters_mapping = '@{link_map_otc_sales_orders_to_order_details}' | append: '||across_sales_and_billing_summary_xvw.order_status|Order Status||deliveries.is_blocked|Is Blocked' %}

    #   {% assign model = _model._name %}
    #   {% assign target_dashboard = _model._name | append: '::otc_order_details' %}

    #   {% assign default_filters_override = false %}

    #   @{link_build_dashboard_url}
    #   "
    # }

  # }

  # measure: test_avg {
  #   hidden: no
  #   type: average_distinct
  #   view_label: "Sales Orders"
  #   sql: ${item_net_price_target_currency_netpr} ;;
  #   sql_distinct_key: ${sales_orders_v2.key};;
  # }

  measure: percent_of_total_sales_amount_target_currency {
    hidden: no
    view_label: "Sales Orders"
    label: "Percent of Total Sales (Target Currency)"
    type: percent_of_total
    sql: ${total_sales_amount_target_currency} ;;
    # sql_distinct_key: ${sales_orders_v2.key};;
  }


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


  measure: link_generator {
    hidden: yes
    type: number
    sql: 1 ;;
    drill_fields: [link_generator]
  }

  }
