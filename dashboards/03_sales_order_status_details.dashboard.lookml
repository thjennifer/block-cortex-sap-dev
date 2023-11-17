- dashboard: sales_order_status_details
  title: Sales Order Status Details
  layout: newspaper
  preferred_viewer: dashboards-next
  crossfilter_enabled: true
  description: ''
  preferred_slug: Qrlbm8ZvmtMjrMzVPn1xl4

  # pull navigation bar and filters from template
  # if using focus_page parameter for active dashboard update navigation tile to use the correct filter
  extends: sales_order_to_cash_template

  elements:

  - title: navigation
    name: navigation
    filters:
      navigation_sales_otc_ext.focus_page: '3'


  # - name: header_order_status
  #   type: text
  #   title_text: <font color="#808080">What is my Order Status?</font>
  #   body_text: ''
  #   row: 2
  #   col: 0
  #   width: 24
  #   height: 1

  - title: Total Orders
    name: Total Orders
    explore: sales_orders_v2
    type: single_value
    fields: [sales_orders_v2.count_orders]
    listen:
      # " Order Status": sales_orders.sales_order_status
      Order Date: sales_orders_v2.creation_date_erdat_date
      Division: divisions_md.division_name_vtext
      Country: countries_md.country_name_landx
      Sales Org: sales_organizations_md.sales_org_name_vtext
      Distribution Channel: distribution_channels_md.distribution_channel_name_vtext
      Product: materials_md.material_text_maktx
    row: 2
    col: 0
    width: 5
    height: 4

  - title: Blocked Orders
    name: Blocked Orders
    explore: sales_orders_v2
    type: single_value
    fields: [across_sales_and_deliveries_xvw.count_blocked_orders]
    # enable_conditional_formatting: true
    # conditional_formatting_include_totals: false
    # conditional_formatting_include_nulls: false
    # conditional_formatting: [{type: greater than, value: 5, background_color: '',
    #     font_color: "#EA4335",
    #     bold: false, italic: false, strikethrough: false, fields: !!null ''}]
    listen:
      # " Order Status": sales_orders_v2.sales_order_status
      Order Date: sales_orders_v2.creation_date_erdat_date
      Division: divisions_md.division_name_vtext
      Country: countries_md.country_name_landx
      Sales Org: sales_organizations_md.sales_org_name_vtext
      Distribution Channel: distribution_channels_md.distribution_channel_name_vtext
      Product: materials_md.material_text_maktx
    row: 2
    col: 5
    width: 5
    height: 4

  - title: Order Status
    name: Order Status Bar
    explore: sales_orders_v2
    type: looker_bar
    fields: [across_sales_and_billing_summary_xvw.order_status, sales_orders_v2.count_orders]
    pivots: [across_sales_and_billing_summary_xvw.order_status]
    filters:
      across_sales_and_billing_summary_xvw.order_status: "-NULL"
    sorts: [across_sales_and_billing_summary_xvw.order_status desc]
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
    y_axes: [{label: '', orientation: bottom, series: [{axisId: Open - sales_orders_v2.count_orders,
            id: Open - sales_orders_v2.count_orders, name: Open}, {axisId: Closed
              - sales_orders_v2.count_orders, id: Closed - sales_orders_v2.count_orders,
            name: Closed}, {axisId: Cancelled - sales_orders_v2.count_orders, id: Cancelled
              - sales_orders_v2.count_orders, name: Cancelled}], showLabels: false,
        showValues: false, unpinAxis: false, tickDensity: default, tickDensityCustom: 5,
        type: linear}]
    x_axis_zoom: true
    y_axis_zoom: true
    hide_legend: true
    series_colors:
      Open - sales_orders_v2.count_orders: "#98B6B1"
      Closed - sales_orders_v2.count_orders: "#BFBDC1"
      Cancelled - sales_orders_v2.count_orders: "#Eb9486"
    advanced_vis_config: "{\n  title: {\n    text: \"Order Status\",\n    verticalAlign:\
      \ 'bottom',\n    \n    \n  },\n  plotOptions: {\n    series: {\n      dataLabels:\
      \ {\n        enabled: true,\n        align: 'center',\n        inside: true,\n\
      \        use_html: true,\n        format: '<span style=\"font-size:120%\"<b>{series.name}</b></span><span\
      \ style=\"font-weight: normal; font-size:100%;\"><br><br>{point.y: ,.0f}<br>{percentage:.1f}%</span>',\n\
      \      },\n    },\n  },\n  series: [{\n    name: 'Open',\n    dataLabels: {\n\
      \      enabled: true,\n    },\n  }, {\n    name: 'Closed',\n    dataLabels:\
      \ {\n      enabled: true,\n    },\n  }, {\n    name: 'Cancelled',\n    dataLabels:\
      \ {\n      enabled: true,\n      inside: true,\n      align: 'left',\n     \
      \ x: 40\n    },\n  }]\n}"
    defaults_version: 1
    title_hidden: true
    listen:
      # " Order Status": sales_orders_v2.sales_order_status
      Order Date: sales_orders_v2.creation_date_erdat_date
      Division: divisions_md.division_name_vtext
      Country: countries_md.country_name_landx
      Sales Org: sales_organizations_md.sales_org_name_vtext
      Distribution Channel: distribution_channels_md.distribution_channel_name_vtext
      Product: materials_md.material_text_maktx
    row: 2
    col: 10
    width: 14
    height: 4

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
      sales_orders_v2.total_net_value, across_sales_and_currency_conversion_xvw.total_net_value_local]

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
      across_sales_and_currency_conversion_xvw.total_net_value_local, currency_conversion_sdt.to_currency_tcurr,
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
      currency_conversion_sdt.from_currency_fcurr: Local Currency
      currency_conversion_sdt.to_currency_tcurr: Global Currency
      currency_conversion_sdt.exchange_rate_ukurs: Exchange Rate
      sales_orders_v2.total_net_value: Total Net Value (Local)
      across_sales_and_currency_conversion_xvw.total_net_value_local: Total Net Value (Global)
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
      across_sales_and_currency_conversion_xvw.total_net_value_local: 75
      sales_orders_v2.total_net_value: 75

    series_cell_visualizations:
      sales_orders_v2.total_quantity_ordered:
        is_active: false
    defaults_version: 1
    note_state: expanded
    note_display: below
    note_text: |-
      <font size="-2">Limited to 50 Order Items. To see more, select Explore from Here option and adjust row limit setting.
      </font>
    listen:
      Order Status: across_sales_and_billing_summary_xvw.order_status
      Order Date: sales_orders_v2.creation_date_erdat_date
      Division: divisions_md.division_name_vtext
      Country: countries_md.country_name_landx
      Sales Org: sales_organizations_md.sales_org_name_vtext
      Distribution Channel: distribution_channels_md.distribution_channel_name_vtext
      Product: materials_md.material_text_maktx
      Global Currency: currency_conversion_sdt.select_global_currency
    # listen:
    #   Order Status: across_sales_and_billing_summary_xvw.order_status
    row: 7
    col: 0
    width: 24
    height: 9

  # - title: Order Status
  #   name: Order Status donut
  #   explore: sales_orders_v2
  #   type: looker_pie
  #   fields: [across_sales_and_billing_summary_xvw.order_status, sales_orders_v2.count_orders]
  #   filters:
  #     across_sales_and_billing_summary_xvw.order_status: "-NULL"
  #   sorts: [across_sales_and_billing_summary_xvw.order_status desc]
  #   value_labels: labels
  #   label_type: labVal
  #   inner_radius: 60
  #   start_angle:
  #   end_angle:
  #   series_colors:
  #     Open: "#D1FAFF"
  #     Closed: "#98B6B1"
  #     Cancelled: "#EB9486"
  #   advanced_vis_config: |-
  #     {
  #       plotOptions: {
  #         pie: {
  #           dataLabels: {
  #             format: '<b>{key}</b><span style="font-weight: normal"> - <br>{percentage:.1f}%<br>{point.rendered}</span>',
  #           }
  #         }
  #       },
  #       title: {
  #         text: 'Order<br>Status',
  #         verticalAlign: 'middle',
  #       }
  #     }
  #   show_value_labels: false
  #   font_size: 12
  #   hidden_pivots: {}
  #   x_axis_gridlines: false
  #   y_axis_gridlines: true
  #   show_view_names: false
  #   show_y_axis_labels: true
  #   show_y_axis_ticks: true
  #   y_axis_tick_density: default
  #   y_axis_tick_density_custom: 5
  #   show_x_axis_label: true
  #   show_x_axis_ticks: true
  #   legend_position: center
  #   point_style: none
  #   label_density: 25
  #   x_axis_scale: auto
  #   y_axis_combined: true
  #   ordering: none
  #   show_null_labels: false
  #   show_totals_labels: false
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
  #   width: 10
  #   height: 5

  # - name: Order Status
  #   title: Order Status semi-circle
  #   explore: sales_orders_v2
  #   type: looker_pie
  #   fields: [across_sales_and_billing_summary_xvw.order_status, sales_orders_v2.count_orders]
  #   filters:
  #     across_sales_and_billing_summary_xvw.order_status: "-NULL"
  #   sorts: [across_sales_and_billing_summary_xvw.order_status desc]
  #   value_labels: labels
  #   label_type: labVal
  #   inner_radius: 60
  #   start_angle: -90
  #   end_angle: 90
  #   series_colors:
  #     Open: "#D1FAFF"
  #     Closed: "#98B6B1"
  #     Cancelled: "#EB9486"
  #   advanced_vis_config: |-
  #     {
  #       plotOptions: {
  #         pie: {
  #           dataLabels: {
  #             format: '<b>{key}</b><span style="font-weight: normal"><br>{point.rendered}<br>{percentage:.1f}%</span>',
  #           }
  #         }
  #       },
  #       title: {
  #         text: 'Status',
  #         verticalAlign: 'middle',
  #       }
  #     }
  #   show_value_labels: false
  #   font_size: 12
  #   hidden_pivots: {}
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
  #   label_density: 25
  #   x_axis_scale: auto
  #   y_axis_combined: true
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
  #   width: 10
  #   height: 5



  # - title: Sales Order Quantity and Value
  #   name: Sales Order Quantity and Value
  #   explore: sales_orders_v2
  #   type: looker_grid
  #   fields: [sales_orders.sales_document_vbeln, sales_orders.item_posnr, materials_md.material_text_maktx,
  #     sales_orders.sales_order_status, sales_orders.cumulative_order_quantity_kwmeng,
  #     sales_orders.base_unit_of_measure_meins, currency_conversion_new.ukurs, sales_orders.sales_order_value_line_item_source_currency,
  #     sales_orders.currency_waerk, sales_orders.sales_order_value_glob_curr, currency_conversion_new.tcurr,
  #     sales_orders.creation_date_erdat_date, deliveries.date__proof_of_delivery___podat_date,
  #     deliveries.delivery_date_lfdat_date, sales_orders.max_sold_to_party_name, sales_orders.max_ship_to_party_name,
  #     sales_orders.max_bill_to_party_name]
  #   sorts: [sales_orders.creation_date_erdat_date desc]
  #   limit: 500
  #   column_limit: 50
  #   show_view_names: false
  #   show_row_numbers: true
  #   transpose: false
  #   truncate_text: true
  #   hide_totals: false
  #   hide_row_totals: false
  #   size_to_fit: true
  #   table_theme: white
  #   limit_displayed_rows: false
  #   enable_conditional_formatting: false
  #   header_text_alignment: left
  #   header_font_size: '12'
  #   rows_font_size: '12'
  #   conditional_formatting_include_totals: false
  #   conditional_formatting_include_nulls: false
  #   show_sql_query_menu_options: false
  #   pinned_columns:
  #     "$$$_row_numbers_$$$": left
  #   column_order: ["$$$_row_numbers_$$$", sales_orders.sales_document_vbeln, sales_orders.item_posnr,
  #     materials_md.material_text_maktx, sales_orders.max_sold_to_party_name, sales_orders.max_ship_to_party_name,
  #     sales_orders.max_bill_to_party_name, sales_orders.creation_date_erdat_date,
  #     deliveries.delivery_date_lfdat_date, deliveries.date__proof_of_delivery___podat_date,
  #     sales_orders.sales_order_status, sales_orders.cumulative_order_quantity_kwmeng,
  #     sales_orders.base_unit_of_measure_meins, currency_conversion_new.ukurs, sales_orders.sales_order_value_line_item_source_currency,
  #     sales_orders.currency_waerk, sales_orders.sales_order_value_glob_curr, currency_conversion_new.tcurr]
  #   show_totals: true
  #   show_row_totals: true
  #   truncate_header: false
  #   series_labels:
  #     sales_orders.sales_document_vbeln: Sales Order
  #     sales_orders.item_posnr: Sales Order Line Item
  #     materials_md.material_text_maktx: Product
  #     customers_md.name1_name1: Sold to Party
  #     customers_md.name2_name2: Ship to Party
  #     customers_md.name3_name3: Bill to Party
  #     sales_orders.sales_order_status: Order Status
  #     sales_orders.cumulative_order_quantity_kwmeng: Sales Order Qty
  #     sales_orders.base_unit_of_measure_meins: Base UoM
  #     currency_conversion_new.ukurs: Exchange Rate
  #     sales_orders.sales_order_value_line_item_source_currency: Sales Order Value
  #       Local Currency
  #     sales_orders.currency_waerk: Local Currency Key
  #     sales_orders.sales_order_value_glob_curr: Sales Order Value Global Currency
  #     currency_conversion_new.tcurr: Global Currency
  #     sales_orders.creation_date_erdat_date: Creation Date
  #     deliveries.date__proof_of_delivery___podat_date: Actual Delivery Date
  #     deliveries.delivery_date_lfdat_date: Requested Delivery date
  #     sales_orders.max_sold_to_party_name: Sold to Party
  #     sales_orders.max_ship_to_party_name: Ship to Party
  #     sales_orders.max_bill_to_party_name: Bill to Party
  #   series_column_widths:
  #     sales_orders.sales_document_vbeln: 111.24000000000001
  #   series_cell_visualizations: {}
  #   series_types: {}
  #   defaults_version: 1
  #   listen:
  #     Year: sales_orders.creation_date_erdat_date
  #     " Order Status": sales_orders.sales_order_status
  #     Division: divisions_md.division_name_vtext
  #     Currency: currency_conversion_new.tcurr
  #     Country: countries_md.country_name_landx
  #     Sales Org: sales_organizations_md.sales_org_name_vtext
  #     Distribution Channel: distribution_channels_md.distribution_channel_name_vtext
  #     Product: materials_md.material_text_maktx
  #   row: 7
  #   col: 0
  #   width: 24
  #   height: 7





  filters:

  - name: "Order Status"
    title: "Order Status"
    type: field_filter
    default_value: 'Cancelled'
    allow_multiple_values: true
    required: false
    ui_config:
      type: checkboxes
      display: popover
      options: []
    explore: sales_orders_v2
    listens_to_filters: []
    field: across_sales_and_billing_summary_xvw.order_status
