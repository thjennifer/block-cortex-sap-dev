- dashboard: otc_order_sales_performance
  title: Sales Performance
  layout: newspaper
  preferred_viewer: dashboards-next
  crossfilter_enabled: true
  description: ''

  # pull navigation bar and filters from template
  # if using navigation_focus_page parameter for active dashboard update navigation tile to use the correct filter
  extends: otc_template

  elements:

  - name: dashboard_navigation
    filters:
      otc_dashboard_navigation_ext.parameter_navigation_focus_page: '2'

  - name: Top Products by Sales
    title: Top Products by Sales
    explore: sales_orders_v2
    type: looker_bar
    fields: [materials_md.material_number_matnr, materials_md.material_text_maktx, across_sales_and_currency_conversion_xvw.total_net_value_target]
    sorts: [across_sales_and_currency_conversion_xvw.total_net_value_target desc]
    limit: 10
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_y_axis_labels: false
    show_y_axis_ticks: true
    show_x_axis_label: false
    show_x_axis_ticks: true
    limit_displayed_rows: false
    legend_position: center
    point_style: circle
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    series_colors:
      {across_sales_and_currency_conversion_xvw.total_net_value_target: "#74A09F"}

    y_axes: [{label: '', orientation: bottom, series: [{axisId: across_sales_and_currency_conversion_xvw.total_net_value_target,
            id: across_sales_and_currency_conversion_xvw.total_net_value_target
            }], showLabels: true, showValues: false,
        unpinAxis: false, tickDensity: default, tickDensityCustom: 5, type: linear}]

    x_axis_zoom: true
    y_axis_zoom: true
    hidden_fields: [materials_md.material_number_matnr]

    listen:
      date: sales_orders_v2.creation_date_erdat_date
      country: countries_md.country_name_landx
      sales_org: sales_organizations_md.sales_org_name_vtext
      distribution_channel: distribution_channels_md.distribution_channel_name_vtext
      product: materials_md.material_text_maktx
      division: divisions_md.division_name_vtext
      sold_to: customers_md.customer_name
      target_currency: otc_common_parameters_xvw.parameter_target_currency
    # note_state: expanded
    note_display: hover
    note_text: |-
      <font size="-2">Limited to 10 Products. To change this row limit, select "Explore from Here" option and adjust the row limit.
      </font>
    row: 2
    col: 0
    width: 10
    height: 10

  - name: Top Products by Avg Sales
    title: Top Products by Avg Sales
    explore: sales_orders_v2
    type: looker_bar
    fields: [materials_md.material_number_matnr, materials_md.material_text_maktx, across_sales_and_currency_conversion_xvw.avg_net_value_per_order_target]
    sorts: [across_sales_and_currency_conversion_xvw.avg_net_value_per_order_target desc]
    # filters:
    #   sales_orders_v2.count_orders: ">=10"
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
      {across_sales_and_currency_conversion_xvw.avg_net_value_per_order_target: "#53575E"}

    y_axes: [{label: '', orientation: bottom, series: [{axisId: across_sales_and_currency_conversion_xvw.total_net_value_target,
            id: across_sales_and_currency_conversion_xvw.avg_net_value_per_order_target, name: Avg Sales per Order (Target Currency 'USD')}], showLabels: true, showValues: false,
        unpinAxis: false, tickDensity: default, tickDensityCustom: 5, type: linear}]
    x_axis_zoom: true
    y_axis_zoom: true
    hidden_fields: [materials_md.material_number_matnr]

    listen:
      date: sales_orders_v2.creation_date_erdat_date
      country: countries_md.country_name_landx
      sales_org: sales_organizations_md.sales_org_name_vtext
      distribution_channel: distribution_channels_md.distribution_channel_name_vtext
      product: materials_md.material_text_maktx
      division: divisions_md.division_name_vtext
      sold_to: customers_md.customer_name
      target_currency: otc_common_parameters_xvw.parameter_target_currency
    # note_state: expanded
    note_display: hover
    note_text: |-
      <font size="-2">Average Sales per Order (Target Currency).<br>Limited to 10 Products. To change this row limit, select "Explore from Here" option and adjust the row limit.
      </font>
    row: 2
    col: 11
    width: 10
    height: 10

  - name: Top Sales Organizations by Sales
    title: Top Sales Organizations by Sales
    explore: sales_orders_v2
    type: looker_bar
    fields: [sales_orders_v2.sales_organization_vkorg,sales_organizations_md.sales_org_name_vtext,across_sales_and_currency_conversion_xvw.total_net_value_target]
    sorts: [across_sales_and_currency_conversion_xvw.total_net_value_target desc]
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
      {across_sales_and_currency_conversion_xvw.total_net_value_target: "#74A09F"}

    y_axes: [{label: '', orientation: bottom, series: [{axisId: across_sales_and_currency_conversion_xvw.total_net_value_target,
            id: across_sales_and_currency_conversion_xvw.total_net_value_target, name: Total
              Net Value}], showLabels: true, showValues: false,
        unpinAxis: false, tickDensity: default, tickDensityCustom: 5, type: linear}]
    x_axis_zoom: true
    y_axis_zoom: true
    hidden_fields: [sales_orders_v2.sales_organization_vkorg]

    listen:
      date: sales_orders_v2.creation_date_erdat_date
      country: countries_md.country_name_landx
      sales_org: sales_organizations_md.sales_org_name_vtext
      distribution_channel: distribution_channels_md.distribution_channel_name_vtext
      product: materials_md.material_text_maktx
      division: divisions_md.division_name_vtext
      sold_to: customers_md.customer_name
      target_currency: otc_common_parameters_xvw.parameter_target_currency
    row: 20
    col: 0
    width: 10
    height: 10

  - name: Top Customers by Avg Sales
    title: Top Customers by Avg Sales
    explore: sales_orders_v2
    type: looker_bar
    fields: [sales_orders_v2.sold_to_party_kunnr, customers_md.customer_name, across_sales_and_currency_conversion_xvw.avg_net_value_per_order_target]
    sorts: [across_sales_and_currency_conversion_xvw.avg_net_value_per_order_target desc]
    # filters:
    #   sales_orders_v2.count_orders: ">=10"
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
      {across_sales_and_currency_conversion_xvw.avg_net_value_per_order_target: "#53575E"}

    y_axes: [{label: '', orientation: bottom, series: [{axisId: across_sales_and_currency_conversion_xvw.total_net_value_target,
            id: across_sales_and_currency_conversion_xvw.avg_net_value_per_order_target
            # , name: Avg Sales per Order (Target Currency 'USD')
    }], showLabels: true, showValues: false,
        unpinAxis: false, tickDensity: default, tickDensityCustom: 5, type: linear}]
    x_axis_zoom: true
    y_axis_zoom: true
    hidden_fields: [sales_orders_v2.sold_to_party_kunnr]

    listen:
      date: sales_orders_v2.creation_date_erdat_date
      country: countries_md.country_name_landx
      sales_org: sales_organizations_md.sales_org_name_vtext
      distribution_channel: distribution_channels_md.distribution_channel_name_vtext
      product: materials_md.material_text_maktx
      division: divisions_md.division_name_vtext
      sold_to: customers_md.customer_name
      target_currency: otc_common_parameters_xvw.parameter_target_currency
    # note_state: expanded
    note_display: hover
    note_text: |-
      <font size="-2">Average Sales per Order (Target Currency).<br>Limited to 10 Sold to customers. To change this row limit, select "Explore from Here" option and adjust the row limit.
      </font>
    row: 20
    col: 11
    width: 10
    height: 10

  - name: Sales by Distribution Channel
    title: Sales by Distribution Channel
    explore: sales_orders_v2
    type: looker_pie
    fields: [across_sales_and_currency_conversion_xvw.total_net_value_target, sales_orders_v2.distribution_channel_vtweg,
      distribution_channels_md.distribution_channel_name_vtext]
    sorts: [across_sales_and_currency_conversion_xvw.total_net_value_target desc 0]
    limit: 50
    column_limit: 50
    value_labels: labels
    label_type: labVal
    inner_radius: 50
    color_application:
      collection_id: 9d1da669-a6b4-4a4f-8519-3ea8723b79b5
      palette_id: 0c5264fb-0681-4817-b9a5-d3c81002ce4c
      options:
        steps: 5
        reverse: true
    series_colors: {}
    advanced_vis_config: |-
      {
        plotOptions: {
          pie: {
            dataLabels: {
              style: {
                fontSize: '100%'
               },
              enabled: true,
              format: '<b>{key}</b><span style="font-size: 80%; font-weight: normal"> <br>{percentage:.1f}%<br>{point.rendered}</span>',
            }
          }
        },
        title: {
          text: 'Distribution<br>Channel',
          verticalAlign: 'middle',
          align: 'center',
          y: 10,
          x: -5,
          style: {
                fontSize: '120%',
                fontWeight: 'bold',
               },
        }
      }
    # x_axis_gridlines: false
    # y_axis_gridlines: true
    # show_view_names: false
    # show_y_axis_labels: false
    # show_y_axis_ticks: true
    # y_axis_tick_density: default
    # y_axis_tick_density_custom: 5
    # show_x_axis_label: false
    # show_x_axis_ticks: true
    # y_axis_scale_mode: linear
    # x_axis_reversed: false
    # y_axis_reversed: false
    # plot_size_by_field: false
    # trellis: ''
    # stacking: normal
    # limit_displayed_rows: false
    # legend_position: center
    # point_style: none
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    # y_axes: [{label: '', orientation: bottom, series: [{axisId: across_sales_and_currency_conversion_xvw.total_net_value_target,
    #         id: across_sales_and_currency_conversion_xvw.total_net_value_target, __FILE: block-revamp-sap-dev/dashboards/otc_03_sales_performance.dashboard.lookml,
    #         __LINE_NUM: 197}], showLabels: true, showValues: false, unpinAxis: false,
    #     tickDensity: default, tickDensityCustom: 5, type: linear, __FILE: block-revamp-sap-dev/dashboards/otc_03_sales_performance.dashboard.lookml,
    #     __LINE_NUM: 197}]
    x_axis_zoom: true
    y_axis_zoom: true
    hidden_fields: [sales_orders_v2.distribution_channel_vtweg]
    defaults_version: 1
    hidden_pivots: {}
    title_hidden: true

    # type: looker_bar
    # fields: [across_sales_and_currency_conversion_xvw.total_net_value_target, sales_orders_v2.distribution_channel_vtweg,
    #   distribution_channels_md.distribution_channel_name_vtext, across_sales_and_currency_conversion_xvw.percent_of_total_net_value_target]
    # sorts: [across_sales_and_currency_conversion_xvw.total_net_value_target desc 0]
    # x_axis_gridlines: false
    # y_axis_gridlines: true
    # show_view_names: false
    # show_y_axis_labels: false
    # show_y_axis_ticks: true
    # y_axis_tick_density: default
    # y_axis_tick_density_custom: 5
    # show_x_axis_label: false
    # show_x_axis_ticks: true
    # y_axis_scale_mode: linear
    # x_axis_reversed: false
    # y_axis_reversed: false
    # plot_size_by_field: false
    # trellis: ''
    # stacking: normal
    # limit_displayed_rows: false
    # legend_position: center
    # point_style: none
    # show_value_labels: true
    # label_density: 25
    # x_axis_scale: auto
    # y_axis_combined: true
    # ordering: none
    # show_null_labels: false
    # show_totals_labels: false
    # show_silhouette: false
    # totals_color: "#808080"
    # y_axes: [{label: '', orientation: bottom, series: [{axisId: across_sales_and_currency_conversion_xvw.total_net_value_target,
    #         id: across_sales_and_currency_conversion_xvw.total_net_value_target}], showLabels: true, showValues: false, unpinAxis: false,
    #     tickDensity: default, tickDensityCustom: 5, type: linear}]
    # x_axis_zoom: true
    # y_axis_zoom: true
    # series_colors:
    #   across_sales_and_currency_conversion_xvw.total_net_value_target: "#74A09F"
    #   across_sales_and_currency_conversion_xvw.percent_of_total_net_value_target: transparent
    # advanced_vis_config: "{\n  series: [{\n  \n      dataLabels: {\n        enabled:\
    #   \ true,\n        align: 'right',\n        verticalAlign: 'top',\n        style:\
    #   \ {\n          fontSize: '12px',\n          fontWeight: 'bold',\n          textOutline:\
    #   \ 'none',\n        },\n      },\n\n    },\n    {\n\n      dataLabels: {\n    \
    #   \    enabled: true,\n        inside: true,\n        overlap: true,\n        align:\
    #   \ 'right',\n        verticalAlign: 'bottom',\n\n        style: {\n          fontSize:\
    #   \ '12px',\n          fontWeight: 'bold',\n          textOutline: 'none',\n   \
    #   \     },\n      },\n\n      showInLegend: false,\n\n    },\n  ],\n  xAxis: {\n\
    #   \    labels: {\n      enabled: true,\n      data: [],\n      events: {},\n   \
    #   \   autoRotationLimit: 150,\n      style: {\n        cursor: 'pointer',\n    \
    #   \    fontSize: '12px',\n        textAlign: 'right',\n        color: 'inherit',\n\
    #   \        textOverflow: 'ellipsis',\n      },\n  \
    #   \    useHTML: true,\n    },\n  },\n}"
    # hidden_fields: [sales_orders_v2.distribution_channel_vtweg]

    listen:
      date: sales_orders_v2.creation_date_erdat_date
      country: countries_md.country_name_landx
      sales_org: sales_organizations_md.sales_org_name_vtext
      distribution_channel: distribution_channels_md.distribution_channel_name_vtext
      product: materials_md.material_text_maktx
      division: divisions_md.division_name_vtext
      sold_to: customers_md.customer_name
      target_currency: otc_common_parameters_xvw.parameter_target_currency
    row: 12
    col: 0
    width: 10
    height: 7

  - name: Sales by Division
    title: Sales by Division
    explore: sales_orders_v2
    type: looker_bar
    fields: [across_sales_and_currency_conversion_xvw.total_net_value_target, sales_orders_v2.division_hdr_spart, divisions_md.division_name_vtext, across_sales_and_currency_conversion_xvw.percent_of_total_net_value_target]
    sorts: [across_sales_and_currency_conversion_xvw.total_net_value_target desc 0]
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: false
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: normal
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
    y_axes: [{label: '', orientation: bottom, series: [{axisId: across_sales_and_currency_conversion_xvw.total_net_value_target,
                id: across_sales_and_currency_conversion_xvw.total_net_value_target }], showLabels: true, showValues: false, unpinAxis: false,
        tickDensity: default, tickDensityCustom: 5, type: linear}]
    x_axis_zoom: true
    y_axis_zoom: true
    series_colors:
      across_sales_and_currency_conversion_xvw.total_net_value_target: "#74A09F"
      across_sales_and_currency_conversion_xvw.percent_of_total_net_value_target: transparent
    advanced_vis_config: "{\n  series: [{\n  \n      dataLabels: {\n        enabled:\
      \ true,\n        align: 'right',\n        verticalAlign: 'top',\n        style:\
      \ {\n          fontSize: '12px',\n          fontWeight: 'bold',\n          textOutline:\
      \ 'none',\n        },\n      },\n\n    },\n    {\n\n      dataLabels: {\n    \
      \    enabled: true,\n        inside: true,\n        overlap: true,\n        align:\
      \ 'right',\n        verticalAlign: 'bottom',\n\n        style: {\n          fontSize:\
      \ '12px',\n          fontWeight: 'bold',\n          textOutline: 'none',\n   \
      \     },\n      },\n\n      showInLegend: false,\n\n    },\n  ],\n  xAxis: {\n\
      \    labels: {\n      enabled: true,\n      data: [],\n      events: {},\n   \
      \   autoRotationLimit: 150,\n      style: {\n        cursor: 'pointer',\n    \
      \    fontSize: '12px',\n        textAlign: 'right',\n        color: 'inherit',\n\
      \        textOverflow: 'ellipsis',\n      },\n  \
      \    useHTML: true,\n    },\n  },\n}"
    hidden_fields: [sales_orders_v2.division_hdr_spart]

    listen:
      date: sales_orders_v2.creation_date_erdat_date
      country: countries_md.country_name_landx
      sales_org: sales_organizations_md.sales_org_name_vtext
      distribution_channel: distribution_channels_md.distribution_channel_name_vtext
      product: materials_md.material_text_maktx
      division: divisions_md.division_name_vtext
      sold_to: customers_md.customer_name
      target_currency: otc_common_parameters_xvw.parameter_target_currency
    row: 12
    col: 11
    width: 10
    height: 7
