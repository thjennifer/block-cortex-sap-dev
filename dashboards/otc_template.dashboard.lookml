######################
# use this template to provide standard navigation and filters for Sales Order to Cash dashboards
# this template can only be extended into another dashboard
#
######################

- dashboard: otc_template
  extension: required

  title: OTC Template with Core Filters and Elements

  layout: newspaper
  preferred_viewer: dashboards-next
  crossfilter_enabled: false
  filters_location_top: false
  description: "Template which defines core filters and elements used in all OTC dashboards. Extendable and customizable."

  filters:
  - name: date
    title: Order Date
    type: date_filter
    default_value:  "{% if _user_attributes['cortex_sap_use_test_data'] =='Yes' %}{% assign date_range = '2022/01/01 to 2022/12/31' %}
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

  - name: country
    title: Country
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: checkboxes
      display: popover
    explore: countries_md
    field: countries_md.country_name_landx

  - name: sales_org
    title: Sales Org
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: checkboxes
      display: popover
    explore: sales_organizations_md
    field: sales_organizations_md.sales_org_name_vtext

  - name: distribution_channel
    title: Distribution Channel
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: checkboxes
      display: popover
    explore: sales_orders_v2
    listens_to_filters: [language_key_spras]
    field: distribution_channels_md.distribution_channel_name_vtext

  - name: division
    title: Division
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: checkboxes
      display: popover
    explore: divisions_md
    field: divisions_md.division_name_vtext

  - name: sold_to
    title: Sold to
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: advanced
      display: popover
    explore: customers_md
    field: customers_md.customer_name

  - name: product
    title: Product
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: advanced
      display: popover
    explore: materials_md
    field: materials_md.material_text_maktx

  - name: target_currency
    title: Target Currency
    type: field_filter
    default_value: "{{ _user_attributes['cortex_sap_default_target_currency'] }}"
    allow_multiple_values: false
    required: false
    ui_config:
      type: dropdown_menu
      display: inline
      options: []
    explore: otc_target_currencies_pdt
    field: otc_target_currencies_pdt.to_currency_tcurr

  # the other field filters need {{ _user_attributes['cortex_sap_default_language_key'] }} to display properly (parameter won't work)
  # if include this parameter and selected value differs from user attribute then applied filters may cause 0 rows
  # - name: language_key_spras
  #   title: Language
  #   type: field_filter
  #   default_value: "{{ _user_attributes['cortex_sap_default_language_key'] }}"
  #   allow_multiple_values: false
  #   required: false
  #   ui_config:
  #     type: dropdown_menu
  #     display: inline
  #     options: []
  #   explore: otc_languages_pdt
  #   field: otc_languages_pdt.language_spras

  elements:
    - name: dashboard_navigation
      title: Dashboard Navigation
      explore: sales_orders_v2
      type: single_value
      fields: [otc_dashboard_navigation_ext.navigation_links]
      filters:
        otc_dashboard_navigation_ext.parameter_navigation_focus_page: '1'
        otc_dashboard_navigation_ext.parameter_navigation_style: 'buttons'
        otc_dashboard_navigation_ext.parameter_navigation_subject: 'orders'
      show_single_value_title: false
      show_comparison: false
      listen:
        date: otc_dashboard_navigation_ext.filter1
        country: otc_dashboard_navigation_ext.filter2
        sales_org: otc_dashboard_navigation_ext.filter3
        distribution_channel: otc_dashboard_navigation_ext.filter4
        division: otc_dashboard_navigation_ext.filter5
        product: otc_dashboard_navigation_ext.filter6
        sold_to: otc_dashboard_navigation_ext.filter7
        target_currency: otc_dashboard_navigation_ext.filter8
      row: 0
      col: 0
      width: 24
      height: 1
