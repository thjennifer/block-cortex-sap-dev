- dashboard: otc_order_snapshot_option1
  title: Order Snapshot
  layout: newspaper
  preferred_viewer: dashboards-next
  description: ''

  # pull navigation bar and filters from template
  # if using navigation_focus_page parameter for active dashboard update navigation tile to use the correct filter
  extends: otc_template

  elements:

  - title: navigation
    name: dashboard_navigation
    filters:
      otc_dashboard_navigation_ext.parameter_navigation_focus_page: '2'

  - title: One Touch Orders
    name: One Touch Orders
    explore: sales_orders_v2
    type: single_value
    fields: [one_touch_order.one_touch_sales_order_percent]
    listen:
      date: sales_orders_v2.creation_date_erdat_date
      country: countries_md.country_name_landx
      sales_org: sales_organizations_md.sales_org_name_vtext
      distribution_channel: distribution_channels_md.distribution_channel_name_vtext
      product: materials_md.material_text_maktx
      division: divisions_md.division_name_vtext
      sold_to: customers_md.customer_name
    note_state: collapsed
    note_display: hover
    note_text: "The percentage of sales orders processed without manual touches or interventions during order entry, scheduling, shipping and invoicing."
    row: 2
    col: 0
    width: 4
    height: 3

  - title: Fill Rate %
    name: Fill Rate %
    explore: sales_orders_v2
    type: single_value
    fields: [sales_order_schedule_line_sdt.avg_fill_rate_item]
    listen:
      date: sales_orders_v2.creation_date_erdat_date
      country: countries_md.country_name_landx
      sales_org: sales_organizations_md.sales_org_name_vtext
      distribution_channel: distribution_channels_md.distribution_channel_name_vtext
      product: materials_md.material_text_maktx
      division: divisions_md.division_name_vtext
      sold_to: customers_md.customer_name
    note_state: collapsed
    note_display: hover
    note_text: "The percentage of sales orders that can be fulfilled immediately by available inventory."
    row: 5
    col: 0
    width: 4
    height: 3

  - title: Cancelled Orders
    name: Cancelled Orders
    explore: sales_orders_v2
    type: single_value
    fields: [sales_orders_v2.cancelled_order_percent]
    listen:
      date: sales_orders_v2.creation_date_erdat_date
      country: countries_md.country_name_landx
      sales_org: sales_organizations_md.sales_org_name_vtext
      distribution_channel: distribution_channels_md.distribution_channel_name_vtext
      product: materials_md.material_text_maktx
      division: divisions_md.division_name_vtext
      sold_to: customers_md.customer_name
    note_state: collapsed
    note_display: hover
    note_text: "The percentage of sales orders with a product cancellation."
    row: 11
    col: 0
    width: 4
    height: 3

  - title: Return Orders
    name: Return Orders
    explore: sales_orders_v2
    type: single_value
    fields: [across_sales_and_returns_xvw.has_return_sales_order_percent]
    listen:
      date: sales_orders_v2.creation_date_erdat_date
      country: countries_md.country_name_landx
      sales_org: sales_organizations_md.sales_org_name_vtext
      distribution_channel: distribution_channels_md.distribution_channel_name_vtext
      product: materials_md.material_text_maktx
      division: divisions_md.division_name_vtext
      sold_to: customers_md.customer_name
    note_state: collapsed
    note_display: hover
    note_text: "The percentage of sales orders with a product return."
    row: 9
    col: 0
    width: 4
    height: 3

  - title: Order vs Delivery Efficiency
    name: Order vs Delivery Efficiency
    explore: sales_orders_v2
    type: looker_line
    fields: [materials_md.material_number_matnr, materials_md.material_text_maktx, across_sales_and_deliveries_xvw.difference_order_qty_delivery_qty,
      sales_orders_v2.total_ordered_quantity, deliveries.total_delivered_quantity, across_sales_and_deliveries_xvw.difference_delivery_qty_order_qty,
      across_sales_and_deliveries_xvw.percent_difference_order_qty_delivery_qty]
    sorts: [across_sales_and_deliveries_xvw.difference_order_qty_delivery_qty desc]
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
    y_axes: [{label: '', orientation: left, series: [{axisId: sales_orders_v2.total_ordered_quantity,
          id: sales_orders_v2.total_ordered_quantity, name: Total Order Quantity}, {axisId: deliveries.total_delivered_quantity,
          id: deliveries.total_delivered_quantity, name: Total Quantity Delivered},
        {axisId: across_sales_and_deliveries_xvw.difference_order_qty_delivery_qty,
          id: across_sales_and_deliveries_xvw.difference_order_qty_delivery_qty,
          name: Difference Order Quantity Delivery Quantity}], showLabels: true, showValues: true,
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
      sales_orders_v2.total_ordered_quantity: column
      deliveries.total_delivered_quantity: column
    series_colors:
      sales_orders_v2.total_ordered_quantity: "#12B5CB"
      deliveries.total_delivered_quantity: "#A6CFD5"
      across_sales_and_deliveries_xvw.difference_order_qty_delivery_qty: "#596157"
    series_labels:
      sales_orders_v2.total_ordered_quantity: Total Quantity Ordered
      deliveries.total_delivered_quantity: Total Quantity Delivered
    label_color: []
    reference_lines: []
    x_axis_label_rotation: 0
    advanced_vis_config: |-
      {
        chart: {},
        series: [{
          name: 'Difference'
        }, {
          name: 'Total Quantity Ordered',
          dataLabels: {
            enabled: false,
          }
        }, {
          name: 'Total Quantity Delivered',
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
    note_text: Top 10 Products with Largest Difference between Quantity Ordered and Delivered
    hidden_fields: [materials_md.material_number_matnr, across_sales_and_deliveries_xvw.difference_delivery_qty_order_qty,
      across_sales_and_deliveries_xvw.percent_difference_order_qty_delivery_qty]
    listen:
      date: sales_orders_v2.creation_date_erdat_date
      country: countries_md.country_name_landx
      sales_org: sales_organizations_md.sales_org_name_vtext
      distribution_channel: distribution_channels_md.distribution_channel_name_vtext
      product: materials_md.material_text_maktx
      division: divisions_md.division_name_vtext
      sold_to: customers_md.customer_name
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
        # date: sales_orders_v2.creation_date_erdat_date
        # country: countries_md.country_name_landx
        # sales_org: sales_organizations_md.sales_org_name_vtext
        # distribution_channel: distribution_channels_md.distribution_channel_name_vtext
        # product: materials_md.material_text_maktx
        # division: divisions_md.division_name_vtext
        # sold_to: customers_md.customer_name
  #   row: 3
  #   col: 7
  #   width: 17
  #   height: 12