- dashboard: otc_billing_and_pricing
  title: Billing and Pricing
  layout: newspaper
  preferred_viewer: dashboards-next
  crossfilter_enabled: false
  description: ''

  # pull navigation bar and filters from template
  # if using navigation_focus_page parameter for active dashboard update navigation tile to use the correct filter
  extends: otc_template

  elements:

    - title: navigation
      name: navigation
      filters:
        navigation_otc_ext.navigation_focus_page: '4'

    - title: Price Adjustments by Customer
      name: Price Adjustments by Customer
      explore: sales_orders_v2
      type: looker_column
      fields: [sales_orders_v2.sold_to_party_kunnr, customers_md.name1_name1, sales_order_pricing_sdt.avg_list_price_target,
        sales_order_pricing_sdt.avg_adjusted_price_target_curr, sales_order_pricing_sdt.abs_difference_list_and_adjusted_price]
      filters:
        sales_order_pricing_sdt.adjusted_price: NOT NULL
      sorts: [sales_order_pricing_sdt.abs_difference_list_and_adjusted_price desc]
      limit: 500
      column_limit: 50
      x_axis_gridlines: false
      y_axis_gridlines: false
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
      show_value_labels: true
      label_density: 25
      x_axis_scale: auto
      y_axis_combined: true
      ordering: none
      show_null_labels: false
      show_totals_labels: false
      show_silhouette: false
      totals_color: "#808080"
      y_axes: [{label: '', orientation: left, series: [{axisId: sales_order_pricing_sdt.avg_list_price_target,
              id: sales_order_pricing_sdt.avg_list_price_target, name: Average
                List Price (USD)}, {axisId: sales_order_pricing_sdt.avg_adjusted_price_target_curr,
              id: sales_order_pricing_sdt.avg_adjusted_price_target_curr, name: Average
                Adjusted Price (USD)}], showLabels: true, showValues: false, unpinAxis: false,
          tickDensity: default, tickDensityCustom: 5, type: linear}]
      x_axis_zoom: true
      y_axis_zoom: true
      series_colors:
        sales_order_pricing_sdt.avg_list_price_target: "#214a43"
        sales_order_pricing_sdt.avg_adjusted_price_target_curr: "#51726e"
      defaults_version: 1
      hidden_fields: [sales_orders_v2.sold_to_party_kunnr, sales_order_pricing_sdt.abs_difference_list_and_adjusted_price]
      listen:
        Order Date: sales_orders_v2.creation_date_erdat_date
        Division: divisions_md.division_name_vtext
        Country: countries_md.country_name_landx
        Sales Org: sales_organizations_md.sales_org_name_vtext
        Distribution Channel: distribution_channels_md.distribution_channel_name_vtext
        Product: materials_md.material_text_maktx
        Target Currency: currency_conversion_sdt.select_target_currency
      row: 2
      col: 0
      width: 22
      height: 11

    - title: Price Adjustments by Product Availability
      name: Price Adjustments by Product Availability
      model: cortex_sap_operational_v2
      explore: sales_orders_v2
      type: looker_column
      fields: [sales_order_pricing_sdt.avg_list_price_target, materials_md.material_number_matnr,
        materials_md.material_text_maktx, sales_order_pricing_sdt.avg_intercompany_price_target_curr]
      filters:
        sales_order_pricing_sdt.inter_company_price: NOT NULL
      sorts: [sales_order_pricing_sdt.avg_intercompany_price_target_curr desc]
      limit: 500
      column_limit: 50
      x_axis_gridlines: false
      y_axis_gridlines: false
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
      limit_displayed_rows: true
      legend_position: center
      point_style: circle_outline
      show_value_labels: true
      label_density: 25
      x_axis_scale: auto
      y_axis_combined: true
      ordering: none
      show_null_labels: false
      show_totals_labels: false
      show_silhouette: false
      totals_color: "#808080"
      y_axes: [{label: '', orientation: left, series: [{axisId: sales_order_pricing_sdt.avg_list_price_target,
              id: sales_order_pricing_sdt.avg_list_price_target, name: Average
                List Price (USD)}, {axisId: sales_order_pricing_sdt.avg_intercompany_price_target_curr,
              id: sales_order_pricing_sdt.avg_intercompany_price_target_curr, name: Average
                Intercompany Price (USD)}], showLabels: true, showValues: false, unpinAxis: false,
          tickDensity: default, tickDensityCustom: 5, type: linear}]
      x_axis_zoom: true
      y_axis_zoom: true
      limit_displayed_rows_values:
        show_hide: show
        first_last: first
        num_rows: '10'
      series_colors:
        sales_order_pricing_sdt.avg_list_price_target: "#214a43"
        sales_order_pricing_sdt.avg_intercompany_price_target_curr: "#879d9d"
      show_null_points: false
      interpolation: step
      discontinuous_nulls: false
      defaults_version: 1
      hidden_fields: []
      hidden_pivots: {}
      listen:
        Order Date: sales_orders_v2.creation_date_erdat_date
        Division: divisions_md.division_name_vtext
        Country: countries_md.country_name_landx
        Sales Org: sales_organizations_md.sales_org_name_vtext
        Distribution Channel: distribution_channels_md.distribution_channel_name_vtext
        Product: materials_md.material_text_maktx
        Target Currency: currency_conversion_sdt.select_target_currency
      row: 13
      col: 0
      width: 22
      height: 11
