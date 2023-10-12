- dashboard: sales_order_fulfillment
  title: Sales Order Fulfillment
  layout: newspaper
  preferred_viewer: dashboards-next
  description: ''
  preferred_slug: TRgR2T4CDYOUt3RJD9wqij
  elements:
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
    value_format: 0.00%
    defaults_version: 1
    hidden_fields: []
    y_axes: []
    listen:
      Order Date: sales_orders_v2.creation_date_erdat_date
      # Currency: currency_conversion_new.tcurr
      Region: countries_md.country_name_landx
      Sales Org: sales_organizations_md.sales_org_name_vtext
      Distribution Channel: distribution_channels_md.distribution_channel_name_vtext
      Product: materials_md.material_text_maktx
      Division: divisions_md.division_name_vtext
    row: 1
    col: 6
    width: 6
    height: 3
  # - title: On Time %
  #   name: On Time %

  #   explore: sales_orders_v2
  #   type: single_value
  #   fields: [deliveries.OnTimePercentage]
  #   limit: 500
  #   custom_color_enabled: true
  #   show_single_value_title: true
  #   show_comparison: false
  #   comparison_type: value
  #   comparison_reverse_colors: false
  #   show_comparison_label: true
  #   enable_conditional_formatting: false
  #   conditional_formatting_include_totals: false
  #   conditional_formatting_include_nulls: false
  #   value_format: 0.00%
  #   defaults_version: 1
  #   hidden_fields: []
  #   y_axes: []
  #   listen:
  #     Year: sales_orders.creation_date_erdat_date
  #     Currency: currency_conversion_new.tcurr
  #     Region: countries_md.country_name_landx
  #     Sales Org: sales_organizations_md.sales_org_name_vtext
  #     Distribution Channel: distribution_channels_md.distribution_channel_name_vtext
  #     Product: materials_md.material_text_maktx
  #     Division: divisions_md.division_name_vtext
  #   row: 1
  #   col: 0
  #   width: 6
  #   height: 3
  # - title: OTIF %
  #   name: OTIF %

  #   explore: sales_orders_v2
  #   type: single_value
  #   fields: [deliveries.OTIFPercentage]
  #   limit: 500
  #   custom_color_enabled: true
  #   show_single_value_title: true
  #   show_comparison: false
  #   comparison_type: value
  #   comparison_reverse_colors: false
  #   show_comparison_label: true
  #   enable_conditional_formatting: false
  #   conditional_formatting_include_totals: false
  #   conditional_formatting_include_nulls: false
  #   value_format: 0.00%
  #   defaults_version: 1
  #   hidden_fields: []
  #   y_axes: []
  #   listen:
  #     Year: sales_orders.creation_date_erdat_date
  #     Currency: currency_conversion_new.tcurr
  #     Region: countries_md.country_name_landx
  #     Sales Org: sales_organizations_md.sales_org_name_vtext
  #     Distribution Channel: distribution_channels_md.distribution_channel_name_vtext
  #     Product: materials_md.material_text_maktx
  #     Division: divisions_md.division_name_vtext
  #   row: 1
  #   col: 12
  #   width: 6
  #   height: 3
  # - title: Late Delivery %
  #   name: Late Delivery %

  #   explore: sales_orders_v2
  #   type: single_value
  #   fields: [deliveries.LateDeliveryPercentage]
  #   limit: 500
  #   column_limit: 50
  #   custom_color_enabled: true
  #   show_single_value_title: true
  #   show_comparison: false
  #   comparison_type: value
  #   comparison_reverse_colors: false
  #   show_comparison_label: true
  #   enable_conditional_formatting: true
  #   conditional_formatting_include_totals: false
  #   conditional_formatting_include_nulls: false
  #   color_application:
  #     collection_id: 5f313589-67ce-44ba-b084-ec5107a7bb7e
  #     palette_id: be92eae7-de25-46ae-8e4f-21cb0b69a1f3
  #   value_format: 0.00%
  #   conditional_formatting: [{type: greater than, value: 0.05, background_color: '',
  #       font_color: "#DB4C40", color_application: {collection_id: 5f313589-67ce-44ba-b084-ec5107a7bb7e,
  #         palette_id: 2229f400-11a4-4b0d-b224-abe608161947}, bold: false, italic: false,
  #       strikethrough: false, fields: !!null ''}]
  #   show_view_names: false
  #   show_row_numbers: true
  #   truncate_column_names: false
  #   hide_totals: false
  #   hide_row_totals: false
  #   table_theme: editable
  #   limit_displayed_rows: false
  #   defaults_version: 1
  #   series_types: {}
  #   hidden_fields: []
  #   y_axes: []
  #   listen:
  #     Year: sales_orders.creation_date_erdat_date
  #     Currency: currency_conversion_new.tcurr
  #     Region: countries_md.country_name_landx
  #     Sales Org: sales_organizations_md.sales_org_name_vtext
  #     Distribution Channel: distribution_channels_md.distribution_channel_name_vtext
  #     Product: materials_md.material_text_maktx
  #     Division: divisions_md.division_name_vtext
  #   row: 1
  #   col: 18
  #   width: 6
  #   height: 3
  # - title: Average Order Cycle Time
  #   name: Average Order Cycle Time

  #   explore: sales_orders_v2
  #   type: looker_bar
  #   fields: [average_of_order_cycle_time_1, materials_md.material_text_maktx, sales_orders.count_orders]
  #   filters:
  #     deliveries.Order_Cycle_Time: NOT NULL
  #   sorts: [average_of_order_cycle_time_1 desc]
  #   limit: 5000
  #   column_limit: 50
  #   dynamic_fields: [{measure: average_of_order_cycle_time, based_on: deliveries.Order_Cycle_Time,
  #       expression: '', label: Average of Order Cycle Time, type: average, _kind_hint: measure,
  #       _type_hint: number, id: cy7lHmcwoH}, {category: measure, expression: '', label: Average
  #         of Order Cycle Time, value_format: !!null '', value_format_name: decimal_2,
  #       based_on: deliveries.Order_Cycle_Time, _kind_hint: measure, measure: average_of_order_cycle_time_1,
  #       type: average, _type_hint: number}, {category: table_calculation, expression: 'sum(${order_cycle_time})
  #         / sum(${sales_orders.count_orders})', label: Overall Average, value_format: !!null '',
  #       value_format_name: Default formatting, _kind_hint: measure, table_calculation: overall_average,
  #       _type_hint: number, is_disabled: true}]
  #   x_axis_gridlines: false
  #   y_axis_gridlines: true
  #   show_view_names: false
  #   show_y_axis_labels: true
  #   show_y_axis_ticks: true
  #   y_axis_tick_density: default
  #   y_axis_tick_density_custom: 5
  #   show_x_axis_label: false
  #   show_x_axis_ticks: true
  #   y_axis_scale_mode: linear
  #   x_axis_reversed: false
  #   y_axis_reversed: false
  #   plot_size_by_field: false
  #   trellis: ''
  #   stacking: ''
  #   limit_displayed_rows: true
  #   legend_position: center
  #   point_style: none
  #   show_value_labels: false
  #   label_density: 25
  #   x_axis_scale: auto
  #   y_axis_combined: true
  #   ordering: none
  #   show_null_labels: false
  #   show_totals_labels: false
  #   show_silhouette: false
  #   totals_color: "#808080"
  #   y_axes: [{label: Average Order Cycle Time, orientation: bottom, series: [{axisId: average_of_order_cycle_time_1,
  #           id: average_of_order_cycle_time_1, name: Average of Order Cycle Time}],
  #       showLabels: false, showValues: false, unpinAxis: false, tickDensity: custom,
  #       tickDensityCustom: 1, type: linear}]
  #   x_axis_label: Product
  #   x_axis_zoom: true
  #   y_axis_zoom: true
  #   limit_displayed_rows_values:
  #     show_hide: show
  #     first_last: first
  #     num_rows: '10'
  #   label_value_format: '0.00'
  #   series_types: {}
  #   series_colors:
  #     average_of_order_cycle_time_1: "#B3DEE2"
  #   reference_lines: [{reference_type: line, line_value: max, range_start: max, range_end: max,
  #       margin_top: deviation, margin_value: mean, margin_bottom: deviation, label_position: left,
  #       color: "#000000", label: ''}]
  #   defaults_version: 1
  #   hidden_fields: [sales_orders.count_orders]
  #   hidden_pivots: {}
  #   note_state: collapsed
  #   note_display: above
  #   note_text: Top 10 Products by Average Order Cycle Time
  #   listen:
  #     Year: sales_orders.creation_date_erdat_date
  #     Currency: currency_conversion_new.tcurr
  #     Region: countries_md.country_name_landx
  #     Sales Org: sales_organizations_md.sales_org_name_vtext
  #     Distribution Channel: distribution_channels_md.distribution_channel_name_vtext
  #     Product: materials_md.material_text_maktx
  #     Division: divisions_md.division_name_vtext
  #   row: 4
  #   col: 12
  #   width: 12
  #   height: 6
  # - title: Delivery Performance
  #   name: Delivery Performance

  #   explore: sales_orders_v2
  #   type: looker_line
  #   fields: [deliveries.count_on_time_delivery, deliveries.count_in_full_delivery,
  #     deliveries.count_otif, deliveries.count_of_deliveries, sales_orders.creation_date_erdat_month]
  #   fill_fields: [sales_orders.creation_date_erdat_month]
  #   sorts: [sales_orders.creation_date_erdat_month]
  #   limit: 500
  #   column_limit: 50
  #   dynamic_fields: [{category: table_calculation, expression: "${deliveries.count_on_time_delivery}/${deliveries.count_of_deliveries}",
  #       label: On Time %, value_format: !!null '', value_format_name: percent_1, _kind_hint: measure,
  #       table_calculation: on_time, _type_hint: number, id: yuk3RNbXmc}, {category: table_calculation,
  #       expression: "${deliveries.count_in_full_delivery}/${deliveries.count_of_deliveries}",
  #       label: In Full %, value_format: !!null '', value_format_name: percent_1, _kind_hint: measure,
  #       table_calculation: in_full, _type_hint: number, id: MdTeyHWNoo}, {category: table_calculation,
  #       expression: "${deliveries.count_otif}/${deliveries.count_of_deliveries}",
  #       label: OTIF %, value_format: !!null '', value_format_name: percent_1, _kind_hint: measure,
  #       table_calculation: otif, _type_hint: number, id: mkIEP9ohdi}]
  #   x_axis_gridlines: false
  #   y_axis_gridlines: true
  #   show_view_names: false
  #   show_y_axis_labels: true
  #   show_y_axis_ticks: true
  #   y_axis_tick_density: default
  #   y_axis_tick_density_custom: 5
  #   show_x_axis_label: true
  #   show_x_axis_ticks: true
  #   y_axis_scale_mode: linear
  #   x_axis_reversed: false
  #   y_axis_reversed: false
  #   plot_size_by_field: false
  #   trellis: ''
  #   stacking: ''
  #   limit_displayed_rows: false
  #   legend_position: center
  #   point_style: none
  #   show_value_labels: false
  #   label_density: 25
  #   x_axis_scale: auto
  #   y_axis_combined: true
  #   show_null_points: true
  #   interpolation: linear
  #   y_axes: []
  #   x_axis_label: Month
  #   x_axis_zoom: true
  #   y_axis_zoom: true
  #   series_types:
  #     on_time: column
  #     in_full: column
  #     otif: column
  #   series_colors:
  #     on_time: "#F39B6D"
  #     in_full: "#6494AA"
  #     otif: "#89BD9E"
  #   x_axis_datetime_label: "%B %y"
  #   defaults_version: 1
  #   hidden_fields: [deliveries.count_on_time_delivery, deliveries.count_in_full_delivery,
  #     deliveries.count_otif, deliveries.count_of_deliveries]
  #   listen:
  #     Year: sales_orders.creation_date_erdat_date
  #     Currency: currency_conversion_new.tcurr
  #     Region: countries_md.country_name_landx
  #     Sales Org: sales_organizations_md.sales_org_name_vtext
  #     Distribution Channel: distribution_channels_md.distribution_channel_name_vtext
  #     Product: materials_md.material_text_maktx
  #     Division: divisions_md.division_name_vtext
  #   row: 4
  #   col: 0
  #   width: 12
  #   height: 6
  # - title: tabbed navigation
  #   name: tabbed navigation

  #   explore: sales_orders_v2
  #   type: single_value
  #   fields: [tabbed_navigation.tabbed_navigation]
  #   filters:
  #     tabbed_navigation.tab_to_focus: '1'
  #   sorts: [tabbed_navigation.tabbed_navigation]
  #   limit: 500
  #   column_limit: 50
  #   custom_color_enabled: true
  #   show_single_value_title: false
  #   show_comparison: false
  #   comparison_type: value
  #   comparison_reverse_colors: false
  #   show_comparison_label: true
  #   enable_conditional_formatting: false
  #   conditional_formatting_include_totals: false
  #   conditional_formatting_include_nulls: false
  #   show_sql_query_menu_options: false
  #   show_totals: true
  #   show_row_totals: true
  #   show_view_names: false
  #   show_row_numbers: false
  #   transpose: false
  #   truncate_text: true
  #   truncate_header: false
  #   size_to_fit: true
  #   table_theme: unstyled
  #   limit_displayed_rows: false
  #   header_text_alignment: left
  #   header_font_size: '12'
  #   rows_font_size: '12'
  #   hide_totals: false
  #   hide_row_totals: false
  #   series_types: {}
  #   defaults_version: 1
  #   hidden_pivots: {}
  #   listen:
  #     Year: sales_orders.creation_date_erdat_date
  #     Division: divisions_md.division_name_vtext
  #     Currency: currency_conversion_new.tcurr
  #     Region: countries_md.country_name_landx
  #     Sales Org: sales_organizations_md.sales_org_name_vtext
  #     Distribution Channel: distribution_channels_md.distribution_channel_name_vtext
  #     Product: materials_md.material_text_maktx
  #   row: 0
  #   col: 0
  #   width: 24
  #   height: 1
  filters:
  - name: Order Date
    title: Order Date
    type: date_filter
    # default_value: "2022/03/02 to 2022/03/03"
    # default_value: "last 1 year"
    # default_value: "@{DEFAULT_DATE_RANGE}"
    allow_multiple_values: true
    required: false
    ui_config:
      type: day_range_picker
      display: inline
      options: []

    # default_value: "2022/01/01 to 2022/04/22"
    # default_value: \@{DEFAULT_DATE_RANGE}
    default_value:  "{% if _user_attributes['sap_use_demo_data'] =='Yes' %}{% assign date_range = '2022/01/01 to 2022/03/22' %}
          {% else %} {% assign date_range = 'last 1 year' %}
          {% endif %}{{date_range}}"
    # default_value: "@{DEFAULT_DATE_RANGE}"



  # - name: Currency
  #   title: Currency
  #   type: field_filter
  #   default_value: USD
  #   allow_multiple_values: true
  #   required: true
  #   ui_config:
  #     type: dropdown_menu
  #     display: inline

  #   explore: sales_orders_v2
  #   listens_to_filters: []
  #   field: currency_conversion_new.tcurr
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
