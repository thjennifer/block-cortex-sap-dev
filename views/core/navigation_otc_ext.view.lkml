include: "/views/base/navigation_template.view"

view: navigation_otc_ext {
  extends: [navigation_template]

  dimension: dash_bindings {
    hidden: yes
    type: string
    sql: 'otc_order_fulfillment|Order Fulfillment||otc_order_snapshot|Order Status||otc_sales_performance|Sales Performance||otc_billing_and_pricing|Billing and Pricing||otc_order_details|Order Details' ;;
  }

  dimension: filter_bindings {
    hidden: yes
    type: string
    sql: 'filter1|Order+Date||filter2|Country||filter3|Sales+Org||filter4|Distribution+Channel||filter5|Division||filter6|Product' ;;
    # sql: 'filter1|Order+Date||filter2|Country+Name' ;;
  }

  parameter: navigation_focus_page {
    hidden: no
    type: unquoted
    allowed_value: {value:"1"}
    allowed_value: {value:"2"}
    allowed_value: {value:"3"}
    allowed_value: {value:"4"}
    allowed_value: {value:"5"}
    default_value: "1"
  }

  filter: filter1 {
    hidden: yes
    type: date
    label: "Order Date"
  }

  filter: filter2 {
    hidden: yes
    type: string
    label: "Country"
  }

  filter: filter3 {
    hidden: yes
    type: string
    label: "Sales Org"
  }

  filter: filter4 {
    hidden: yes
    type: string
    label: "Distribution Channel"
  }

  filter: filter5 {
    hidden: yes
    type: string
    label: "Division"
  }

  filter: filter6 {
    hidden: yes
    type: string
    label: "Product"
  }



}
