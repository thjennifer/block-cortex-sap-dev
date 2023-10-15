- dashboard: sales_order_details
  title: Sales Order Details
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


  - name: header_order_status
    type: text
    title_text: <font color="#c1c1c1">What is my Order Status?</font>
    body_text: ''
    row: 2
    col: 0
    width: 24
    height: 1

  - title: Blocked Orders
    name: Blocked Orders
    explore: sales_orders_v2
    type: single_value
    fields: [across_sales_and_deliveries_xvw.count_blocked_orders]
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
    conditional_formatting: [{type: greater than, value: 5, background_color: '',
        font_color: "#EA4335",
        bold: false, italic: false, strikethrough: false, fields: !!null ''}]
    defaults_version: 1
    hidden_fields: []
    y_axes: []
    listen:
      # " Order Status": sales_orders.sales_order_status
      Order Date: sales_orders_v2.creation_date_erdat_date
      Division: divisions_md.division_name_vtext
      Sales Region: countries_md.country_name_landx
      Sales Org: sales_organizations_md.sales_org_name_vtext
      Distribution Channel: distribution_channels_md.distribution_channel_name_vtext
      Product: materials_md.material_text_maktx
    row: 5
    col: 0
    width: 5
    height: 2

  - title: Total Orders
    name: Total Orders
    explore: sales_orders_v2
    type: single_value
    fields: [sales_orders_v2.count_orders]
    limit: 500
    column_limit: 50
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    single_value_title: Total Orders
    defaults_version: 1
    listen:
      # " Order Status": sales_orders.sales_order_status
      Order Date: sales_orders_v2.creation_date_erdat_date
      Division: divisions_md.division_name_vtext
      Sales Region: countries_md.country_name_landx
      Sales Org: sales_organizations_md.sales_org_name_vtext
      Distribution Channel: distribution_channels_md.distribution_channel_name_vtext
      Product: materials_md.material_text_maktx
    row: 3
    col: 0
    width: 5
    height: 2

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
  #     Sales Region: countries_md.country_name_landx
  #     Sales Org: sales_organizations_md.sales_org_name_vtext
  #     Distribution Channel: distribution_channels_md.distribution_channel_name_vtext
  #     Product: materials_md.material_text_maktx
  #   row: 7
  #   col: 0
  #   width: 24
  #   height: 7


  # - title: status stacked bar
  #   name: status stacked bar
  #   explore: sales_orders_v2
  #   type: looker_bar
  #   fields: [sales_orders_v2.sales_order_status, count_of_sales_document_vbeln]
  #   pivots: [sales_orders_v2.sales_order_status]
  #   sorts: [sales_orders_v2.sales_order_status desc]
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
  #   show_x_axis_ticks: false
  #   y_axis_scale_mode: linear
  #   x_axis_reversed: false
  #   y_axis_reversed: false
  #   plot_size_by_field: false
  #   trellis: ''
  #   stacking: normal
  #   limit_displayed_rows: false
  #   legend_position: center
  #   point_style: none
  #   show_value_labels: true
  #   label_density: 25
  #   x_axis_scale: auto
  #   y_axis_combined: true
  #   ordering: none
  #   show_null_labels: false
  #   show_totals_labels: false
  #   show_silhouette: false
  #   totals_color: "#808080"
  #   y_axes: [{label: '', orientation: bottom, series: [{axisId: Open - count_of_sales_document_vbeln,
  #           id: Open - count_of_sales_document_vbeln, name: Open}, {axisId: Closed
  #             - count_of_sales_document_vbeln, id: Closed - count_of_sales_document_vbeln,
  #           name: Closed}, {axisId: Canceled - count_of_sales_document_vbeln, id: Canceled
  #             - count_of_sales_document_vbeln, name: Canceled}], showLabels: false,
  #       showValues: false, unpinAxis: false, tickDensity: default, tickDensityCustom: 5,
  #       type: linear}]
  #   x_axis_zoom: true
  #   y_axis_zoom: true
  #   hide_legend: false
  #   font_size: '14'
  #   series_types: {}
  #   series_colors:
  #     Closed: "#E5E5E5"
  #     Open: "#489fDF"
  #     Canceled: "#E5E5E5"
  #     Canceled - count_of_sales_document_vbeln: "#FFCF9C"
  #   value_labels: none
  #   label_type: labVal
  #   defaults_version: 1
  #   hidden_pivots: {}
  #   title_hidden: true
  #   listen:
  #     " Order Status": sales_orders.sales_order_status
  #     Year: sales_orders.creation_date_erdat_date
  #     Division: divisions_md.division_name_vtext
  #     Sales Region: countries_md.country_name_landx
  #     Sales Org: sales_organizations_md.sales_org_name_vtext
  #     Distribution Channel: distribution_channels_md.distribution_channel_name_vtext
  #     Product: materials_md.material_text_maktx
  #   row: 3
  #   col: 5
  #   width: 19
  #   height: 4


  # filters:

  # - name: " Order Status"
  #   title: " Order Status"
  #   type: field_filter
  #   default_value: ''
  #   allow_multiple_values: true
  #   required: false
  #   ui_config:
  #     type: checkboxes
  #     display: popover
  #     options: []
  #   explore: sales_orders_v2
  #   listens_to_filters: []
  #   field: sales_orders.sales_order_status