- dashboard: sales_performance
  title: Sales Performance
  layout: newspaper
  preferred_viewer: dashboards-next
  crossfilter_enabled: true
  description: ''

  # pull navigation bar and filters from template
  # if using navigation_focus_page parameter for active dashboard update navigation tile to use the correct filter
  extends: sales_order_to_cash_template

  elements:

  - title: navigation
    name: navigation
    filters:
      navigation_sales_otc_ext.navigation_focus_page: '4'

  - name: Top Products by Sales
    title: Top Products by Sales
    explore: sales_orders_v2
    type: looker_bar
    fields: [materials_md.material_number_matnr, materials_md.material_text_maktx, across_sales_and_currency_conversion_xvw.total_net_value_global]
    sorts: [across_sales_and_currency_conversion_xvw.total_net_value_global desc]
    limit: 10
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_y_axis_labels: false
    show_y_axis_ticks: true
    show_x_axis_label: false
    show_x_axis_ticks: true
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    series_colors:
      {across_sales_and_currency_conversion_xvw.total_net_value_global: "#74A09F"}

    y_axes: [{label: '', orientation: bottom, series: [{axisId: across_sales_and_currency_conversion_xvw.total_net_value_global,
            id: across_sales_and_currency_conversion_xvw.total_net_value_global, name: Total
              Net Value (Global Currency 'USD')}], showLabels: true, showValues: false,
        unpinAxis: false, tickDensity: default, tickDensityCustom: 5, type: linear}]
    x_axis_zoom: true
    y_axis_zoom: true
    hidden_fields: [materials_md.material_number_matnr]

    listen:
      Order Date: sales_orders_v2.creation_date_erdat_date
      Division: divisions_md.division_name_vtext
      Country: countries_md.country_name_landx
      Sales Org: sales_organizations_md.sales_org_name_vtext
      Distribution Channel: distribution_channels_md.distribution_channel_name_vtext
      Product: materials_md.material_text_maktx
      Global Currency: currency_conversion_sdt.select_global_currency

    row: 2
    col: 0
    width: 10
    height: 10

  - name: Top Sales Organizations by Sales
    title: Top Sales Organizations by Sales
    explore: sales_orders_v2
    type: looker_bar
    fields: [sales_orders_v2.sales_organization_vkorg,sales_organizations_md.sales_org_name_vtext,across_sales_and_currency_conversion_xvw.total_net_value_global]
    sorts: [across_sales_and_currency_conversion_xvw.total_net_value_global desc]
    limit: 10
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_y_axis_labels: false
    show_y_axis_ticks: true
    show_x_axis_label: false
    show_x_axis_ticks: true
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    series_colors:
      {across_sales_and_currency_conversion_xvw.total_net_value_global: "#74A09F"}

    y_axes: [{label: '', orientation: bottom, series: [{axisId: across_sales_and_currency_conversion_xvw.total_net_value_global,
            id: across_sales_and_currency_conversion_xvw.total_net_value_global, name: Total
              Net Value (Global Currency 'USD')}], showLabels: true, showValues: false,
        unpinAxis: false, tickDensity: default, tickDensityCustom: 5, type: linear}]
    x_axis_zoom: true
    y_axis_zoom: true
    hidden_fields: [sales_orders_v2.sales_organization_vkorg]

    listen:
      Order Date: sales_orders_v2.creation_date_erdat_date
      Division: divisions_md.division_name_vtext
      Country: countries_md.country_name_landx
      Sales Org: sales_organizations_md.sales_org_name_vtext
      Distribution Channel: distribution_channels_md.distribution_channel_name_vtext
      Product: materials_md.material_text_maktx
      Global Currency: currency_conversion_sdt.select_global_currency

    row: 2
    col: 11
    width: 10
    height: 10