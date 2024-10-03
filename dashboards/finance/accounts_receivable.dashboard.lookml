- dashboard: accounts_receivable
  title: Accounts Receivable
  layout: newspaper
  preferred_viewer: dashboards-next
  extends: accounts_receivable_template

  elements:
  - title: Total Receivable
    name: Total Receivable
    explore: accounting_documents_receivable_pdt
    type: single_value
    fields: [accounting_documents_receivable_pdt.total_accounts_receivable_amount_target_currency]
    filters: {}
    show_single_value_title: true
    show_comparison: false
    enable_conditional_formatting: false
    listen:
      Target Currency: otc_common_paramters_xvw.parameter_target_currency
      Company Code: companies_md.company_code_text
      Sold To: customers_md.customer_name
    row: 2
    col: 0
    width: 5
    height: 2

  - title: Total Overdue Receivable
    name: Total Overdue Receivable
    explore: accounting_documents_receivable_pdt
    type: single_value
    fields: [accounting_documents_receivable_pdt.total_open_and_overdue_amount_target_currency]
    filters: {}
    show_single_value_title: true
    show_comparison: false
    enable_conditional_formatting: false
    note_state: collapsed
    note_display: hover
    note_text: "Overdue means past the net due date."
    listen:
      Target Currency: otc_common_paramters_xvw.parameter_target_currency
      Company Code: companies_md.company_code_text
      Sold To: customers_md.customer_name
    row: 2
    col: 5
    width: 5
    height: 2

  - title: Total Doubtful Receivable
    name: Total Doubtful Receivable
    explore: accounting_documents_receivable_pdt
    type: single_value
    fields: [accounting_documents_receivable_pdt.total_doubtful_amount_target_currency]
    filters: {}
    show_single_value_title: true
    show_comparison: false
    enable_conditional_formatting: false
    note_state: collapsed
    note_display: hover
    note_text: "Doubtful means greater than 90 days past the net due date."
    listen:
      Target Currency: otc_common_paramters_xvw.parameter_target_currency
      Company Code: companies_md.company_code_text
      Sold To: customers_md.customer_name
    row: 2
    col: 10
    width: 5
    height: 2

  - title: Percent of Total Receivable by Company
    name: Percent of Total Receivable by Company
    explore: accounting_documents_receivable_pdt
    type: looker_bar
    fields: [companies_md.company_code_text, accounting_documents_receivable_pdt.percent_of_total_receivable]
    sorts: [accounting_documents_receivable_pdt.percent_of_total_receivable desc]
    limit: 50
    x_axis_gridlines: false
    y_axis_gridlines: false
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    y_axes: [{label: '', orientation: bottom, series: [{axisId: accounting_documents_receivable_pdt.percent_of_total_receivable,
            id: accounting_documents_receivable_pdt.percent_of_total_receivable, name: Percent
              of Total Receivable}], showLabels: true, showValues: false, unpinAxis: false,
        tickDensity: default, tickDensityCustom: 5, type: linear}]
    x_axis_zoom: true
    y_axis_zoom: true
    # hidden_fields: [accounting_documents_receivable_pdt.total_accounts_receivable_amount_target_currency]
    listen:
      Target Currency: otc_common_paramters_xvw.parameter_target_currency
      Company Code: companies_md.company_code_text
      Sold To: customers_md.customer_name
    row: 5
    col: 0
    width: 10
    height: 10
