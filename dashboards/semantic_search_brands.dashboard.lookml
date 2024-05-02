- dashboard: semantic_search_trending_brands_
  title: 'Semantic Search: Trending Brands'
  layout: newspaper
  preferred_viewer: dashboards-next
  crossfilter_enabled: true
  description: ''
  preferred_slug: QToVmF2y06TiZTjbItXfHQ
  elements:
  - title: Trending Brands
    name: Trending Brands
    model: bqml_genai_blocks
    explore: order_items
    type: looker_wordcloud
    fields: [product_semantic_search.matched_product_brand, order_items.matched_count]
    filters:
      product_semantic_search.matched_product: "-NULL"
    sorts: [order_items.matched_count desc 0]
    limit: 10
    column_limit: 50
    color_application:
      collection_id: google-theme
      palette_id: google-theme-categorical-0
      options:
        steps: 5
    rotation: false
    x_axis_gridlines: false
    y_axis_gridlines: false
    show_view_names: false
    show_y_axis_labels: true
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
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    y_axes: [{label: '', orientation: bottom, series: [{axisId: order_items.matched_count,
            id: order_items.matched_count, name: Matched Count}], showLabels: false,
        showValues: false, unpinAxis: false, tickDensity: default, tickDensityCustom: 5,
        type: linear}]
    x_axis_zoom: true
    y_axis_zoom: true
    series_colors: {}
    hidden_pivots: {}
    defaults_version: 1
    title_hidden: true
    listen:
      Target Segment Description: product_semantic_search.product_description
      Product Matches: product_semantic_search.product_matches
    row: 2
    col: 5
    width: 9
    height: 5
  - title: Global Trends
    name: Global Trends
    model: bqml_genai_blocks
    explore: order_items
    type: looker_geo_choropleth
    fields: [order_items.matched_count, users.country]
    filters:
      product_semantic_search.matched_product: "-NULL"
    sorts: [order_items.matched_count desc 0]
    limit: 500
    column_limit: 50
    map: world
    map_projection: ''
    show_view_names: false
    quantize_colors: false
    colors: ["#4285F4", "#EA4335", "#FBBC04", "#34A853"]
    color_application:
      collection_id: google-theme
      palette_id: google-theme-categorical-0
      options:
        steps: 5
    x_axis_gridlines: false
    y_axis_gridlines: false
    y_axes: [{label: '', orientation: bottom, series: [{axisId: order_items.matched_count,
            id: order_items.matched_count, name: Matched Count}], showLabels: false,
        showValues: false, unpinAxis: false, tickDensity: default, tickDensityCustom: 5,
        type: linear}]
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    x_axis_zoom: true
    y_axis_zoom: true
    trellis: ''
    stacking: normal
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    series_colors: {}
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    hidden_pivots: {}
    defaults_version: 1
    hidden_fields: []
    hidden_points_if_no: []
    series_labels: {}
    title_hidden: true
    listen:
      Target Segment Description: product_semantic_search.product_description
      Product Matches: product_semantic_search.product_matches
    row: 2
    col: 14
    width: 9
    height: 5
  - title: Attributed Revenue
    name: Attributed Revenue
    model: bqml_genai_blocks
    explore: order_items
    type: single_value
    fields: [order_items.matched_total_sale_price, sum_of_sale_price]
    filters: {}
    limit: 5
    column_limit: 50
    dynamic_fields:
    - category: measure
      expression: ''
      label: Sum of Sale Price
      value_format: '[>1000000]$0.0,,"M";$0.0,"K"'
      value_format_name: __custom
      based_on: order_items.sale_price
      _kind_hint: measure
      measure: sum_of_sale_price
      type: sum
      _type_hint: number
    custom_color_enabled: true
    show_single_value_title: false
    show_comparison: true
    comparison_type: progress_percentage
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    color_application:
      collection_id: google-theme
      palette_id: google-theme-categorical-0
      options:
        steps: 5
    custom_color: "#1A73E8"
    value_format: '[>1000000]$0.0,,"M";$0.0,"K"'
    comparison_label: last year's revenue
    value_labels: none
    label_type: labPer
    inner_radius: 60
    start_angle: 90
    series_colors:
      'No': "#e8e8e8"
      'Yes': "#1A73E8"
    show_value_labels: true
    font_size: 12
    x_axis_gridlines: false
    y_axis_gridlines: false
    show_view_names: false
    show_y_axis_labels: true
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
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    y_axes: [{label: '', orientation: bottom, series: [{axisId: order_items.matched_count,
            id: order_items.matched_count, name: Matched Count}], showLabels: false,
        showValues: false, unpinAxis: false, tickDensity: default, tickDensityCustom: 5,
        type: linear}]
    x_axis_zoom: true
    y_axis_zoom: true
    hidden_pivots: {}
    defaults_version: 1
    title_hidden: true
    listen:
      Target Segment Description: product_semantic_search.product_description
      Product Matches: product_semantic_search.product_matches
    row: 9
    col: 5
    width: 6
    height: 2
  - title: Audience Segment Size
    name: Audience Segment Size
    model: bqml_genai_blocks
    explore: order_items
    type: single_value
    fields: [users.matched_audience_size, count_of_id]
    filters: {}
    limit: 5
    column_limit: 50
    dynamic_fields:
    - category: measure
      expression: ''
      label: Sum of Sale Price
      value_format: '[>1000000]$0.0,,"M";$0.0,"K"'
      value_format_name: __custom
      based_on: order_items.sale_price
      _kind_hint: measure
      measure: sum_of_sale_price
      type: sum
      _type_hint: number
    - category: measure
      expression: ''
      label: Count of ID
      value_format: '[<1000]0;[>1000000]0.0,,"M";0.0,"K"'
      value_format_name: __custom
      based_on: users.id
      _kind_hint: measure
      measure: count_of_id
      type: count_distinct
      _type_hint: number
    custom_color_enabled: true
    show_single_value_title: false
    show_comparison: true
    comparison_type: progress_percentage
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    color_application:
      collection_id: google-theme
      palette_id: google-theme-categorical-0
      options:
        steps: 5
    custom_color: "#F9AB00"
    value_format: '[<1000]0;[>1000000]0.0,,"M";0.0,"K"'
    comparison_label: last year's customers
    value_labels: none
    label_type: labPer
    inner_radius: 60
    start_angle: 90
    series_colors:
      'No': "#e8e8e8"
      'Yes': "#1A73E8"
    show_value_labels: true
    font_size: 12
    x_axis_gridlines: false
    y_axis_gridlines: false
    show_view_names: false
    show_y_axis_labels: true
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
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    y_axes: [{label: '', orientation: bottom, series: [{axisId: order_items.matched_count,
            id: order_items.matched_count, name: Matched Count}], showLabels: false,
        showValues: false, unpinAxis: false, tickDensity: default, tickDensityCustom: 5,
        type: linear}]
    x_axis_zoom: true
    y_axis_zoom: true
    hidden_pivots: {}
    defaults_version: 1
    title_hidden: true
    listen:
      Target Segment Description: product_semantic_search.product_description
      Product Matches: product_semantic_search.product_matches
    row: 26
    col: 5
    width: 6
    height: 2
  - title: Next 6 Months Revenue
    name: Next 6 Months Revenue
    model: bqml_genai_blocks
    explore: order_items
    type: single_value
    fields: [order_items.matched_total_sale_price, order_items.created_month, filtered_userscount]
    fill_fields: [order_items.created_month]
    filters:
      order_items.created_date: 12 month ago for 12 month
    sorts: [order_items.created_month desc]
    limit: 18
    column_limit: 50
    dynamic_fields:
    - category: measure
      expression: ''
      label: Sum of Sale Price
      value_format: '[>1000000]$0.0,,"M";$0.0,"K"'
      value_format_name: __custom
      based_on: order_items.sale_price
      _kind_hint: measure
      measure: sum_of_sale_price
      type: sum
      _type_hint: number
    - category: measure
      label: Filtered users.count
      based_on: users.count
      _kind_hint: measure
      measure: filtered_userscount
      type: count_distinct
      _type_hint: number
      filters:
        order_items.matched_user: 'Yes'
    - category: table_calculation
      expression: sum(if(row()<=6,${order_items.matched_total_sale_price}/1000,0))
      label: Total Forecast
      value_format: '[<1000];0;[>1000000]$0.0,,"M";$0.0,"K"'
      value_format_name: __custom
      _kind_hint: measure
      table_calculation: total_forecast
      _type_hint: number
    - category: table_calculation
      expression: concat("This product segment is forecasted to earn $",round(${total_forecast},1),"K
        in the next 6 months.")
      label: Forecast
      value_format:
      value_format_name:
      _kind_hint: measure
      table_calculation: forecast
      _type_hint: string
    analysis_config:
      forecasting:
      - confidence_interval: 0.95
        field_name: order_items.matched_total_sale_price
        forecast_n: 6
        forecast_interval: month
        seasonality: 12
      - confidence_interval: 0.95
        field_name: filtered_userscount
        forecast_n: 6
        forecast_interval: month
        seasonality: 12
    custom_color_enabled: true
    show_single_value_title: false
    show_comparison: false
    comparison_type: progress_percentage
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    color_application:
      collection_id: google-theme
      palette_id: google-theme-categorical-0
      options:
        steps: 5
    custom_color: "#000"
    value_format: '[>1000000]$0.0,,"M";$0.0,"K"'
    comparison_label: Revenue
    x_axis_gridlines: false
    y_axis_gridlines: false
    show_view_names: false
    show_y_axis_labels: true
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
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: monotone
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    y_axes: [{label: '', orientation: left, series: [{axisId: order_items.matched_total_sale_price,
            id: order_items.matched_total_sale_price, name: Matched Total Sale Price}],
        showLabels: false, showValues: false, unpinAxis: false, tickDensity: default,
        tickDensityCustom: 5, type: linear}, {label: !!null '', orientation: right,
        series: [{axisId: filtered_userscount, id: filtered_userscount, name: Filtered
              users.count}], showLabels: false, showValues: false, unpinAxis: false,
        tickDensity: default, tickDensityCustom: 5, type: linear}]
    x_axis_zoom: true
    y_axis_zoom: true
    hidden_series: [filtered_userscount]
    font_size: '12'
    series_colors:
      'No': "#e8e8e8"
      'Yes': "#1A73E8"
    value_labels: none
    label_type: labPer
    inner_radius: 60
    start_angle: 90
    ordering: none
    show_null_labels: false
    hidden_pivots: {}
    defaults_version: 1
    hidden_fields: [filtered_userscount, order_items.created_month, order_items.matched_total_sale_price,
      total_forecast]
    title_hidden: true
    listen:
      Target Segment Description: product_semantic_search.product_description
      Product Matches: product_semantic_search.product_matches
    row: 9
    col: 11
    width: 12
    height: 2
  - title: Next 6 Months Audience
    name: Next 6 Months Audience
    model: bqml_genai_blocks
    explore: order_items
    type: single_value
    fields: [order_items.matched_total_sale_price, order_items.created_month, filtered_userscount]
    fill_fields: [order_items.created_month]
    filters:
      order_items.created_date: 12 month ago for 12 month
    sorts: [order_items.created_month desc]
    limit: 18
    column_limit: 50
    dynamic_fields:
    - category: measure
      expression: ''
      label: Sum of Sale Price
      value_format: '[>1000000]$0.0,,"M";$0.0,"K"'
      value_format_name: __custom
      based_on: order_items.sale_price
      _kind_hint: measure
      measure: sum_of_sale_price
      type: sum
      _type_hint: number
    - category: measure
      label: Filtered users.count
      based_on: users.count
      _kind_hint: measure
      measure: filtered_userscount
      type: count_distinct
      _type_hint: number
      filters:
        order_items.matched_user: 'Yes'
    - category: table_calculation
      expression: sum(if(row()<=6,${filtered_userscount},0)/1000)
      label: Total Forecast
      value_format: '[<1000];0;[>1000000]$0.0,,"M";$0.0,"K"'
      value_format_name: __custom
      _kind_hint: measure
      table_calculation: total_forecast
      _type_hint: number
    - category: table_calculation
      expression: concat("The expected audience size is roughly ",round(${total_forecast},1),"K
        customers in the next 6 months.")
      label: Forecast
      value_format:
      value_format_name:
      _kind_hint: measure
      table_calculation: forecast
      _type_hint: string
    analysis_config:
      forecasting:
      - confidence_interval: 0.95
        field_name: order_items.matched_total_sale_price
        forecast_n: 6
        forecast_interval: month
        seasonality: 12
      - confidence_interval: 0.95
        field_name: filtered_userscount
        forecast_n: 6
        forecast_interval: month
        seasonality: 12
    custom_color_enabled: true
    show_single_value_title: false
    show_comparison: false
    comparison_type: progress_percentage
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    color_application:
      collection_id: google-theme
      palette_id: google-theme-categorical-0
      options:
        steps: 5
    custom_color: "#000"
    value_format: '[>1000000]$0.0,,"M";$0.0,"K"'
    comparison_label: Revenue
    x_axis_gridlines: false
    y_axis_gridlines: false
    show_view_names: false
    show_y_axis_labels: true
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
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: monotone
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    y_axes: [{label: '', orientation: left, series: [{axisId: order_items.matched_total_sale_price,
            id: order_items.matched_total_sale_price, name: Matched Total Sale Price}],
        showLabels: false, showValues: false, unpinAxis: false, tickDensity: default,
        tickDensityCustom: 5, type: linear}, {label: !!null '', orientation: right,
        series: [{axisId: filtered_userscount, id: filtered_userscount, name: Filtered
              users.count}], showLabels: false, showValues: false, unpinAxis: false,
        tickDensity: default, tickDensityCustom: 5, type: linear}]
    x_axis_zoom: true
    y_axis_zoom: true
    hidden_series: [filtered_userscount]
    font_size: '12'
    series_colors:
      'No': "#e8e8e8"
      'Yes': "#1A73E8"
    value_labels: none
    label_type: labPer
    inner_radius: 60
    start_angle: 90
    ordering: none
    show_null_labels: false
    hidden_pivots: {}
    defaults_version: 1
    hidden_fields: [filtered_userscount, order_items.created_month, order_items.matched_total_sale_price,
      total_forecast]
    title_hidden: true
    listen:
      Target Segment Description: product_semantic_search.product_description
      Product Matches: product_semantic_search.product_matches
    row: 26
    col: 11
    width: 12
    height: 2
  - title: Summary
    name: Summary
    model: bqml_genai_blocks
    explore: order_items
    type: single_value
    fields: [product_semantic_search.product_description_chosen, product_semantic_search.product_matches_chosen]
    filters: {}
    sorts: [product_semantic_search.product_description_chosen]
    limit: 500
    column_limit: 50
    dynamic_fields:
    - category: table_calculation
      expression: concat("I've identified the top ",${product_semantic_search.product_matches_chosen},"
        matched products for '",${product_semantic_search.product_description_chosen},"'.
        Let's see the top trending brands globaly:")
      label: Summary
      value_format:
      value_format_name:
      _kind_hint: dimension
      table_calculation: summary
      _type_hint: string
    custom_color_enabled: true
    show_single_value_title: false
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    color_application:
      collection_id: google-theme
      palette_id: google-theme-categorical-0
    custom_color: ''
    hidden_pivots: {}
    x_axis_gridlines: false
    y_axis_gridlines: true
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
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
    hidden_fields: [product_semantic_search.product_matches_chosen, product_semantic_search.product_description_chosen]
    listen:
      Target Segment Description: product_semantic_search.product_description
      Product Matches: product_semantic_search.product_matches
    row: 0
    col: 5
    width: 18
    height: 2
  - title: Forecast by Traffic Source
    name: Forecast by Traffic Source
    model: bqml_genai_blocks
    explore: order_items
    type: looker_column
    fields: [order_items.created_month, users.count, users.traffic_source]
    pivots: [users.traffic_source]
    fill_fields: [order_items.created_month]
    filters:
      order_items.created_date: 12 month ago for 12 month
    sorts: [users.traffic_source, order_items.created_month desc]
    limit: 18
    column_limit: 50
    dynamic_fields:
    - category: measure
      expression: ''
      label: Sum of Sale Price
      value_format: '[>1000000]$0.0,,"M";$0.0,"K"'
      value_format_name: __custom
      based_on: order_items.sale_price
      _kind_hint: measure
      measure: sum_of_sale_price
      type: sum
      _type_hint: number
    - category: measure
      label: Filtered users.count
      based_on: users.count
      _kind_hint: measure
      measure: filtered_userscount
      type: count_distinct
      _type_hint: number
      filters:
        order_items.matched_user: 'Yes'
    analysis_config:
      forecasting:
      - confidence_interval: 0.95
        field_name: users.count
        forecast_n: 6
        forecast_interval: month
        seasonality: 12
    x_axis_gridlines: false
    y_axis_gridlines: false
    show_view_names: false
    show_y_axis_labels: true
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
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    color_application:
      collection_id: google-theme
      custom:
        id: 692226f2-d6f0-c5bc-2989-0f2c21b8afbd
        label: Custom
        type: continuous
        stops:
        - color: "#e8e8e8"
          offset: 0
        - color: "#a1e84e"
          offset: 50
        - color: "#7CB342"
          offset: 100
      options:
        steps: 5
        reverse: false
    y_axes: [{label: '', orientation: left, series: [{axisId: order_items.matched_total_sale_price,
            id: order_items.matched_total_sale_price, name: Matched Total Sale Price}],
        showLabels: false, showValues: false, unpinAxis: false, tickDensity: default,
        tickDensityCustom: 5, type: linear}, {label: !!null '', orientation: right,
        series: [{axisId: filtered_userscount, id: filtered_userscount, name: Filtered
              users.count}], showLabels: false, showValues: false, unpinAxis: false,
        tickDensity: default, tickDensityCustom: 5, type: linear}]
    x_axis_zoom: true
    y_axis_zoom: true
    hidden_series: [filtered_userscount]
    font_size: '12'
    series_colors:
      Display - users.count: "#c4c4c4"
    show_null_points: true
    interpolation: monotone
    custom_color_enabled: true
    show_single_value_title: false
    show_comparison: true
    comparison_type: progress_percentage
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    custom_color: "#1A73E8"
    value_format: '[>1000000]$0.0,,"M";$0.0,"K"'
    comparison_label: Revenue
    value_labels: none
    label_type: labPer
    inner_radius: 60
    start_angle: 90
    hidden_pivots: {}
    defaults_version: 1
    hidden_fields: []
    title_hidden: true
    listen:
      Target Segment Description: product_semantic_search.product_description
      Product Matches: product_semantic_search.product_matches
    row: 35
    col: 5
    width: 18
    height: 6
  - title: Traffic Source Summary
    name: Traffic Source Summary
    model: bqml_genai_blocks
    explore: order_items
    type: single_value
    fields: [users.count, users.traffic_source, order_items.average_sale_price]
    filters:
      order_items.created_date: 12 month ago for 12 month
    sorts: [users.count desc]
    limit: 10
    column_limit: 50
    dynamic_fields:
    - category: measure
      expression: ''
      label: Sum of Sale Price
      value_format: '[>1000000]$0.0,,"M";$0.0,"K"'
      value_format_name: __custom
      based_on: order_items.sale_price
      _kind_hint: measure
      measure: sum_of_sale_price
      type: sum
      _type_hint: number
    - category: measure
      label: Filtered users.count
      based_on: users.count
      _kind_hint: measure
      measure: filtered_userscount
      type: count_distinct
      _type_hint: number
      filters:
        order_items.matched_user: 'Yes'
    - category: table_calculation
      expression: "${users.count}/sum(${users.count})"
      label: Percent
      value_format:
      value_format_name: percent_0
      _kind_hint: measure
      table_calculation: percent
      _type_hint: number
    - category: table_calculation
      expression: concat(${users.traffic_source}," will account for roughly ",round(${percent}*100,0),"%
        of the incoming traffic for this audience. ")
      label: Text
      value_format:
      value_format_name:
      _kind_hint: measure
      table_calculation: text
      _type_hint: string
    - category: table_calculation
      expression: mean(${order_items.average_sale_price})
      label: Average Price
      value_format:
      value_format_name: usd_0
      _kind_hint: measure
      table_calculation: average_price
      _type_hint: number
    custom_color_enabled: true
    show_single_value_title: false
    show_comparison: false
    comparison_type: progress_percentage
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    color_application:
      collection_id: google-theme
      custom:
        id: 25dc17c0-c58e-7c75-9781-3eefc340c322
        label: Custom
        type: continuous
        stops:
        - color: "#e8e8e8"
          offset: 0
        - color: "#7CB342"
          offset: 100
      options:
        steps: 5
        reverse: false
    custom_color: "#000"
    value_format: '[>1000000]$0.0,,"M";$0.0,"K"'
    comparison_label: Revenue
    x_axis_gridlines: false
    y_axis_gridlines: false
    show_view_names: false
    show_y_axis_labels: true
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
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    y_axes: [{label: '', orientation: left, series: [{axisId: order_items.matched_total_sale_price,
            id: order_items.matched_total_sale_price, name: Matched Total Sale Price}],
        showLabels: false, showValues: false, unpinAxis: false, tickDensity: default,
        tickDensityCustom: 5, type: linear}, {label: !!null '', orientation: right,
        series: [{axisId: filtered_userscount, id: filtered_userscount, name: Filtered
              users.count}], showLabels: false, showValues: false, unpinAxis: false,
        tickDensity: default, tickDensityCustom: 5, type: linear}]
    x_axis_zoom: true
    y_axis_zoom: true
    hidden_series: [filtered_userscount]
    font_size: '12'
    series_colors: {}
    show_null_points: true
    interpolation: monotone
    value_labels: none
    label_type: labPer
    inner_radius: 60
    start_angle: 90
    hidden_pivots: {}
    defaults_version: 1
    hidden_fields: [users.count, percent, users.traffic_source, order_items.average_sale_price,
      average_price]
    title_hidden: true
    listen:
      Target Segment Description: product_semantic_search.product_description
      Product Matches: product_semantic_search.product_matches
    row: 33
    col: 11
    width: 12
    height: 2
  - title: Audience Age Breakdown (Size vs Revenue)
    name: Audience Age Breakdown (Size vs Revenue)
    model: bqml_genai_blocks
    explore: order_items
    type: looker_area
    fields: [users.age_tier, users.matched_audience_size, order_items.matched_total_sale_price]
    fill_fields: [users.age_tier]
    filters: {}
    sorts: [users.age_tier]
    limit: 500
    column_limit: 50
    dynamic_fields:
    - category: table_calculation
      expression: concat("The strongest age demographic for this segment is ",${users.age_tier},"
        with ",${users.matched_audience_size}," users who have generated $",round(${order_items.matched_total_sale_price}/1000,1),"K
        in revenue.")
      label: Summary
      value_format:
      value_format_name:
      _kind_hint: measure
      table_calculation: summary
      _type_hint: string
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
    show_null_points: true
    interpolation: monotone
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    color_application:
      collection_id: google-theme
      palette_id: google-theme-categorical-0
      options:
        steps: 5
    y_axes: [{label: '', orientation: left, series: [{axisId: users.matched_audience_size,
            id: users.matched_audience_size, name: Matched Audience Size}], showLabels: true,
        showValues: false, maxValue: !!null '', minValue: !!null '', unpinAxis: false,
        tickDensity: default, tickDensityCustom: 5, type: linear}, {label: Total Revenue,
        orientation: right, series: [{axisId: order_items.matched_total_sale_price,
            id: order_items.matched_total_sale_price, name: Matched Total Sale Price}],
        showLabels: true, showValues: false, unpinAxis: false, tickDensity: default,
        type: linear}]
    size_by_field: order_items.matched_total_sale_price
    x_axis_zoom: true
    y_axis_zoom: true
    hide_legend: true
    label_value_format: $0.0,"K"
    series_types:
      order_items.matched_total_sale_price: scatter
    series_colors:
      users.matched_audience_size: "#F9AB00"
      order_items.matched_average_sale_price: "#1A73E8"
      order_items.matched_total_sale_price: "#1A73E8"
    label_color: [transparent, black]
    hidden_pivots: {}
    defaults_version: 1
    ordering: none
    show_null_labels: false
    hidden_fields: [summary]
    title_hidden: true
    listen:
      Target Segment Description: product_semantic_search.product_description
      Product Matches: product_semantic_search.product_matches
    row: 18
    col: 5
    width: 9
    height: 6
  - title: User Summary
    name: User Summary
    model: bqml_genai_blocks
    explore: order_items
    type: single_value
    fields: [users.age_tier, users.matched_audience_size, order_items.matched_total_sale_price]
    fill_fields: [users.age_tier]
    filters: {}
    sorts: [users.age_tier]
    limit: 500
    column_limit: 50
    dynamic_fields:
    - category: table_calculation
      expression: lookup(max(${users.matched_audience_size}),${users.matched_audience_size},concat("The
        strongest age demographic for this segment is ",${users.age_tier}," with ",${users.matched_audience_size},"
        users who have generated $",round(${order_items.matched_total_sale_price}/1000,1),"K
        in revenue."))
      label: Summary
      value_format:
      value_format_name:
      _kind_hint: measure
      table_calculation: summary
      _type_hint: string
    custom_color_enabled: true
    show_single_value_title: false
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    color_application:
      collection_id: google-theme
      palette_id: google-theme-categorical-0
      options:
        steps: 5
    custom_color: ''
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
    show_null_points: true
    interpolation: monotone
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    y_axes: [{label: '', orientation: left, series: [{axisId: users.matched_audience_size,
            id: users.matched_audience_size, name: Matched Audience Size}], showLabels: true,
        showValues: false, maxValue: !!null '', minValue: !!null '', unpinAxis: false,
        tickDensity: default, tickDensityCustom: 5, type: linear}, {label: Total Revenue,
        orientation: right, series: [{axisId: order_items.matched_total_sale_price,
            id: order_items.matched_total_sale_price, name: Matched Total Sale Price}],
        showLabels: true, showValues: false, unpinAxis: false, tickDensity: default,
        type: linear}]
    size_by_field: order_items.matched_total_sale_price
    x_axis_zoom: true
    y_axis_zoom: true
    hide_legend: true
    label_value_format: $0.0,"K"
    series_colors:
      users.matched_audience_size: "#F9AB00"
      order_items.matched_average_sale_price: "#1A73E8"
      order_items.matched_total_sale_price: "#1A73E8"
    label_color: [transparent, black]
    hidden_pivots: {}
    defaults_version: 1
    ordering: none
    show_null_labels: false
    hidden_fields: [users.age_tier, users.matched_audience_size, order_items.matched_total_sale_price]
    title_hidden: true
    listen:
      Target Segment Description: product_semantic_search.product_description
      Product Matches: product_semantic_search.product_matches
    row: 16
    col: 5
    width: 18
    height: 2
  - title: Heatmap
    name: Heatmap
    model: bqml_genai_blocks
    explore: order_items
    type: looker_geo_coordinates
    fields: [users.count, users.zip_code]
    filters:
      users.country: United States
      users.matched_audience_size: ">0"
      order_items.matched_user: 'Yes'
    sorts: [users.count desc]
    limit: 5000
    column_limit: 50
    map: usa
    map_projection: ''
    show_view_names: false
    point_color: "#F9AB00"
    map_color: ''
    point_radius:
    quantize_colors: false
    hidden_fields: []
    hidden_points_if_no: []
    series_labels: {}
    map_plot_mode: heatmap
    heatmap_gridlines: false
    heatmap_gridlines_empty: false
    heatmap_opacity: 0.5
    show_region_field: true
    draw_map_labels_above_data: true
    map_tile_provider: light_no_labels
    map_position: fit_data
    map_zoom: 4
    map_pannable: true
    map_zoomable: false
    map_marker_type: circle
    map_marker_icon_name: default
    map_marker_radius_mode: proportional_value
    map_marker_units: pixels
    map_marker_proportional_scale_type: linear
    map_marker_color_mode: fixed
    show_legend: true
    map_value_colors: ["#e8e8e8", "#F9AB00", "#F9AB00", "#F9AB00", "#F9AB00", "#F9AB00",
      "#F9AB00", "#F9AB00", "#F9AB00", "#F9AB00"]
    quantize_map_value_colors: false
    reverse_map_value_colors: false
    color_application:
      collection_id: google-theme
      palette_id: google-theme-categorical-0
      options:
        steps: 5
    x_axis_gridlines: false
    y_axis_gridlines: true
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
    x_axis_zoom: true
    y_axis_zoom: true
    trellis: ''
    stacking: ''
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
    hidden_pivots: {}
    defaults_version: 1
    show_null_points: true
    interpolation: linear
    title_hidden: true
    listen:
      Target Segment Description: product_semantic_search.product_description
      Product Matches: product_semantic_search.product_matches
    row: 18
    col: 14
    width: 9
    height: 6
  - name: ''
    type: text
    title_text: ''
    subtitle_text: ''
    body_text: '[{"type":"h3","children":[{"text":"Size of Opportunity"}],"align":"right"}]'
    rich_content_json: '{"format":"slate"}'
    row: 9
    col: 0
    width: 5
    height: 6
  - name: " (2)"
    type: text
    title_text: ''
    subtitle_text: ''
    body_text: "<hr>"
    row: 32
    col: 0
    width: 24
    height: 1
  - name: " (3)"
    type: text
    title_text: ''
    subtitle_text: ''
    body_text: "<hr>"
    row: 25
    col: 0
    width: 24
    height: 1
  - name: " (Copy 2)"
    type: text
    title_text: " (Copy 2)"
    subtitle_text: ''
    body_text: '[{"children":[{"text":"Audience Overview"}],"type":"h3","id":"wsfux","align":"right"}]'
    rich_content_json: '{"format":"slate"}'
    row: 26
    col: 0
    width: 5
    height: 6
  - name: " (Copy 4)"
    type: text
    title_text: " (Copy 4)"
    subtitle_text: ''
    body_text: '[{"children":[{"text":"Expected Audience Target"}],"type":"h3","id":"wsfux","align":"right"}]'
    rich_content_json: '{"format":"slate"}'
    row: 16
    col: 0
    width: 5
    height: 8
  - name: " (4)"
    type: text
    title_text: ''
    subtitle_text: ''
    body_text: "<hr>"
    row: 15
    col: 0
    width: 24
    height: 1
  - name: " (5)"
    type: text
    title_text: ''
    subtitle_text: ''
    body_text: "<hr>"
    row: 8
    col: 0
    width: 24
    height: 1
  - name: " (Copy)"
    type: text
    title_text: " (Copy)"
    subtitle_text: ''
    body_text: '[{"type":"h3","children":[{"text":"Product Segment"}],"align":"right"}]'
    rich_content_json: '{"format":"slate"}'
    row: 0
    col: 0
    width: 5
    height: 2
  - name: " (Copy 3)"
    type: text
    title_text: " (Copy 3)"
    subtitle_text: ''
    body_text: '[{"children":[{"text":"                       Inbound Traffic Sourcing"}],"type":"h3","id":"wsfux","align":"right"}]'
    rich_content_json: '{"format":"slate"}'
    row: 33
    col: 0
    width: 5
    height: 8
  - title: ExploreBrands
    name: ExploreBrands
    model: bqml_genai_blocks
    explore: order_items
    type: single_value
    fields: [product_semantic_search.explore_brands_button, product_semantic_search.explore_products_button,
      users.explore_audience_button]
    filters: {}
    limit: 500
    column_limit: 50
    custom_color_enabled: true
    show_single_value_title: false
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    color_application:
      collection_id: google-theme
      palette_id: google-theme-categorical-0
    custom_color: "#FFF"
    defaults_version: 1
    hidden_fields: [product_semantic_search.explore_products_button, users.explore_audience_button]
    listen:
      Target Segment Description: product_semantic_search.product_description
      Product Matches: product_semantic_search.product_matches
    row: 7
    col: 10
    width: 4
    height: 1
  - name: " (Copy 5)"
    type: text
    title_text: " (Copy 5)"
    subtitle_text: ''
    body_text: '[{"type":"p","children":[{"text":" "}],"id":"nxhn4"}]'
    rich_content_json: '{"format":"slate"}'
    row: 2
    col: 0
    width: 5
    height: 6
  - title: ExploreProducts
    name: ExploreProducts
    model: bqml_genai_blocks
    explore: order_items
    type: single_value
    fields: [product_semantic_search.explore_brands_button, product_semantic_search.explore_products_button,
      users.explore_audience_button]
    filters: {}
    limit: 500
    column_limit: 50
    custom_color_enabled: true
    show_single_value_title: false
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    color_application:
      collection_id: google-theme
      palette_id: google-theme-categorical-0
    custom_color: "#FFF"
    defaults_version: 1
    hidden_pivots: {}
    hidden_fields: [product_semantic_search.explore_brands_button, users.explore_audience_button]
    listen:
      Target Segment Description: product_semantic_search.product_description
      Product Matches: product_semantic_search.product_matches
    row: 7
    col: 14
    width: 4
    height: 1
  - title: ExploreUsers
    name: ExploreUsers
    model: bqml_genai_blocks
    explore: order_items
    type: single_value
    fields: [product_semantic_search.explore_brands_button, product_semantic_search.explore_products_button,
      users.explore_audience_button]
    filters: {}
    limit: 500
    column_limit: 50
    custom_color_enabled: true
    show_single_value_title: false
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    color_application:
      collection_id: google-theme
      palette_id: google-theme-categorical-0
    custom_color: "#FFF"
    defaults_version: 1
    hidden_pivots: {}
    hidden_fields: [product_semantic_search.explore_brands_button, product_semantic_search.explore_products_button]
    listen:
      Target Segment Description: product_semantic_search.product_description
      Product Matches: product_semantic_search.product_matches
    row: 24
    col: 12
    width: 4
    height: 1
  - title: Next 6 Months Audience (Copy)
    name: Next 6 Months Audience (Copy)
    model: bqml_genai_blocks
    explore: order_items
    type: looker_area
    fields: [order_items.matched_total_sale_price, order_items.created_month, filtered_userscount]
    fill_fields: [order_items.created_month]
    filters:
      order_items.created_date: 12 month ago for 12 month
    sorts: [order_items.created_month desc]
    limit: 18
    column_limit: 50
    dynamic_fields:
    - category: measure
      expression: ''
      label: Sum of Sale Price
      value_format: '[>1000000]$0.0,,"M";$0.0,"K"'
      value_format_name: __custom
      based_on: order_items.sale_price
      _kind_hint: measure
      measure: sum_of_sale_price
      type: sum
      _type_hint: number
    - category: measure
      label: Filtered users.count
      based_on: users.count
      _kind_hint: measure
      measure: filtered_userscount
      type: count_distinct
      _type_hint: number
      filters:
        order_items.matched_user: 'Yes'
    - category: table_calculation
      expression: sum(if(row()<=6,${filtered_userscount},0)/1000)
      label: Total Forecast
      value_format: '[<1000];0;[>1000000]$0.0,,"M";$0.0,"K"'
      value_format_name: __custom
      _kind_hint: measure
      table_calculation: total_forecast
      _type_hint: number
    - category: table_calculation
      expression: concat("The expected audience size is roughly ",round(${total_forecast},1),"K
        customers in the next 6 months.")
      label: Forecast
      value_format:
      value_format_name:
      _kind_hint: measure
      table_calculation: forecast
      _type_hint: string
    analysis_config:
      forecasting:
      - confidence_interval: 0.95
        field_name: order_items.matched_total_sale_price
        forecast_n: 6
        forecast_interval: month
        seasonality: 12
      - confidence_interval: 0.95
        field_name: filtered_userscount
        forecast_n: 6
        forecast_interval: month
        seasonality: 12
    x_axis_gridlines: false
    y_axis_gridlines: false
    show_view_names: false
    show_y_axis_labels: true
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
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: monotone
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    color_application:
      collection_id: google-theme
      palette_id: google-theme-categorical-0
      options:
        steps: 5
    y_axes: [{label: '', orientation: left, series: [{axisId: order_items.matched_total_sale_price,
            id: order_items.matched_total_sale_price, name: Matched Total Sale Price}],
        showLabels: false, showValues: false, unpinAxis: false, tickDensity: default,
        tickDensityCustom: 5, type: linear}, {label: !!null '', orientation: right,
        series: [{axisId: filtered_userscount, id: filtered_userscount, name: Filtered
              users.count}], showLabels: false, showValues: false, unpinAxis: false,
        tickDensity: default, tickDensityCustom: 5, type: linear}]
    x_axis_zoom: true
    y_axis_zoom: true
    hidden_series: [filtered_userscount]
    font_size: '12'
    series_colors:
      'No': "#e8e8e8"
      'Yes': "#1A73E8"
      filtered_userscount: "#F9AB00"
    custom_color_enabled: true
    show_single_value_title: false
    show_comparison: false
    comparison_type: progress_percentage
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    custom_color: "#000"
    value_format: '[>1000000]$0.0,,"M";$0.0,"K"'
    comparison_label: Revenue
    value_labels: none
    label_type: labPer
    inner_radius: 60
    start_angle: 90
    ordering: none
    show_null_labels: false
    hidden_pivots: {}
    defaults_version: 1
    hidden_fields: [total_forecast, forecast, order_items.matched_total_sale_price]
    title_hidden: true
    listen:
      Target Segment Description: product_semantic_search.product_description
      Product Matches: product_semantic_search.product_matches
    row: 28
    col: 5
    width: 18
    height: 4
  - title: Next 6 Months Revenue (Copy)
    name: Next 6 Months Revenue (Copy)
    model: bqml_genai_blocks
    explore: order_items
    type: looker_area
    fields: [order_items.matched_total_sale_price, order_items.created_month, filtered_userscount]
    fill_fields: [order_items.created_month]
    filters:
      order_items.created_date: 18 month ago for 18 month
    sorts: [order_items.created_month desc]
    limit: 18
    column_limit: 50
    dynamic_fields:
    - category: measure
      expression: ''
      label: Sum of Sale Price
      value_format: '[>1000000]$0.0,,"M";$0.0,"K"'
      value_format_name: __custom
      based_on: order_items.sale_price
      _kind_hint: measure
      measure: sum_of_sale_price
      type: sum
      _type_hint: number
    - category: measure
      label: Filtered users.count
      based_on: users.count
      _kind_hint: measure
      measure: filtered_userscount
      type: count_distinct
      _type_hint: number
      filters:
        order_items.matched_user: 'Yes'
    - category: table_calculation
      expression: sum(if(row()<=6,${order_items.matched_total_sale_price}/1000,0))
      label: Total Forecast
      value_format: '[<1000];0;[>1000000]$0.0,,"M";$0.0,"K"'
      value_format_name: __custom
      _kind_hint: measure
      table_calculation: total_forecast
      _type_hint: number
    - category: table_calculation
      expression: concat("This product segment is forecasted to earn $",round(${total_forecast},1),"K
        in the next 6 months.")
      label: Forecast
      value_format:
      value_format_name:
      _kind_hint: measure
      table_calculation: forecast
      _type_hint: string
    analysis_config:
      forecasting:
      - confidence_interval: 0.95
        field_name: order_items.matched_total_sale_price
        forecast_n: 6
        forecast_interval: month
        seasonality: 12
      - confidence_interval: 0.95
        field_name: filtered_userscount
        forecast_n: 6
        forecast_interval: month
        seasonality: 12
    x_axis_gridlines: false
    y_axis_gridlines: false
    show_view_names: false
    show_y_axis_labels: true
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
    stacking: ''
    limit_displayed_rows: true
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: monotone
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    color_application:
      collection_id: google-theme
      palette_id: google-theme-categorical-0
      options:
        steps: 5
    y_axes: [{label: '', orientation: left, series: [{axisId: order_items.matched_total_sale_price,
            id: order_items.matched_total_sale_price, name: Matched Total Sale Price}],
        showLabels: false, showValues: false, unpinAxis: false, tickDensity: default,
        tickDensityCustom: 5, type: linear}, {label: !!null '', orientation: right,
        series: [{axisId: filtered_userscount, id: filtered_userscount, name: Filtered
              users.count}], showLabels: false, showValues: false, unpinAxis: false,
        tickDensity: default, tickDensityCustom: 5, type: linear}]
    x_axis_zoom: true
    y_axis_zoom: true
    limit_displayed_rows_values:
      show_hide: show
      first_last: first
      num_rows: '18'
    hidden_series: [filtered_userscount]
    font_size: '12'
    series_colors:
      'No': "#e8e8e8"
      'Yes': "#1A73E8"
    custom_color_enabled: true
    show_single_value_title: false
    show_comparison: false
    comparison_type: progress_percentage
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    custom_color: "#000"
    value_format: '[>1000000]$0.0,,"M";$0.0,"K"'
    comparison_label: Revenue
    value_labels: none
    label_type: labPer
    inner_radius: 60
    start_angle: 90
    ordering: none
    show_null_labels: false
    hidden_pivots: {}
    defaults_version: 1
    hidden_fields: [filtered_userscount, total_forecast, forecast]
    title_hidden: true
    listen:
      Target Segment Description: product_semantic_search.product_description
      Product Matches: product_semantic_search.product_matches
    row: 11
    col: 5
    width: 18
    height: 4
  - title: Average Price
    name: Average Price
    model: bqml_genai_blocks
    explore: order_items
    type: single_value
    fields: [users.count, users.traffic_source, order_items.average_sale_price]
    filters:
      order_items.created_date: 12 month ago for 12 month
    sorts: [users.count desc]
    limit: 10
    column_limit: 50
    dynamic_fields:
    - category: measure
      expression: ''
      label: Sum of Sale Price
      value_format: '[>1000000]$0.0,,"M";$0.0,"K"'
      value_format_name: __custom
      based_on: order_items.sale_price
      _kind_hint: measure
      measure: sum_of_sale_price
      type: sum
      _type_hint: number
    - category: measure
      label: Filtered users.count
      based_on: users.count
      _kind_hint: measure
      measure: filtered_userscount
      type: count_distinct
      _type_hint: number
      filters:
        order_items.matched_user: 'Yes'
    - category: table_calculation
      expression: "${users.count}/sum(${users.count})"
      label: Percent
      value_format:
      value_format_name: percent_0
      _kind_hint: measure
      table_calculation: percent
      _type_hint: number
    - category: table_calculation
      expression: concat(${users.traffic_source}," will account for roughly ",round(${percent}*100,0),"%
        of the incoming traffic for this audience. ")
      label: Text
      value_format:
      value_format_name:
      _kind_hint: measure
      table_calculation: text
      _type_hint: string
    - category: table_calculation
      expression: mean(${order_items.average_sale_price})
      label: Average Price
      value_format:
      value_format_name: usd_0
      _kind_hint: measure
      table_calculation: average_price
      _type_hint: number
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: progress_percentage
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    color_application:
      collection_id: google-theme
      custom:
        id: 25dc17c0-c58e-7c75-9781-3eefc340c322
        label: Custom
        type: continuous
        stops:
        - color: "#e8e8e8"
          offset: 0
        - color: "#7CB342"
          offset: 100
      options:
        steps: 5
        reverse: false
    custom_color: "#7CB342"
    single_value_title: average matched item price
    value_format: ''
    comparison_label: Revenue
    x_axis_gridlines: false
    y_axis_gridlines: false
    show_view_names: false
    show_y_axis_labels: true
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
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    y_axes: [{label: '', orientation: left, series: [{axisId: order_items.matched_total_sale_price,
            id: order_items.matched_total_sale_price, name: Matched Total Sale Price}],
        showLabels: false, showValues: false, unpinAxis: false, tickDensity: default,
        tickDensityCustom: 5, type: linear}, {label: !!null '', orientation: right,
        series: [{axisId: filtered_userscount, id: filtered_userscount, name: Filtered
              users.count}], showLabels: false, showValues: false, unpinAxis: false,
        tickDensity: default, tickDensityCustom: 5, type: linear}]
    x_axis_zoom: true
    y_axis_zoom: true
    hidden_series: [filtered_userscount]
    font_size: '12'
    series_colors: {}
    show_null_points: true
    interpolation: monotone
    value_labels: none
    label_type: labPer
    inner_radius: 60
    start_angle: 90
    hidden_pivots: {}
    defaults_version: 1
    hidden_fields: [users.count, percent, users.traffic_source, order_items.average_sale_price,
      text]
    title_hidden: true
    listen:
      Target Segment Description: product_semantic_search.product_description
      Product Matches: product_semantic_search.product_matches
    row: 33
    col: 5
    width: 6
    height: 2
  filters:
  - name: Target Segment Description
    title: Target Segment Description
    type: field_filter
    default_value: 90s punk rock
    allow_multiple_values: true
    required: false
    ui_config:
      type: advanced
      display: popover
      options: []
    model: bqml_genai_blocks
    explore: order_items
    listens_to_filters: []
    field: product_semantic_search.product_description
  - name: Product Matches
    title: Product Matches
    type: field_filter
    default_value: '500'
    allow_multiple_values: true
    required: false
    ui_config:
      type: advanced
      display: popover
      options: []
    model: bqml_genai_blocks
    explore: order_items
    listens_to_filters: []
    field: product_semantic_search.product_matches
