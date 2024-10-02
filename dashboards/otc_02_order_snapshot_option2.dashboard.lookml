- dashboard: otc_order_snapshot
  title: Order Status
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
      navigation_otc_ext.navigation_focus_page: '2'

  - title: Total Orders
    name: Total Orders
    explore: sales_orders_v2
    type: single_value
    fields: [sales_orders_v2.count_orders]
    listen:
      # " Order Status": sales_orders.sales_order_status
      date: sales_orders_v2.creation_date_erdat_date
      country: countries_md.country_name_landx
      sales_org: sales_organizations_md.sales_org_name_vtext
      distribution_channel: distribution_channels_md.distribution_channel_name_vtext
      product: materials_md.material_text_maktx
      division: divisions_md.division_name_vtext
      sold_to: customers_md.customer_name
    note_state: collapsed
    note_display: hover
    note_text: "The number of sales orders (document category type = C)."
    row: 2
    col: 0
    width: 4
    height: 3

  - name: Order Status
    title: Order Status
    explore: sales_orders_v2
    type: looker_column
    # fields: [across_sales_and_billing_summary_xvw.order_status, sales_orders_v2.count_orders]
    fields: [across_sales_and_billing_summary_xvw.order_status, sales_orders_v2.count_orders_with_link, across_sales_and_billing_summary_xvw.max_order_status]
    pivots: [across_sales_and_billing_summary_xvw.order_status]
    hidden_fields: [across_sales_and_billing_summary_xvw.max_order_status]
    filters:
      across_sales_and_billing_summary_xvw.order_status: "-NULL"
    sorts: [across_sales_and_billing_summary_xvw.order_status]
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
    show_x_axis_ticks: false
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: percent
    limit_displayed_rows: false
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
    # y_axes: [{label: '', orientation: bottom, series: [{axisId: Open - sales_orders_v2.count_orders,
    #         id: Open - sales_orders_v2.count_orders, name: Open, __FILE: block-revamp-sap-dev/dashboards/otc_03_order_details.dashboard.lookml,
    #         __LINE_NUM: 116}, {axisId: Closed - sales_orders_v2.count_orders, id: Closed
    #           - sales_orders_v2.count_orders, name: Closed, __FILE: block-revamp-sap-dev/dashboards/otc_03_order_details.dashboard.lookml,
    #         __LINE_NUM: 117}, {axisId: Cancelled - sales_orders_v2.count_orders, id: Cancelled
    #           - sales_orders_v2.count_orders, name: Cancelled, __FILE: block-revamp-sap-dev/dashboards/otc_03_order_details.dashboard.lookml,
    #         __LINE_NUM: 119}], showLabels: false, showValues: false, unpinAxis: false,
    #     tickDensity: default, tickDensityCustom: 5, type: linear, __FILE: block-revamp-sap-dev/dashboards/otc_03_order_details.dashboard.lookml,
    #     __LINE_NUM: 116}]
    y_axes: [{label: '', orientation: bottom, series: [{axisId: Open - sales_orders_v2.count_orders_with_link,
            id: Open - sales_orders_v2.count_orders_with_link, name: Open, }, {axisId: Closed - sales_orders_v2.count_orders, id: Closed
              - sales_orders_v2.count_orders_with_link, name: Closed, }, {axisId: Cancelled - sales_orders_v2.count_orders_with_link, id: Cancelled
              - sales_orders_v2.count_orders_with_link, name: Cancelled, }], showLabels: false, showValues: false, unpinAxis: false,
        tickDensity: default, tickDensityCustom: 5, type: linear, }]



    x_axis_zoom: true
    y_axis_zoom: true
    hide_legend: true
    # series_colors:
    #   Open - sales_orders_v2.count_orders: "#98B6B1"
    #   Closed - sales_orders_v2.count_orders: "#BFBDC1"
    #   Cancelled - sales_orders_v2.count_orders: "#Eb9486"
    series_colors:
      Open - sales_orders_v2.count_orders_with_link: "#98B6B1"
      Closed - sales_orders_v2.count_orders_with_link: "#BFBDC1"
      Cancelled - sales_orders_v2.count_orders_with_link: "#Eb9486"
    advanced_vis_config: |-
      {
        plotOptions: {
          series: {
            dataLabels: {
              enabled: true,
              align: 'center',
              inside: true,
              use_html: true,
              format: '<span style="font-size:140%"<b>{series.name}</b></span><span style="font-weight: normal; font-size:100%; "><br><br>{point.y: ,.0f}  ({percentage:.1f}%)</span>',
            },
          },
        },
        series: [{
          name: 'Cancelled',
          dataLabels: {
            enabled: true,
            inside: true,
          },
        }, {
          name: 'Closed',
          dataLabels: {
            enabled: true,
            inside: true,
          },
        }, {
          name: 'Open',
          dataLabels: {
            enabled: true,
            inside: true,

          },
        }]
      }
    listen:
      date: sales_orders_v2.creation_date_erdat_date
      country: countries_md.country_name_landx
      sales_org: sales_organizations_md.sales_org_name_vtext
      distribution_channel: distribution_channels_md.distribution_channel_name_vtext
      product: materials_md.material_text_maktx
      division: divisions_md.division_name_vtext
      sold_to: customers_md.customer_name
    row: 5
    col: 0
    width: 4
    height: 9

  - title: Blocked Orders
    name: Blocked Orders
    explore: sales_orders_v2
    type: single_value
    fields: [sales_orders_v2.count_orders_with_link]
    filters:
      deliveries.is_blocked: 'Yes'
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
    note_text: "The number of sales orders blocked for delivery reasons (such as customers exceeding credit limit or insufficient stock)."
    row: 2
    col: 4
    width: 4
    height: 3

  - title: Return Orders
    name: Return Orders
    explore: sales_orders_v2
    type: single_value
    fields: [across_sales_and_returns_xvw.percent_orders_with_return]
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
    row: 5
    col: 4
    width: 4
    height: 3

  - title: One Touch Orders
    name: One Touch Orders
    explore: sales_orders_v2
    type: single_value
    fields: [one_touch_order.percent_one_touch_orders]
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
    row: 8
    col: 4
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
    row: 11
    col: 4
    width: 4
    height: 3





  - title: Order vs Delivery Quantity
    name: Order vs Delivery Quantity
    explore: sales_orders_v2
    type: looker_line
    fields: [materials_md.material_number_matnr, materials_md.material_text_maktx, across_sales_and_deliveries_xvw.difference_order_qty_delivery_qty,
      sales_orders_v2.total_quantity_ordered, deliveries.total_quantity_delivered, across_sales_and_deliveries_xvw.difference_delivery_qty_order_qty,
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
    y_axes: [{label: '', orientation: left, series: [{axisId: sales_orders_v2.total_quantity_ordered,
          id: sales_orders_v2.total_quantity_ordered, name: Total Order Quantity}, {axisId: deliveries.total_quantity_delivered,
          id: deliveries.total_quantity_delivered, name: Total Quantity Delivered},
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
      sales_orders_v2.total_quantity_ordered: column
      deliveries.total_quantity_delivered: column
    series_colors:
      sales_orders_v2.total_quantity_ordered: "#12B5CB"
      deliveries.total_quantity_delivered: "#A6CFD5"
      across_sales_and_deliveries_xvw.difference_order_qty_delivery_qty: "#596157"
    series_labels:
      sales_orders_v2.total_quantity_ordered: Total Quantity Ordered
      deliveries.total_quantity_delivered: Total Quantity Delivered
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
    col: 8
    width: 15
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
