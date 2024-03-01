view: clustering_model {
  derived_table: {
    datagroup_trigger: ecomm_monthly
    sql_create:
      ------ Start of Clustering Model ------
      CREATE OR REPLACE MODEL ${SQL_TABLE_NAME}
        OPTIONS(
                model_type='kmeans',
                --- Adjust number of clusters here ---
                num_clusters=5
              ) AS
      --- Derived Table for Audience Here; This is the training data for the model  ---
      SELECT
          concat((CONCAT(UPPER(SUBSTR(users.first_name,1,1)), LOWER(SUBSTR(users.first_name,2)))), ' ', (CONCAT(UPPER(SUBSTR(users.last_name,1,1)), LOWER(SUBSTR(users.last_name,2)))))  AS users_name,
          (ROUND(COALESCE(CAST( ( SUM(DISTINCT (CAST(ROUND(COALESCE( users.age  ,0)*(1/1000*1.0), 9) AS NUMERIC) + (cast(cast(concat('0x', substr(to_hex(md5(CAST( users.id   AS STRING))), 1, 15)) as int64) as numeric) * 4294967296 + cast(cast(concat('0x', substr(to_hex(md5(CAST( users.id   AS STRING))), 16, 8)) as int64) as numeric)) * 0.000000001 )) - SUM(DISTINCT (cast(cast(concat('0x', substr(to_hex(md5(CAST( users.id   AS STRING))), 1, 15)) as int64) as numeric) * 4294967296 + cast(cast(concat('0x', substr(to_hex(md5(CAST( users.id   AS STRING))), 16, 8)) as int64) as numeric)) * 0.000000001) )  / (1/1000*1.0) AS NUMERIC), 0), 6) / NULLIF(CAST(COUNT(DISTINCT CASE WHEN   users.age   IS NOT NULL THEN  users.id   ELSE NULL END) AS FLOAT64), 0.0)) AS users_average_age,
          COALESCE(SUM(( order_items.sale_price - inventory_items.cost ) ), 0) AS order_items_total_gross_margin,
          1.0 * ( COUNT(DISTINCT CASE WHEN ( order_items.returned_at IS NOT NULL  ) THEN order_items.id  ELSE NULL END) ) / nullif(( COUNT(*) ),0)  AS order_items_return_rate,
          1.0 * ( COALESCE(SUM(order_items.sale_price ), 0) ) / nullif(( COUNT(DISTINCT users.id ) ),0)  AS order_items_average_spend_per_user,
          COUNT(DISTINCT ( TRIM(products.brand)  ) ) AS products_brand_count,
          COUNT(DISTINCT ( TRIM(products.category)  ) ) AS products_category_count,
          COUNT(*) AS order_items_count
      FROM `looker-private-demo.ecomm.order_items`  AS order_items
      FULL OUTER JOIN `looker-private-demo.ecomm.inventory_items`  AS inventory_items ON inventory_items.id = order_items.inventory_item_id
      LEFT JOIN `looker-private-demo.ecomm.users`  AS users ON order_items.user_id = users.id
      LEFT JOIN `looker-private-demo.ecomm.products`  AS products ON products.id = inventory_items.product_id
      WHERE (order_items.created_at ) < ((TIMESTAMP(DATETIME_ADD(DATETIME(TIMESTAMP_TRUNC(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY, 'UTC'), MONTH)), INTERVAL -2 MONTH))))
      GROUP BY
          1
      ORDER BY
          2 DESC

      ------ END ------
      ;;
  }
}

view: audience_clustering {
  derived_table: {
    datagroup_trigger: ecomm_daily
    increment_key: "created_date"
    increment_offset: 3
    distribution_style: all
    sql: SELECT
        * EXCEPT(nearest_centroids_distance)
      FROM
        ML.PREDICT(MODEL ${clustering_model.SQL_TABLE_NAME},
        (
        --- Derived Table for Audience Here; This is the training data for the model  ---
        SELECT
          concat((CONCAT(UPPER(SUBSTR(users.first_name,1,1)), LOWER(SUBSTR(users.first_name,2)))), ' ', (CONCAT(UPPER(SUBSTR(users.last_name,1,1)), LOWER(SUBSTR(users.last_name,2)))))  AS users_name,
          (ROUND(COALESCE(CAST( ( SUM(DISTINCT (CAST(ROUND(COALESCE( users.age  ,0)*(1/1000*1.0), 9) AS NUMERIC) + (cast(cast(concat('0x', substr(to_hex(md5(CAST( users.id   AS STRING))), 1, 15)) as int64) as numeric) * 4294967296 + cast(cast(concat('0x', substr(to_hex(md5(CAST( users.id   AS STRING))), 16, 8)) as int64) as numeric)) * 0.000000001 )) - SUM(DISTINCT (cast(cast(concat('0x', substr(to_hex(md5(CAST( users.id   AS STRING))), 1, 15)) as int64) as numeric) * 4294967296 + cast(cast(concat('0x', substr(to_hex(md5(CAST( users.id   AS STRING))), 16, 8)) as int64) as numeric)) * 0.000000001) )  / (1/1000*1.0) AS NUMERIC), 0), 6) / NULLIF(CAST(COUNT(DISTINCT CASE WHEN   users.age   IS NOT NULL THEN  users.id   ELSE NULL END) AS FLOAT64), 0.0)) AS users_average_age,
          COALESCE(SUM(( order_items.sale_price - inventory_items.cost ) ), 0) AS order_items_total_gross_margin,
          1.0 * ( COUNT(DISTINCT CASE WHEN ( order_items.returned_at IS NOT NULL  ) THEN order_items.id  ELSE NULL END) ) / nullif(( COUNT(*) ),0)  AS order_items_return_rate,
          1.0 * ( COALESCE(SUM(order_items.sale_price ), 0) ) / nullif(( COUNT(DISTINCT users.id ) ),0)  AS order_items_average_spend_per_user,
          COUNT(DISTINCT ( TRIM(products.brand)  ) ) AS products_brand_count,
          COUNT(DISTINCT ( TRIM(products.category)  ) ) AS products_category_count,
          COUNT(*) AS order_items_count
        FROM `looker-private-demo.ecomm.order_items`  AS order_items
        FULL OUTER JOIN `looker-private-demo.ecomm.inventory_items`  AS inventory_items ON inventory_items.id = order_items.inventory_item_id
        LEFT JOIN `looker-private-demo.ecomm.users`  AS users ON order_items.user_id = users.id
        LEFT JOIN `looker-private-demo.ecomm.products`  AS products ON products.id = inventory_items.product_id
        WHERE {% incrementcondition %} order_items.created_time {%  endincrementcondition %}
        GROUP BY
            1
        ORDER BY
            2 DESC

        ------ END ------
        ))
       ;;
  }

  dimension: centroid_id {
    type: number
    sql: ${TABLE}.CENTROID_ID;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: users_name {
    type: string
    sql: ${TABLE}.users_name ;;
  }

  measure: users_average_age {
    type: number
    sql: AVG(${TABLE}.users_average_age) ;;
    value_format_name: decimal_0
  }

  measure: order_items_total_gross_margin {
    type: number
    sql: SUM(${TABLE}.order_items_total_gross_margin) ;;
    value_format_name: usd
  }

  measure: order_items_return_rate {
    type: number
    sql: AVG(${TABLE}.order_items_return_rate) ;;
    value_format_name: percent_2
  }

  measure: order_items_average_spend_per_user {
    type: number
    sql: AVG(${TABLE}.order_items_average_spend_per_user) ;;
    value_format_name: usd
  }

  measure: products_brand_count {
    type: number
    sql: AVG(${TABLE}.products_brand_count) ;;
    value_format_name: decimal_0
  }

  measure: products_category_count {
    type: number
    sql: AVG(${TABLE}.products_category_count) ;;
    value_format_name: decimal_0
  }

  measure: order_items_count {
    type: number
    sql: SUM(${TABLE}.order_items_count) ;;
    value_format_name: decimal_0
  }

  set: detail {
    fields: [
      users_name,
      users_average_age,
      order_items_total_gross_margin,
      order_items_return_rate,
      order_items_average_spend_per_user,
      products_brand_count,
      products_category_count,
      order_items_count
    ]
  }
}
