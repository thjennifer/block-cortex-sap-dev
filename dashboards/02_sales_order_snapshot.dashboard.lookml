- dashboard: sales_order_snapshot
  title: Sales Order Snapshot
  layout: newspaper
  preferred_viewer: dashboards-next
  description: ''
  preferred_slug: m3w6s8s4yTif2jgtNxMd1u

  # pull navigation bar and filters from template
  # if using focus_page parameter for active dashboard update navigation tile to use the correct filter
  extends: sales_order_to_cash_template

  elements:

  - title: navigation
    name: navigation
    filters:
      navigation_sales_otc_ext.focus_page: '2'

  # - name: header_healthy_orders
  #   type: text
  #   title_text: <font color="#808080">How healthy is Order Fulfillment?</font>
  #   body_text: ''
  #   row: 2
  #   col: 0
  #   width: 24
  #   height: 1

  - title: One Touch Orders
    name: One Touch Orders
    explore: sales_orders_v2
    type: single_value
    fields: [one_touch_order.percent_one_touch_orders]
    listen:
      Order Date: sales_orders_v2.creation_date_erdat_date
      Division: divisions_md.division_name_vtext
      Country: countries_md.country_name_landx
      Sales Org: sales_organizations_md.sales_org_name_vtext
      Distribution Channel: distribution_channels_md.distribution_channel_name_vtext
      Product: materials_md.material_text_maktx
    row: 2
    col: 0
    width: 4
    height: 3

  - title: Avg Fill Rate %
    name: Avg Fill Rate %
    explore: sales_orders_v2
    type: single_value
    fields: [sales_order_schedule_line_sdt.avg_fill_rate_item_nullif0]
    listen:
      Order Date: sales_orders_v2.creation_date_erdat_date
      Division: divisions_md.division_name_vtext
      Country: countries_md.country_name_landx
      Sales Org: sales_organizations_md.sales_org_name_vtext
      Distribution Channel: distribution_channels_md.distribution_channel_name_vtext
      Product: materials_md.material_text_maktx
    row: 5
    col: 0
    width: 4
    height: 3

  - title: Cancelled Orders
    name: Cancelled Orders
    explore: sales_orders_v2
    type: single_value
    fields: [sales_orders_v2.percent_orders_with_cancellation]
    listen:
      Order Date: sales_orders_v2.creation_date_erdat_date
      Division: divisions_md.division_name_vtext
      Country: countries_md.country_name_landx
      Sales Org: sales_organizations_md.sales_org_name_vtext
      Distribution Channel: distribution_channels_md.distribution_channel_name_vtext
      Product: materials_md.material_text_maktx
    row: 11
    col: 0
    width: 4
    height: 3

  - title: Return Orders
    name: Return Orders
    explore: sales_orders_v2
    type: single_value
    fields: [across_sales_and_returns_xvw.percent_orders_with_return]
    listen:
      Order Date: sales_orders_v2.creation_date_erdat_date
      Division: divisions_md.division_name_vtext
      Country: countries_md.country_name_landx
      Sales Org: sales_organizations_md.sales_org_name_vtext
      Distribution Channel: distribution_channels_md.distribution_channel_name_vtext
      Product: materials_md.material_text_maktx
    row: 9
    col: 0
    width: 4
    height: 3

  - title: Order vs Delivery Efficiency
    name: Order vs Delivery Efficiency
    explore: sales_orders_v2
    type: looker_line
    fields: [materials_md.material_number_matnr, materials_md.material_text_maktx, across_sales_and_deliveries_xvw.difference_order_lines_delivery_lines,
      sales_orders_v2.count, deliveries.count_delivery_line_items, across_sales_and_deliveries_xvw.difference_delivery_lines_order_lines,
      across_sales_and_deliveries_xvw.percent_difference_order_lines_delivery_lines]
    filters:
      sales_orders_v2.count: ">=100"
    sorts: [across_sales_and_deliveries_xvw.difference_order_lines_delivery_lines desc]
    limit: 500
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
    limit_displayed_rows: true
    legend_position: center
    point_style: circle
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: step
    y_axes: [{label: '', orientation: left, series: [{axisId: sales_orders_v2.count,
          id: sales_orders_v2.count, name: Total Sales Order Line Item}, {axisId: deliveries.count_delivery_line_items,
          id: deliveries.count_delivery_line_items, name: Total Delivery Line Item},
        {axisId: across_sales_and_deliveries_xvw.difference_order_lines_delivery_lines,
          id: across_sales_and_deliveries_xvw.difference_order_lines_delivery_lines,
          name: Difference Order Lines Delivery Lines}], showLabels: true, showValues: true,
      unpinAxis: false, tickDensity: default, type: linear}]
    x_axis_label: Product
    x_axis_zoom: true
    y_axis_zoom: true
    limit_displayed_rows_values:
      show_hide: show
      first_last: first
      num_rows: '10'
    hidden_series: []
    series_types:
      sales_orders_v2.count: column
      deliveries.count_delivery_line_items: column
    series_colors:
      sales_orders_v2.count: "#12B5CB"
      deliveries.count: "#000"
      deliveries.count_delivery_line_items: "#A6CFD5"
      across_sales_and_deliveries_xvw.difference_order_lines_delivery_lines: "#596157"
    series_labels:
      sales_orders_v2.count: Total Sales Order Line Item
      deliveries.count_delivery_line_items: Total Delivery Line Item
    label_color: []
    reference_lines: []
    x_axis_label_rotation: 0
    advanced_vis_config: |-
      {
        chart: {},
        series: [{
          name: 'Difference'
        }, {
          name: 'Total Sales Order Line Item',
          dataLabels: {
            enabled: false,
          }
        }, {
          name: 'Total Delivery Line Item',
          dataLabels: {
            enabled: false,
          }
        }]
      }
    ordering: none
    show_null_labels: false
    show_dropoff: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
    note_state: collapsed
    note_display: above
    note_text: Top 10 Products with Largest Difference between Orders and Deliveries
    hidden_fields: [materials_md.material_number_matnr, across_sales_and_deliveries_xvw.difference_delivery_lines_order_lines,
      across_sales_and_deliveries_xvw.percent_difference_order_lines_delivery_lines]
    row: 2
    col: 5
    width: 19
    height: 12

  # - title: Order vs Delivery Efficiency
  #   name: Order vs Delivery Efficiency
  #   explore: sales_orders_v2
  #   type: looker_bar
  #   fields: [materials_md.material_text_maktx, deliveries.count_delivery_line_items,
  #     sales_orders_v2.count]
  #   sorts: [sales_orders_v2.count desc]
  #   limit: 500
  #   column_limit: 50
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
  #   point_style: circle
  #   show_value_labels: false
  #   label_density: 25
  #   x_axis_scale: auto
  #   y_axis_combined: true
  #   ordering: none
  #   show_null_labels: false
  #   show_totals_labels: false
  #   show_silhouette: false
  #   totals_color: "#808080"
  #   y_axes: [{label: '', orientation: bottom, series: [{axisId: deliveries.count_delivery_line_items,
  #           id: deliveries.count_delivery_line_items, name: Total Delivery Line Item},
  #         {axisId: sales_orders_v2.count, id: sales_orders_v2.count,
  #           name: Total Sales Order Line Item}], showLabels: true, showValues: true,
  #       unpinAxis: false, tickDensity: default, type: linear}]
  #   x_axis_label: Product
  #   x_axis_zoom: true
  #   y_axis_zoom: true
  #   limit_displayed_rows_values:
  #     show_hide: show
  #     first_last: first
  #     num_rows: '10'
  #   hidden_series: []
  #   series_types:
  #     deliveries.count: scatter
  #   series_colors:
  #     sales_orders_v2.count: "#A6CFD5"
  #     deliveries.count: "#000"
  #   series_labels:
  #     sales_orders_v2.count: Total Sales Order Line Item
  #     deliveries.count_delivery_line_items: Total Delivery Line Item
  #   series_point_styles: {}
  #   defaults_version: 1
  #   note_state: collapsed
  #   note_display: above
  #   note_text: Top 10 Products by Total Sales Order Line Items
  #   listen:
  #     Order Date: sales_orders_v2.creation_date_erdat_date
  #     Division: divisions_md.division_name_vtext
  #     Country: countries_md.country_name_landx
  #     Sales Org: sales_organizations_md.sales_org_name_vtext
  #     Distribution Channel: distribution_channels_md.distribution_channel_name_vtext
  #     Product: materials_md.material_text_maktx
  #   row: 3
  #   col: 7
  #   width: 17
  #   height: 12
