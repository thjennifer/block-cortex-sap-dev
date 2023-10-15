- dashboard: sales_order_fulfillment
  title: Sales Order Fulfillment
  layout: newspaper
  preferred_viewer: dashboards-next
  description: ''
  preferred_slug: TRgR2T4CDYOUt3RJD9wqij

  # pull navigation bar and filters from template
  # if using focus_page parameter for active dashboard update navigation tile to use the correct filter
  extends: sales_order_to_cash_template
  elements:

  - title: navigation
    name: navigation
    filters:
      navigation_sales_otc_ext.focus_page: '1'

  - title: In Full %
    name: In Full %
    explore: sales_orders_v2
    type: single_value
    fields: [across_sales_and_deliveries_xvw.percent_in_full_deliveries]
    limit: 500
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    defaults_version: 1
    hidden_fields: []
    y_axes: []
    listen:
      Order Date: sales_orders_v2.creation_date_erdat_date
      Sales Region: countries_md.country_name_landx
      Sales Org: sales_organizations_md.sales_org_name_vtext
      Distribution Channel: distribution_channels_md.distribution_channel_name_vtext
      Product: materials_md.material_text_maktx
      Division: divisions_md.division_name_vtext
    row: 2
    col: 6
    width: 6
    height: 3

  - title: On Time %
    name: On Time %
    explore: sales_orders_v2
    type: single_value
    fields: [deliveries.percent_on_time_deliveries]
    limit: 500
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    defaults_version: 1
    hidden_fields: []
    y_axes: []
    listen:
      Order Date: sales_orders_v2.creation_date_erdat_date
      Sales Region: countries_md.country_name_landx
      Sales Org: sales_organizations_md.sales_org_name_vtext
      Distribution Channel: distribution_channels_md.distribution_channel_name_vtext
      Product: materials_md.material_text_maktx
      Division: divisions_md.division_name_vtext
    row: 2
    col: 0
    width: 6
    height: 3

  - title: OTIF %
    name: OTIF %
    explore: sales_orders_v2
    type: single_value
    fields: [across_sales_and_deliveries_xvw.percent_otif_deliveries]
    limit: 500
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    defaults_version: 1
    hidden_fields: []
    y_axes: []
    listen:
      Order Date: sales_orders_v2.creation_date_erdat_date
      Sales Region: countries_md.country_name_landx
      Sales Org: sales_organizations_md.sales_org_name_vtext
      Distribution Channel: distribution_channels_md.distribution_channel_name_vtext
      Product: materials_md.material_text_maktx
      Division: divisions_md.division_name_vtext
    row: 2
    col: 12
    width: 6
    height: 3

  - title: Late Delivery %
    name: Late Delivery %
    explore: sales_orders_v2
    type: single_value
    fields: [deliveries.percent_late_deliveries]
    limit: 500
    column_limit: 50
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: true
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    conditional_formatting: [{type: greater than, value: 0.05, background_color: '',
        font_color: "#DB4C40", bold: false, italic: false, strikethrough: false, fields: !!null ''}]
    show_view_names: false
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    limit_displayed_rows: false
    defaults_version: 1
    hidden_fields: []
    y_axes: []
    listen:
      Order Date: sales_orders_v2.creation_date_erdat_date
      Sales Region: countries_md.country_name_landx
      Sales Org: sales_organizations_md.sales_org_name_vtext
      Distribution Channel: distribution_channels_md.distribution_channel_name_vtext
      Product: materials_md.material_text_maktx
      Division: divisions_md.division_name_vtext
    row: 2
    col: 18
    width: 6
    height: 3

  - title: Average Order Cycle Time
    name: Average Order Cycle Time
    explore: sales_orders_v2
    type: looker_bar
    fields: [materials_md.material_text_maktx, across_sales_and_deliveries_xvw.avg_distinct_order_cycle_time]
    sorts: [across_sales_and_deliveries_xvw.avg_distinct_order_cycle_time desc]
    limit: 5000
    column_limit: 50
    x_axis_gridlines: false
    y_axis_gridlines: true
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
    trellis: ''
    stacking: ''
    limit_displayed_rows: true
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    y_axes: [{label: Average Order Cycle Time, orientation: bottom, series: [{axisId: across_sales_and_deliveries_xvw.avg_distinct_order_cycle_time,
            id: across_sales_and_deliveries_xvw.avg_distinct_order_cycle_time, name: Average
              of Order Cycle Time}], showLabels: false, showValues: false, unpinAxis: false,
        tickDensity: custom, tickDensityCustom: 1, type: linear}]
    x_axis_label: Product
    x_axis_zoom: true
    y_axis_zoom: true
    limit_displayed_rows_values:
      show_hide: show
      first_last: first
      num_rows: '10'
    series_colors:
      across_sales_and_deliveries_xvw.avg_distinct_order_cycle_time: "#B3DEE2"
    reference_lines: [{reference_type: line, line_value: max, range_start: max, range_end: max,
        margin_top: deviation, margin_value: mean, margin_bottom: deviation, label_position: left,
        color: "#000000", label: ''}]
    defaults_version: 1
    note_state: collapsed
    note_display: above
    note_text: Top 10 Products by Average Order Cycle Time
    listen:
      Order Date: sales_orders_v2.creation_date_erdat_date
      Sales Region: countries_md.country_name_landx
      Sales Org: sales_organizations_md.sales_org_name_vtext
      Distribution Channel: distribution_channels_md.distribution_channel_name_vtext
      Product: materials_md.material_text_maktx
      Division: divisions_md.division_name_vtext
    row: 5
    col: 12
    width: 12
    height: 6

  - title: Delivery Performance
    name: Delivery Performance
    explore: sales_orders_v2
    type: looker_line
    fields: [sales_orders_v2.creation_date_erdat_month, deliveries.percent_on_time_deliveries,
      across_sales_and_deliveries_xvw.percent_in_full_deliveries, across_sales_and_deliveries_xvw.percent_otif_deliveries]
    fill_fields: [sales_orders_v2.creation_date_erdat_month]
    sorts: [sales_orders_v2.creation_date_erdat_month]
    limit: 500
    column_limit: 50
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    y_axes: []
    x_axis_label: Month
    x_axis_zoom: true
    y_axis_zoom: true
    series_types:
      deliveries.percent_on_time_deliveries: column
      across_sales_and_deliveries_xvw.percent_in_full_deliveries: column
      across_sales_and_deliveries_xvw.percent_otif_deliveries: column
    series_colors:
      deliveries.percent_on_time_deliveries: "#F39B6D"
      across_sales_and_deliveries_xvw.percent_in_full_deliveries: "#6494AA"
      across_sales_and_deliveries_xvw.percent_otif_deliveries: "#89BD9E"
    series_labels:
      deliveries.percent_on_time_deliveries: On Time %
      across_sales_and_deliveries_xvw.percent_in_full_deliveries: In Full %
      across_sales_and_deliveries_xvw.percent_otif_deliveries: OTIF %
    x_axis_datetime_label: "%B %y"
    defaults_version: 1
    listen:
      Order Date: sales_orders_v2.creation_date_erdat_date
      Sales Region: countries_md.country_name_landx
      Sales Org: sales_organizations_md.sales_org_name_vtext
      Distribution Channel: distribution_channels_md.distribution_channel_name_vtext
      Product: materials_md.material_text_maktx
      Division: divisions_md.division_name_vtext
    row: 5
    col: 0
    width: 12
    height: 6