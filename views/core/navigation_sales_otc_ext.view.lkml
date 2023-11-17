include: "/views/base/navigation_template.view"

view: navigation_sales_otc_ext {
  extends: [navigation_template]

  dimension: dashBindings {
    hidden: yes
    type: string
    sql: 'sales_order_fulfillment|Order Fulfillment||sales_order_snapshot|Order Snapshot||sales_order_status_details|Order Status Details||sales_performance|Sales Performance' ;;
  }

  dimension: filterBindings {
    hidden: yes
    type: string
    sql: 'filter1|Order+Date||filter2|Country||filter3|Sales+Org||filter4|Distribution+Channel||filter5|Division||filter6|Product' ;;
    # sql: 'filter1|Order+Date||filter2|Country+Name' ;;
  }

  parameter: focus_page {
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
