- dashboard: otc_order_details
  title: Order Details
  layout: newspaper
  preferred_viewer: dashboards-next
  crossfilter_enabled: true
  description: ''
  preferred_slug: Qrlbm8ZvmtMjrMzVPn1xl4

  # pull navigation bar and filters from template
  # if using navigation_focus_page parameter for active dashboard update navigation tile to use the correct filter
  extends: otc_template

  filters:
  - name: order_status
    title: Order Status
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: button_group
      display: popover
    explore: sales_orders_v2
    field: across_sales_and_billing_summary_xvw.order_status

  - name: is_blocked
    title: Is Blocked
    type: field_filter
    default_value: 'No'
    allow_multiple_values: true
    required: false
    ui_config:
      type: button_toggles
      display: inline
    explore: sales_orders_v2
    listens_to_filters: []
    field: deliveries.is_blocked

  elements:

  - name: dashboard_navigation
    filters:
      otc_dashboard_navigation_ext.parameter_navigation_focus_page: '5'
      otc_dashboard_navigation_ext.parameter_navigation_subject: 'odetails'


  # - name: header_order_status
  #   type: text
  #   title_text: <font color="#808080">What is my Order Status?</font>
  #   body_text: ''
  #   row: 2
  #   col: 0
  #   width: 24
  #   height: 1

  # - title: Total Orders
  #   name: Total Orders
  #   explore: sales_orders_v2
  #   type: single_value
  #   fields: [sales_orders_v2.count_orders]
  #   listen:
  #     # " Order Status": sales_orders.sales_order_status
  #     Order Date: sales_orders_v2.creation_date_erdat_date
  #     Division: divisions_md.division_name_vtext
  #     Country: countries_md.country_name_landx
  #     Sales Org: sales_organizations_md.sales_org_name_vtext
  #     Distribution Channel: distribution_channels_md.distribution_channel_name_vtext
  #     Product: materials_md.material_text_maktx
  #   note_state: collapsed
  #   note_display: hover
  #   note_text: "The number of sales orders (document category type = C)."
  #   row: 2
  #   col: 0
  #   width: 5
  #   height: 4

  # - title: Blocked Orders
  #   name: Blocked Orders
  #   explore: sales_orders_v2
  #   type: single_value
  #   fields: [across_sales_and_deliveries_xvw.count_blocked_orders]
  #   # enable_conditional_formatting: true
  #   # conditional_formatting_include_totals: false
  #   # conditional_formatting_include_nulls: false
  #   # conditional_formatting: [{type: greater than, value: 5, background_color: '',
  #   #     font_color: "#EA4335",
  #   #     bold: false, italic: false, strikethrough: false, fields: !!null ''}]
  #   listen:
  #     # " Order Status": sales_orders_v2.sales_order_status
  #     Order Date: sales_orders_v2.creation_date_erdat_date
  #     Division: divisions_md.division_name_vtext
  #     Country: countries_md.country_name_landx
  #     Sales Org: sales_organizations_md.sales_org_name_vtext
  #     Distribution Channel: distribution_channels_md.distribution_channel_name_vtext
  #     Product: materials_md.material_text_maktx
  #   note_state: collapsed
  #   note_display: hover
  #   note_text: "The number of sales orders blocked for delivery reasons (such as customers exceeding credit limit or insufficient stock)."
  #   row: 2
  #   col: 5
  #   width: 5
  #   height: 4

  # - title: Order Status
  #   name: Order Status Bar
  #   explore: sales_orders_v2
  #   type: looker_bar
  #   fields: [across_sales_and_billing_summary_xvw.order_status, sales_orders_v2.count_orders]
  #   pivots: [across_sales_and_billing_summary_xvw.order_status]
  #   filters:
  #     across_sales_and_billing_summary_xvw.order_status: "-NULL"
  #   sorts: [across_sales_and_billing_summary_xvw.order_status desc]
  #   limit: 500
  #   column_limit: 50
  #   x_axis_gridlines: false
  #   y_axis_gridlines: true
  #   show_view_names: false
  #   show_y_axis_labels: true
  #   show_y_axis_ticks: true
  #   y_axis_tick_density: default
  #   y_axis_tick_density_custom: 5
  #   show_x_axis_label: true
  #   show_x_axis_ticks: false
  #   y_axis_scale_mode: linear
  #   x_axis_reversed: false
  #   y_axis_reversed: false
  #   plot_size_by_field: false
  #   trellis: ''
  #   stacking: percent
  #   limit_displayed_rows: false
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
  #   y_axes: [{label: '', orientation: bottom, series: [{axisId: Open - sales_orders_v2.count_orders,
  #           id: Open - sales_orders_v2.count_orders, name: Open}, {axisId: Closed
  #             - sales_orders_v2.count_orders, id: Closed - sales_orders_v2.count_orders,
  #           name: Closed}, {axisId: Cancelled - sales_orders_v2.count_orders, id: Cancelled
  #             - sales_orders_v2.count_orders, name: Cancelled}], showLabels: false,
  #       showValues: false, unpinAxis: false, tickDensity: default, tickDensityCustom: 5,
  #       type: linear}]
  #   x_axis_zoom: true
  #   y_axis_zoom: true
  #   hide_legend: true
  #   series_colors:
  #     Open - sales_orders_v2.count_orders: "#98B6B1"
  #     Closed - sales_orders_v2.count_orders: "#BFBDC1"
  #     Cancelled - sales_orders_v2.count_orders: "#Eb9486"
  #   advanced_vis_config: "{\n  title: {\n    text: \"Order Status\",\n    verticalAlign:\
  #     \ 'bottom',\n    \n    \n  },\n  plotOptions: {\n    series: {\n      dataLabels:\
  #     \ {\n        enabled: true,\n        align: 'center',\n        inside: true,\n\
  #     \        use_html: true,\n        format: '<span style=\"font-size:120%\"<b>{series.name}</b></span><span\
  #     \ style=\"font-weight: normal; font-size:100%;\"><br><br>{point.y: ,.0f}<br>{percentage:.1f}%</span>',\n\
  #     \      },\n    },\n  },\n  series: [{\n    name: 'Open',\n    dataLabels: {\n\
  #     \      enabled: true,\n    },\n  }, {\n    name: 'Closed',\n    dataLabels:\
  #     \ {\n      enabled: true,\n    },\n  }, {\n    name: 'Cancelled',\n    dataLabels:\
  #     \ {\n      enabled: true,\n      inside: true,\n      align: 'left',\n     \
  #     \ x: 40\n    },\n  }]\n}"
  #   defaults_version: 1
  #   title_hidden: true
  #   listen:
  #     # " Order Status": sales_orders_v2.sales_order_status
  #     Order Date: sales_orders_v2.creation_date_erdat_date
  #     Division: divisions_md.division_name_vtext
  #     Country: countries_md.country_name_landx
  #     Sales Org: sales_organizations_md.sales_org_name_vtext
  #     Distribution Channel: distribution_channels_md.distribution_channel_name_vtext
  #     Product: materials_md.material_text_maktx
  #   row: 2
  #   col: 10
  #   width: 14
  #   height: 4

  - title: Order Details
    name: Order Details
    explore: sales_orders_v2
    type: looker_grid
    fields: [across_sales_and_billing_summary_xvw.order_status_with_symbols, deliveries.blocked_status_with_symbol,
      sales_orders_v2.sales_document_vbeln, sales_orders_v2.item_posnr, materials_md.material_text_maktx,
      sales_order_item_partner_function_sdt.customer_names_sold_to, sales_order_item_partner_function_sdt.customer_names_ship_to,
      sales_order_item_partner_function_sdt.customer_names_bill_to, sales_orders_v2.creation_date_erdat_date,
      sales_orders_v2.requested_delivery_date_vdatu_date, sales_order_item_delivery_summary_ndt.max_proof_of_delivery_date_podat,
      sales_orders_v2.base_unit_of_measure_meins, currency_conversion_sdt.from_currency_fcurr,
      currency_conversion_sdt.to_currency_tcurr, currency_conversion_sdt.exchange_rate_ukurs,
      sales_orders_v2.total_quantity_ordered, sales_order_item_delivery_summary_ndt.sum_total_quantity_delivered,
      sales_orders_v2.total_net_value, across_sales_and_currency_conversion_xvw.total_net_value_target]

    sorts: [sales_orders_v2.sales_document_vbeln]
    limit: 50
    column_limit: 50
    show_view_names: false
    show_row_numbers: false
    truncate_text: false
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    pinned_columns:
      across_sales_and_billing_summary_xvw.order_status_with_symbols: left
      deliveries.blocked_status_with_symbol: left
      sales_orders_v2.sales_document_vbeln: left
      sales_orders_v2.item_posnr: left
    column_order: [across_sales_and_billing_summary_xvw.order_status_with_symbols,
      deliveries.blocked_status_with_symbol, sales_orders_v2.sales_document_vbeln,
      sales_orders_v2.item_posnr, materials_md.material_text_maktx, sales_order_item_partner_function_sdt.customer_names_sold_to,
      sales_order_item_partner_function_sdt.customer_names_ship_to, sales_order_item_partner_function_sdt.customer_names_bill_to,
      sales_orders_v2.creation_date_erdat_date, sales_orders_v2.requested_delivery_date_vdatu_date,
      sales_order_item_delivery_summary_ndt.max_proof_of_delivery_date_podat, sales_orders_v2.total_quantity_ordered,
      sales_orders_v2.base_unit_of_measure_meins, sales_order_item_delivery_summary_ndt.sum_total_quantity_delivered,
      sales_orders_v2.total_net_value, currency_conversion_sdt.from_currency_fcurr,
      across_sales_and_currency_conversion_xvw.total_net_value_target, currency_conversion_sdt.to_currency_tcurr,
      currency_conversion_sdt.exchange_rate_ukurs]
    truncate_header: false
    minimum_column_width: 75
    series_labels:
      across_sales_and_billing_summary_xvw.order_status_with_symbols: Order Status
      deliveries.blocked_status_with_symbol: Blocked
      sales_order_item_partner_function_sdt.customer_names_sold_to: Sold To
      sales_order_item_partner_function_sdt.customer_names_ship_to: Ship To
      sales_order_item_partner_function_sdt.customer_names_bill_to: Billed To
      sales_orders_v2.creation_date_erdat_date: Creation Date
      sales_orders_v2.requested_delivery_date_vdatu_date: Requested Delivery Date
      sales_order_item_delivery_summary_ndt.max_proof_of_delivery_date_podat: Proof
        of Delivery Date
      sales_orders_v2.base_unit_of_measure_meins: Base UoM
      currency_conversion_sdt.from_currency_fcurr: Document Currency
      currency_conversion_sdt.to_currency_tcurr: Target Currency
      currency_conversion_sdt.exchange_rate_ukurs: Exchange Rate
      sales_orders_v2.total_net_value: Total Net Value (Document)
      across_sales_and_currency_conversion_xvw.total_net_value_target: Total Net Value (Target)
    series_column_widths:
      sales_orders_v2.total_quantity_ordered: 100
      materials_md.material_text_maktx: 150
      sales_orders_v2.base_unit_of_measure_meins: 75
      sales_order_item_delivery_summary_ndt.sum_total_quantity_delivered: 100
      sales_orders_v2.creation_date_erdat_date: 100
      sales_orders_v2.requested_delivery_date_vdatu_date: 100
      sales_order_item_delivery_summary_ndt.max_proof_of_delivery_date_podat: 100
      currency_conversion_sdt.from_currency_fcurr: 75
      currency_conversion_sdt.to_currency_tcurr: 75
      across_sales_and_currency_conversion_xvw.total_net_value_target: 75
      sales_orders_v2.total_net_value: 75

    series_cell_visualizations:
      sales_orders_v2.total_quantity_ordered:
        is_active: false
    defaults_version: 1
    note_state: expanded
    note_display: below
    note_text: |-
      <font size="-2">Limited to 50 Order Items. To see more, select "Explore from Here" option and adjust row limit setting.
      </font>
    listen:
      date: sales_orders_v2.creation_date_erdat_date
      country: countries_md.country_name_landx
      sales_org: sales_organizations_md.sales_org_name_vtext
      distribution_channel: distribution_channels_md.distribution_channel_name_vtext
      product: materials_md.material_text_maktx
      division: divisions_md.division_name_vtext
      sold_to: customers_md.customer_name
      target_currency: otc_common_parameters_xvw.parameter_target_currency
      order_status: across_sales_and_billing_summary_xvw.order_status
      is_blocked: deliveries.is_blocked
    row: 7
    col: 0
    width: 24
    height: 9
