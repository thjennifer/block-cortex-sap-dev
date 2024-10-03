#########################################################{
# Accounts Receivable template which must be EXTENDED into another dashboard
#
# defines the following elements which can be shared across Accounts Receivable-related dashboards:
#  - Filters including default values:
#       Company Code
#       Sold To
#       Target Currency
#
# The Elements and their properties can be EXTENDED into other dashboards and modified further as necessary
#########################################################}

- dashboard: accounts_receivable_template
  title: Accounts Receivable Template
  extension: required

  filters:
  - name: Company Code
    title: Company Code
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: dropdown_menu
      display: inline
    explore: accounting_documents_receivable_pdt
    field: companies_md.company_code_text

  - name: Sold To
    title: Sold To
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: dropdown_menu
      display: inline
      options: []
    explore: accounting_documents_receivable_pdt
    listens_to_filters: [Company Code]
    field: customers_md.customer_name

  # - name: DSO Period
  #   title: DSO Period
  #   type: field_filter
  #   default_value: ''
  #   allow_multiple_values: true
  #   required: false
  #   ui_config:
  #     type: advanced
  #     display: popover
  #     options: []

  #   explore: data_intelligence_ar
  #   listens_to_filters: []
  #   field: data_intelligence_ar.Day_Sales_Outstanding

  # - name: Overdue Receivable Day Intervals
  #   title: Overdue Receivable Day Intervals
  #   type: field_filter
  #   default_value: ''
  #   allow_multiple_values: true
  #   required: false
  #   ui_config:
  #     type: advanced
  #     display: popover
  #     options:
  #     - '30'
  #     - '20'
  #     - '10'

  #   explore: data_intelligence_ar
  #   listens_to_filters: []
  #   field: data_intelligence_ar.Aging_Interval

  - name: Target Currency
    title: Target Currency
    type: field_filter
    default_value: "{{ _user_attributes['sap_default_target_currency'] }}"
    allow_multiple_values: true
    required: false
    ui_config:
      type: dropdown_menu
      display: inline
      options: []
    explore: accounting_documents_receivable_pdt
    field: otc_common_parameters_xvw.parameter_target_currency
