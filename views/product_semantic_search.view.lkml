view: product_embeddings_model {
  derived_table: {
    datagroup_trigger: ecomm_monthly
    sql_create:
      CREATE OR REPLACE MODEL ${SQL_TABLE_NAME}
      REMOTE WITH CONNECTION `@{BQML_REMOTE_CONNECTION_ID}`
      OPTIONS (ENDPOINT = 'textembedding-gecko@002');
    ;;
  }
}

view: product_embeddings {
  derived_table: {
    datagroup_trigger: ecomm_daily
    publish_as_db_view: yes
    sql_create:
    -- This SQL statement creates embeddings for all the rows in the given table (in this case the products lookml view) --
    CREATE OR REPLACE TABLE ${SQL_TABLE_NAME} AS
    SELECT ml_generate_embedding_result as text_embedding
      , * FROM ML.GENERATE_EMBEDDING(
      MODEL ${product_embeddings_model.SQL_TABLE_NAME},
      (
        SELECT *, name as content
        FROM ${products.SQL_TABLE_NAME}
      )
    )
    WHERE LENGTH(ml_generate_embedding_status) = 0; ;;
  }
}

view: product_embeddings_index {
  derived_table: {
    datagroup_trigger: ecomm_monthly
    sql_create:
    -- This SQL statement indexes the embeddings for fast lookup. We specify COSINE similarity here --
      CREATE OR REPLACE VECTOR INDEX ${SQL_TABLE_NAME}
      ON ${product_embeddings.SQL_TABLE_NAME}(text_embedding)
      OPTIONS(index_type = 'IVF',
        distance_type = 'COSINE',
        ivf_options = '{"num_lists":500}') ;;
  }
}

view: product_semantic_search {
  derived_table: {
    sql:
    -- This SQL statement performs the vector search --
    -- Step 1. Generate Embedding from natural language question --
    -- Step 2. Specify the text_embedding column from the embeddings table that was generated for each product in this example --
    -- Step 3. Use BQML's native Vector Search functionality to match the nearest embeddings --
    -- Step 4. Return the matche products --
    SELECT query.query
    ,base.name as matched_product
    ,base.id as matched_product_id
    ,base.sku as matched_product_sku
    ,base.category as matched_product_category
    ,base.brand as matched_product_brand
    FROM VECTOR_SEARCH(
      TABLE ${product_embeddings.SQL_TABLE_NAME}, 'text_embedding',
      (
        SELECT ml_generate_embedding_result, content AS query
        FROM ML.GENERATE_EMBEDDING(
          MODEL ${product_embeddings_model.SQL_TABLE_NAME},
          (SELECT {% parameter product_description %} AS content)
        )
      ),
      top_k => {% parameter product_matches %}
      ,options => '{"fraction_lists_to_search": 0.5}'
    ) ;;
  }

  parameter: product_description {
    type: string
  }

  parameter: product_matches {
    type: number
  }

  dimension: product_description_chosen {
    type: string
    sql: {% parameter product_description %} ;;
  }

  dimension: product_matches_chosen {
    type: string
    sql: {% parameter product_matches %} ;;
  }


  dimension: matched_product {
    type: string
    sql: ${TABLE}.matched_product ;;
  }

  dimension: matched_product_id {
    type: string
    sql: ${TABLE}.matched_product_id ;;
  }

  dimension: matched_product_sku {
    type: string
    sql: ${TABLE}.matched_product_sku ;;
  }

  dimension: matched_product_category {
    type: string
    sql: ${TABLE}.matched_product_category ;;
  }

  dimension: matched_product_brand {
    type: string
    sql: ${TABLE}.matched_product_brand ;;
  }

  measure: explore_brands_button {
    type: count_distinct
    sql: ${matched_product_brand} ;;
    drill_fields: [matched_product_brand]
    html: <html>
      <head>
      <a href="{{link}}&fields=product_semantic_search.matched_product_brand,order_items.total_sale_price&f[product_semantic_search.product_description]={% parameter product_description %}&f[product_semantic_search.product_matches]={% parameter product_matches %}&f[order_items.matched_product]=Yes&sorts=order_items.total_sale_price+desc+0&limit={% parameter product_matches %}&column_limit=50&vis=%7B%22show_view_names%22%3Afalse%2C%22show_row_numbers%22%3Atrue%2C%22transpose%22%3Afalse%2C%22truncate_text%22%3Atrue%2C%22hide_totals%22%3Afalse%2C%22hide_row_totals%22%3Afalse%2C%22size_to_fit%22%3Atrue%2C%22table_theme%22%3A%22gray%22%2C%22limit_displayed_rows%22%3Afalse%2C%22enable_conditional_formatting%22%3Afalse%2C%22header_text_alignment%22%3A%22left%22%2C%22header_font_size%22%3A%2212%22%2C%22rows_font_size%22%3A%2212%22%2C%22conditional_formatting_include_totals%22%3Afalse%2C%22conditional_formatting_include_nulls%22%3Afalse%2C%22color_application%22%3A%7B%22collection_id%22%3A%22google-theme%22%2C%22palette_id%22%3A%22google-theme-categorical-0%22%7D%2C%22show_sql_query_menu_options%22%3Afalse%2C%22show_totals%22%3Atrue%2C%22show_row_totals%22%3Atrue%2C%22truncate_header%22%3Afalse%2C%22minimum_column_width%22%3A75%2C%22series_cell_visualizations%22%3A%7B%22order_items.total_sale_price%22%3A%7B%22is_active%22%3Atrue%2C%22palette%22%3A%7B%22palette_id%22%3A%22google-theme-sequential-0%22%2C%22collection_id%22%3A%22google-theme%22%7D%7D%7D%2C%22custom_color_enabled%22%3Atrue%2C%22show_single_value_title%22%3Atrue%2C%22show_comparison%22%3Afalse%2C%22comparison_type%22%3A%22value%22%2C%22comparison_reverse_colors%22%3Afalse%2C%22show_comparison_label%22%3Atrue%2C%22custom_color%22%3A%22%231A73E8%22%2C%22series_types%22%3A%7B%7D%2C%22type%22%3A%22looker_grid%22%2C%22defaults_version%22%3A1%2C%22hidden_pivots%22%3A%7B%7D%7D&filter_config=%7B%22product_semantic_search.product_description%22%3A%5B%7B%22type%22%3A%22%3D%22%2C%22values%22%3A%5B%7B%22constant%22%3A%2290s+punk+rock%22%7D%2C%7B%7D%5D%2C%22id%22%3A20%2C%22error%22%3Afalse%7D%5D%2C%22product_semantic_search.product_matches%22%3A%5B%7B%22type%22%3A%22%3D%22%2C%22values%22%3A%5B%7B%22constant%22%3A%22500%22%7D%2C%7B%7D%5D%2C%22id%22%3A21%2C%22error%22%3Afalse%7D%5D%2C%22order_items.matched_product%22%3A%5B%7B%22type%22%3A%22is%22%2C%22values%22%3A%5B%7B%22constant%22%3A%22Yes%22%7D%2C%7B%7D%5D%2C%22id%22%3A0%2C%22error%22%3Afalse%7D%5D%7D&origin=share-expanded"
      target="_blank">
      <button style="background-color:#fff; border: 2px solid #4285f4 ; font-size: 12px" >Explore {{rendered_value}} Matched Brands</button>
   </a>
  </head>
      </html> ;;
  }

  measure: explore_products_button {
    type: count_distinct
    sql: ${matched_product} ;;
    drill_fields: [matched_product]
    html: <html>
      <head>
      <a href="{{link}}&fields=product_semantic_search.matched_product,order_items.matched_count&f[product_semantic_search.product_description]={% parameter product_description %}&f[product_semantic_search.product_matches]={% parameter product_matches %}&sorts=order_items.matched_count+desc+0&limit={% parameter product_matches %}&column_limit=50&vis=%7B%22show_view_names%22%3Afalse%2C%22show_row_numbers%22%3Atrue%2C%22transpose%22%3Afalse%2C%22truncate_text%22%3Atrue%2C%22hide_totals%22%3Afalse%2C%22hide_row_totals%22%3Afalse%2C%22size_to_fit%22%3Atrue%2C%22table_theme%22%3A%22gray%22%2C%22limit_displayed_rows%22%3Afalse%2C%22enable_conditional_formatting%22%3Afalse%2C%22header_text_alignment%22%3A%22left%22%2C%22header_font_size%22%3A%2212%22%2C%22rows_font_size%22%3A%2212%22%2C%22conditional_formatting_include_totals%22%3Afalse%2C%22conditional_formatting_include_nulls%22%3Afalse%2C%22color_application%22%3A%7B%22collection_id%22%3A%22google-theme%22%2C%22palette_id%22%3A%22google-theme-categorical-0%22%7D%2C%22show_sql_query_menu_options%22%3Afalse%2C%22show_totals%22%3Atrue%2C%22show_row_totals%22%3Atrue%2C%22truncate_header%22%3Afalse%2C%22minimum_column_width%22%3A75%2C%22series_cell_visualizations%22%3A%7B%22order_items.matched_count%22%3A%7B%22is_active%22%3Atrue%2C%22palette%22%3A%7B%22palette_id%22%3A%22google-theme-sequential-0%22%2C%22collection_id%22%3A%22google-theme%22%7D%7D%7D%2C%22custom_color_enabled%22%3Atrue%2C%22show_single_value_title%22%3Afalse%2C%22show_comparison%22%3Afalse%2C%22comparison_type%22%3A%22value%22%2C%22comparison_reverse_colors%22%3Afalse%2C%22show_comparison_label%22%3Atrue%2C%22custom_color%22%3A%22%23FFF%22%2C%22series_types%22%3A%7B%7D%2C%22type%22%3A%22looker_grid%22%2C%22defaults_version%22%3A1%2C%22hidden_pivots%22%3A%7B%7D%7D&filter_config=%7B%22product_semantic_search.product_description%22%3A%5B%7B%22type%22%3A%22%3D%22%2C%22values%22%3A%5B%7B%22constant%22%3A%2290s+punk+rock%22%7D%2C%7B%7D%5D%2C%22id%22%3A0%2C%22error%22%3Afalse%7D%5D%2C%22product_semantic_search.product_matches%22%3A%5B%7B%22type%22%3A%22%3D%22%2C%22values%22%3A%5B%7B%22constant%22%3A%22500%22%7D%2C%7B%7D%5D%2C%22id%22%3A1%2C%22error%22%3Afalse%7D%5D%7D&origin=share-expanded"
      target="_blank">
      <button style="background-color:#fff; border: 2px solid #4285f4 ; font-size: 12px" >Explore {{rendered_value}} Matched Products</button>
   </a>
  </head>
      </html> ;;
  }





}
