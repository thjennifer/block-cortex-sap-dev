######################
# use this template to provide standard navigation and filters for Sales Order to Cash dashboards
# this template can only be extended into another dashboard
#
######################

- dashboard: sales_order_to_cash_template
  extension: required

  filters:
  - name: Order Date
    title: Order Date
    type: date_filter
    default_value:  "{% if _user_attributes['sap_use_demo_data'] =='Yes' %}{% assign date_range = '2022/01/01 to 2022/05/01' %}
                     {% else %} {% assign date_range = 'last 1 year' %}
                     {% endif %}{{date_range}}"
    # default_value: "2022/03/02 to 2022/03/03"
    # default_value: "last 1 year"
    # default_value: "@{DEFAULT_DATE_RANGE}"
    allow_multiple_values: true
    required: false
    ui_config:
      type: day_range_picker
      display: inline
      options: []

  - name: Region
    title: Region
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: checkboxes
      display: popover
    explore: sales_orders_v2
    listens_to_filters: []
    field: countries_md.country_name_landx

  - name: Sales Org
    title: Sales Org
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: checkboxes
      display: popover
    explore: sales_orders_v2
    listens_to_filters: []
    field: sales_organizations_md.sales_org_name_vtext

  - name: Distribution Channel
    title: Distribution Channel
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: checkboxes
      display: popover
    explore: sales_orders_v2
    listens_to_filters: []
    field: distribution_channels_md.distribution_channel_name_vtext

  - name: Division
    title: Division
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: checkboxes
      display: popover
    explore: sales_orders_v2
    listens_to_filters: []
    field: divisions_md.division_name_vtext

  - name: Product
    title: Product
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: checkboxes
      display: popover
    explore: sales_orders_v2
    listens_to_filters: []
    field: materials_md.material_text_maktx

  elements:
    - title: navigation
      name: navigation
      explore: sales_orders_v2
      type: single_value
      fields: [navigation_sales_otc_ext.navigation_tabs]
      filters:
        navigation_sales_otc_ext.focus_page: '1'
      show_single_value_title: false
      show_comparison: false
      listen:
#         Order Date: navigation_sales_otc_ext.filter1
        Region: navigation_sales_otc_ext.filter1
        Sales Org: navigation_sales_otc_ext.filter2
        Distribution Channel: navigation_sales_otc_ext.filter3
        Division: navigation_sales_otc_ext.filter4
        Product: navigation_sales_otc_ext.filter5
      row: 0
      col: 0
      width: 24
      height: 1
