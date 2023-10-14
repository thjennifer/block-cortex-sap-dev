include: "/views/base/navigation_template.view"

view: navigation_sales_otc_ext {
  extends: [navigation_template]

  dimension: dashBindings {
    hidden: yes
    type: string
    sql: 'cortex_sap_operational_v2::sales_order_fulfillment|Order Fulfillment||cortex_sap_operational_v2::sales_order_status_snapshot|Order Status Snapshot||cortex_sap_operational_v2::sales_order_details|Order Details' ;;
  }

  dimension: filterBindings {
    hidden: yes
    type: string
    sql: 'filter1|Region||filter2|Sales+Org||filter3|Distribution+Channel||filter4|Division||filter5|Product' ;;
    # sql: 'filter1|Order+Date||filter2|Country+Name' ;;
  }

  parameter: focus_page {
    hidden: no
    type: unquoted
    allowed_value: {value:"1"}
    allowed_value: {value:"2"}
    allowed_value: {value:"3"}
    default_value: "1"
  }

  filter: filter1 {
    hidden: no
    type: string
    label: "Region"
  }

  filter: filter2 {
    hidden: no
    type: string
    label: "Sales Org"
  }

  filter: filter3 {
    hidden: no
    type: string
    label: "Distribution Channel"
  }

  filter: filter4 {
    hidden: no
    type: string
    label: "Division"
  }

  filter: filter5 {
    hidden: no
    type: string
    label: "Product"
  }

  # filter: filter2 {
  #   hidden: yes
  #   type: string
  #   label: "Region"
  # }



}
