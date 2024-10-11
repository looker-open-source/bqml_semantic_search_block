# The name of this view in Looker is "Users"
view: users {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `bigquery-public-data.thelook_ecommerce.users` ;;
  drill_fields: [id]

  # This primary key is the unique key for this table in the underlying database.
  # You need to define a primary key in a view in order to join to other views.

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }
    # Here's what a typical dimension looks like in LookML.
    # A dimension is a groupable field that can be used to filter query results.
    # This dimension will be called "City" in Explore.

  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
  }

  dimension: age {
    type: string
    sql: ${TABLE}.age ;;
  }

  dimension: age_tier {
    type: tier
    tiers: [18,24,35,45,55,65]
    sql: ${TABLE}.age ;;
    style: integer
  }

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
  }
  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: created {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.created_at ;;
  }

  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
  }

  dimension: first_name {
    type: string
    sql: ${TABLE}.first_name ;;
  }

  dimension: gender {
    type: string
    sql: ${TABLE}.gender ;;
  }

  dimension: last_name {
    type: string
    sql: ${TABLE}.last_name ;;
  }

  dimension: latitude {
    type: number
    sql: ${TABLE}.latitude ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_latitude {
    type: sum
    sql: ${latitude} ;;  }
  measure: average_latitude {
    type: average
    sql: ${latitude} ;;  }

  dimension: longitude {
    type: number
    sql: ${TABLE}.longitude ;;
  }

  dimension: approx_latitude {
    label: "Approx Latitude"
    type: number
    sql: round(${TABLE}.latitude,1) ;;
  }

  dimension: approx_longitude {
    label: "Approx Longitude"
    type: number
    sql:round(${TABLE}.longitude,1) ;;
  }

  dimension: approx_location {
    label: "Approx Location"
    type: location
    sql_latitude: ${approx_latitude} ;;
    sql_longitude: ${approx_longitude} ;;

  }

  dimension: postal_code {
    type: string
    sql: ${TABLE}.postal_code ;;
  }

  dimension: zip_code {
    type: zipcode
    sql: ${postal_code} ;;
    map_layer_name: us_counties_fips
  }

  dimension: state {
    type: string
    sql: ${TABLE}.state ;;
  }

  dimension: street_address {
    type: string
    sql: ${TABLE}.street_address ;;
  }

  dimension: traffic_source {
    type: string
    sql: ${TABLE}.traffic_source ;;
  }
  measure: count {
    type: count
    drill_fields: [id, last_name, first_name, events.count, order_items.count]
  }

  measure: matched_audience_size {
    type: count_distinct
    filters: [order_items.matched_product: "yes"]
    sql: ${id} ;;
  }

  measure: explore_audience_button {
    type: count_distinct
    filters: [order_items.matched_product: "yes"]
    sql: ${id} ;;
    drill_fields: [email]
    html: <html>
      <head>
      <a href="{{link}}&fields=users.id,users.email,users.country,users.city,users.age,order_items.matched_total_sale_price&f[product_semantic_search.product_description]={% parameter product_description %}&f[product_semantic_search.product_matches]={% parameter product_matches %}&f[order_items.matched_user]=Yes&sorts=order_items.matched_total_sale_price+desc+0&limit=5000&column_limit=50&vis=%7B%22show_view_names%22%3Afalse%2C%22show_row_numbers%22%3Atrue%2C%22transpose%22%3Afalse%2C%22truncate_text%22%3Atrue%2C%22hide_totals%22%3Afalse%2C%22hide_row_totals%22%3Afalse%2C%22size_to_fit%22%3Atrue%2C%22table_theme%22%3A%22gray%22%2C%22limit_displayed_rows%22%3Afalse%2C%22enable_conditional_formatting%22%3Afalse%2C%22header_text_alignment%22%3A%22left%22%2C%22header_font_size%22%3A%2212%22%2C%22rows_font_size%22%3A%2212%22%2C%22conditional_formatting_include_totals%22%3Afalse%2C%22conditional_formatting_include_nulls%22%3Afalse%2C%22color_application%22%3A%7B%22collection_id%22%3A%22google-theme%22%2C%22palette_id%22%3A%22google-theme-categorical-0%22%7D%2C%22show_sql_query_menu_options%22%3Afalse%2C%22show_totals%22%3Atrue%2C%22show_row_totals%22%3Atrue%2C%22truncate_header%22%3Afalse%2C%22minimum_column_width%22%3A75%2C%22series_cell_visualizations%22%3A%7B%22order_items.matched_count%22%3A%7B%22is_active%22%3Atrue%2C%22palette%22%3A%7B%22palette_id%22%3A%22google-theme-sequential-0%22%2C%22collection_id%22%3A%22google-theme%22%7D%7D%2C%22order_items.matched_total_sale_price%22%3A%7B%22is_active%22%3Atrue%2C%22palette%22%3A%7B%22palette_id%22%3A%22google-theme-sequential-0%22%2C%22collection_id%22%3A%22google-theme%22%7D%7D%7D%2C%22custom_color_enabled%22%3Atrue%2C%22show_single_value_title%22%3Afalse%2C%22show_comparison%22%3Afalse%2C%22comparison_type%22%3A%22value%22%2C%22comparison_reverse_colors%22%3Afalse%2C%22show_comparison_label%22%3Atrue%2C%22custom_color%22%3A%22%23FFF%22%2C%22series_types%22%3A%7B%7D%2C%22type%22%3A%22looker_grid%22%2C%22defaults_version%22%3A1%2C%22hidden_pivots%22%3A%7B%7D%7D&filter_config=%7B%22product_semantic_search.product_description%22%3A%5B%7B%22type%22%3A%22%3D%22%2C%22values%22%3A%5B%7B%22constant%22%3A%2290s+punk+rock%22%7D%2C%7B%7D%5D%2C%22id%22%3A0%2C%22error%22%3Afalse%7D%5D%2C%22product_semantic_search.product_matches%22%3A%5B%7B%22type%22%3A%22%3D%22%2C%22values%22%3A%5B%7B%22constant%22%3A%22500%22%7D%2C%7B%7D%5D%2C%22id%22%3A1%2C%22error%22%3Afalse%7D%5D%2C%22order_items.matched_user%22%3A%5B%7B%22type%22%3A%22is%22%2C%22values%22%3A%5B%7B%22constant%22%3A%22Yes%22%7D%2C%7B%7D%5D%2C%22id%22%3A2%7D%5D%7D&origin=share-expanded"
      target="_blank">
      <button style="background-color:#fff; border: 2px solid #4285f4 ; font-size: 12px" >Explore {{rendered_value}} Matched Audience</button>
   </a>
  </head>
      </html> ;;
  }


}
