- dashboard: otc_order_fulfillment
  title: Order Fulfillment
  layout: newspaper
  preferred_viewer: dashboards-next
  description: ''

  # pull navigation bar and filters from template
  # if using navigation_focus_page parameter for active dashboard update navigation tile to use the correct filter
  extends: otc_template

  elements:

  - title: navigation
    name: navigation
    filters:
      navigation_otc_ext.navigation_focus_page: '1'

  - title: In Full %
    name: In Full %
    explore: sales_orders_v2
    type: single_value
    fields: [sales_order_item_delivery_summary_ndt.percent_orders_delivered_in_full]
    listen:
      Order Date: sales_orders_v2.creation_date_erdat_date
      Country: countries_md.country_name_landx
      Sales Org: sales_organizations_md.sales_org_name_vtext
      Distribution Channel: distribution_channels_md.distribution_channel_name_vtext
      Product: materials_md.material_text_maktx
      Division: divisions_md.division_name_vtext
    note_state: collapsed
    note_display: hover
    note_text: "The percentage of sales orders fulfilled completely (for all line items)."
    row: 2
    col: 6
    width: 6
    height: 3

  - title: On Time %
    name: On Time %
    explore: sales_orders_v2
    type: single_value
    fields: [sales_order_item_delivery_summary_ndt.percent_orders_delivered_on_time]
    listen:
      Order Date: sales_orders_v2.creation_date_erdat_date
      Country: countries_md.country_name_landx
      Sales Org: sales_organizations_md.sales_org_name_vtext
      Distribution Channel: distribution_channels_md.distribution_channel_name_vtext
      Product: materials_md.material_text_maktx
      Division: divisions_md.division_name_vtext
    note_state: collapsed
    note_display: hover
    note_text: "The percentage of sales orders fulfilled by the promised delivery date."
    row: 2
    col: 0
    width: 6
    height: 3

  - title: OTIF %
    name: OTIF %
    explore: sales_orders_v2
    type: single_value
    fields: [sales_order_item_delivery_summary_ndt.percent_orders_delivered_otif]
    # fields: [across_sales_and_deliveries_xvw.percent_otif_deliveries]
    listen:
      Order Date: sales_orders_v2.creation_date_erdat_date
      Country: countries_md.country_name_landx
      Sales Org: sales_organizations_md.sales_org_name_vtext
      Distribution Channel: distribution_channels_md.distribution_channel_name_vtext
      Product: materials_md.material_text_maktx
      Division: divisions_md.division_name_vtext
    note_state: collapsed
    note_display: hover
    note_text: "The percentage of sales orders fulfilled completely (for all line items) by the promised delivery date."
    row: 2
    col: 12
    width: 6
    height: 3

  - title: Late Delivery %
    name: Late Delivery %
    explore: sales_orders_v2
    type: single_value
    fields: [sales_order_item_delivery_summary_ndt.percent_orders_delivered_late]
    # fields: [deliveries.percent_late_deliveries]
    enable_conditional_formatting: true
    conditional_formatting: [{type: greater than, value: 0.05, background_color: '',
        font_color: "#DB4C40", bold: false, italic: false, strikethrough: false, fields: !!null ''}]
    listen:
      Order Date: sales_orders_v2.creation_date_erdat_date
      Country: countries_md.country_name_landx
      Sales Org: sales_organizations_md.sales_org_name_vtext
      Distribution Channel: distribution_channels_md.distribution_channel_name_vtext
      Product: materials_md.material_text_maktx
      Division: divisions_md.division_name_vtext
    note_state: collapsed
    note_display: hover
    note_text: "The percentage of sales orders not fully delivered by the promised delivery date."
    row: 2
    col: 18
    width: 6
    height: 3

  - title: Products with Longest Average Order Cycle Time (Days)
    name: Products with Longest Average Order Cycle Time
    explore: sales_orders_v2
    type: looker_bar
    fields: [materials_md.material_number_matnr,materials_md.material_text_maktx, sales_order_item_delivery_summary_ndt.avg_order_cycle_time]
    sorts: [sales_order_item_delivery_summary_ndt.avg_order_cycle_time desc]
    hidden_fields: [materials_md.material_number_matnr]
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
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
            id: sales_order_item_delivery_summary_ndt.avg_order_cycle_time, name: Average
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
      sales_order_item_delivery_summary_ndt.avg_order_cycle_time: "#B3DEE2"
    reference_lines: [{reference_type: line, range_start: min, range_end: max, margin_top: deviation,
      margin_value: mean, margin_bottom: deviation, label_position: left, color: "#000000",
      label: '', line_value: max}, {reference_type: line, line_value: min, range_start: max,
      range_end: min, margin_top: deviation, margin_value: mean, margin_bottom: deviation,
      label_position: right, color: "#000000"}]
    advanced_vis_config: "{\n  yAxis: [{\n \n    plotLines: [{\n        color: '#transparent',\n\
        \        label: {\n          align: 'center',\n          verticalAlign: 'top',\n\
        \          x: -5,\n          y: 2,\n        },\n    \n      },\n      {\n  \
        \      color: '#transparent',\n        label: {\n          align: 'center',\n\
        \          verticalAlign: 'bottom',\n          x: 0,\n          y: -1,\n   \
        \     },\n        \n      },\n    ],\n    \n\n  }, ],\n}"
    note_display: hover
    note_text: limited to 10 products ranked in descending order by Avg Order Cycle Time
    listen:
      Order Date: sales_orders_v2.creation_date_erdat_date
      Country: countries_md.country_name_landx
      Sales Org: sales_organizations_md.sales_org_name_vtext
      Distribution Channel: distribution_channels_md.distribution_channel_name_vtext
      Product: materials_md.material_text_maktx
      Division: divisions_md.division_name_vtext
    note_state: collapsed
    note_display: hover
    note_text: "Order cycle time is average number of days between order placement and order delivery. "
    row: 5
    col: 12
    width: 12
    height: 6

  - title: Delivery Performance by Month
    name: Delivery Performance by Month
    explore: sales_orders_v2
    type: looker_line
    fields: [sales_orders_v2.creation_date_erdat_month,sales_order_item_delivery_summary_ndt.percent_orders_delivered_on_time,
            sales_order_item_delivery_summary_ndt.percent_orders_delivered_in_full, sales_order_item_delivery_summary_ndt.percent_orders_delivered_otif]
    sorts: [sales_orders_v2.creation_date_erdat_month]
    limit: 500
    column_limit: 50
    legend_position: center
    point_style: none
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    y_axes: []
    x_axis_label: Month
    x_axis_zoom: true
    y_axis_zoom: true
    series_types:
      sales_order_item_delivery_summary_ndt.percent_orders_delivered_on_time: column
      sales_order_item_delivery_summary_ndt.percent_orders_delivered_in_full: column
      sales_order_item_delivery_summary_ndt.percent_orders_delivered_otif: column
    series_colors:
      sales_order_item_delivery_summary_ndt.percent_orders_delivered_on_time: "#F39B6D"
      sales_order_item_delivery_summary_ndt.percent_orders_delivered_in_full: "#6494AA"
      sales_order_item_delivery_summary_ndt.percent_orders_delivered_otif: "#89BD9E"
    series_labels:
      sales_order_item_delivery_summary_ndt.percent_orders_delivered_on_time: On Time %
      sales_order_item_delivery_summary_ndt.percent_orders_delivered_in_full: In Full %
      sales_order_item_delivery_summary_ndt.percent_orders_delivered_otif: OTIF %
    x_axis_datetime_label: "%B %y"
    defaults_version: 1
    listen:
      Order Date: sales_orders_v2.creation_date_erdat_date
      Country: countries_md.country_name_landx
      Sales Org: sales_organizations_md.sales_org_name_vtext
      Distribution Channel: distribution_channels_md.distribution_channel_name_vtext
      Product: materials_md.material_text_maktx
      Division: divisions_md.division_name_vtext
    row: 5
    col: 0
    width: 12
    height: 6
