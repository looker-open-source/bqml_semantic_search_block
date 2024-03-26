# The name of this view in Looker is "Order Items"
view: order_items {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `bigquery-public-data.thelook_ecommerce.order_items` ;;
  drill_fields: [id]

  # This primary key is the unique key for this table in the underlying database.
  # You need to define a primary key in a view in order to join to other views.

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }
  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: created {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.created_at ;;
  }

  dimension_group: delivered {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.delivered_at ;;
  }
    # Here's what a typical dimension looks like in LookML.
    # A dimension is a groupable field that can be used to filter query results.
    # This dimension will be called "Inventory Item ID" in Explore.

  dimension: inventory_item_id {
    type: number
    sql: ${TABLE}.inventory_item_id ;;
  }

  dimension: order_id {
    type: number
    sql: ${TABLE}.order_id ;;
  }

  dimension: product_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.product_id ;;
  }

  dimension: matched_product {
    type: yesno
    sql: ${product_id} IN (
      SELECT matched_product_id
      FROM ${product_semantic_search.SQL_TABLE_NAME}
    );;
  }

  # dimension: matched_user {
  #   type: yesno
  #   sql: ${user_id} IN (
  #     SELECT DISTINCT ${user_id}
  #     FROM ${product_semantic_search.SQL_TABLE_NAME} as product
  #     LEFT OUTER JOIN ${order_items.SQL_TABLE_NAME} as orders
  #       ON product.matched_product_id = orders.product_id
  #   )
  #   ;;
  # }
  dimension: matched_user {
    type: yesno
    sql:
    EXISTS (
        SELECT 1
        FROM ${product_semantic_search.SQL_TABLE_NAME} as product
        LEFT OUTER JOIN ${order_items.SQL_TABLE_NAME} as orders
        ON product.matched_product_id = orders.product_id
        WHERE orders.user_id = ${user_id}
    )
    ;;
  }

  dimension_group: returned {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.returned_at ;;
  }

  dimension: sale_price {
    type: number
    sql: ${TABLE}.sale_price ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_sale_price {
    type: sum
    value_format_name: usd
    sql: ${sale_price} ;;  }

  measure: matched_total_sale_price {
    type: sum
    value_format_name: usd
    filters: [matched_user: "yes"]
    sql: ${sale_price} ;;  }

  measure: average_sale_price {
    type: average
    sql: ${sale_price} ;;  }

  dimension_group: shipped {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.shipped_at ;;
  }

  dimension: user_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.user_id ;;
  }
  measure: count {
    type: count
    drill_fields: [detail*]
  }

  measure: matched_count {
    type: count_distinct
    filters: [matched_product: "yes"]
    sql: ${TABLE}.id ;;
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
  id,
  users.last_name,
  users.id,
  users.first_name,
  products.name,
  products.id
  ]
  }

}
