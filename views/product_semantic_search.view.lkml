view: product_embeddings_model {
  derived_table: {
    datagroup_trigger: ecomm_monthly
    sql_create:
      CREATE OR REPLACE MODEL ${SQL_TABLE_NAME}
      REMOTE WITH CONNECTION `@{BQML_REMOTE_CONNECTION_ID}`
      --OPTIONS (ENDPOINT = 'textembedding-gecko@002');
      OPTIONS (ENDPOINT = 'textembedding-gecko@003');
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
    full_suggestions: no
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
    link: {
        label: "Website"
        url: "http://www.google.com/search?q={{ value | encode_uri }}+clothes&btnI"
        icon_url: "http://www.google.com/s2/favicons?domain=www.{{ value | encode_uri }}.com"
      }
      link: {
        label: "Facebook"
        url: "http://www.google.com/search?q=site:facebook.com+{{ value | encode_uri }}+clothes&btnI"
        icon_url: "https://upload.wikimedia.org/wikipedia/commons/c/c2/F_icon.svg"
      }
      link: {
        label: "{{value}} Analytics Dashboard"
        url: "/dashboards/IOlEDOPQ12RFCyuUqk38wB?Brand%20Name={{ value | encode_uri }}"
        icon_url: "https://www.seekpng.com/png/full/138-1386046_google-analytics-integration-analytics-icon-blue-png.png"
      }

      action: {
        label: "Email Buying Department"
        url: "https://desolate-refuge-53336.herokuapp.com/posts"
        icon_url: "https://sendgrid.com/favicon.ico"
        param: {
          name: "some_auth_code"
          value: "abc123456"
        }
        form_param: {
          name: "Subject"
          required: yes
          default: "Order Status for {{ value }}"
        }
        form_param: {
          name: "Body"
          type: textarea
          required: yes
          default:
          "Dear Valued Customer,

          We appreciate your continue support and loyalty and wanted to show our appreciation. Offering a 15% discount on ALL products for our favorite brand {{ value }}.
          Just used code {{ value | upcase }}-MANIA on your next checkout!

          Your friends at the Look"
        }
      }
      action: {
        label: "Start Order Form"
        url: "https://desolate-refuge-53336.herokuapp.com/posts"
        icon_url: "https://www.google.com/s2/favicons?domain=www.adwords.google.com"
        param: {
          name: "some_auth_code"
          value: "abc123456"
        }
        form_param: {
          type: select
          name: "Campaign Type"
          option: { name: "Spend" label: "Spend" }
          option: { name: "Leads" label: "Leads" }
          option: { name: "Website Traffic" label: "Website Traffic" }
          required: yes
        }
        form_param: {
          name: "Campaign Name"
          type: string
          required: yes
          default: "{{ value }} Campaign"
        }

        form_param: {
          name: "Product Category"
          type: string
          required: yes
          default: "{{ value }}"
        }

        form_param: {
          name: "Budget"
          type: string
          required: yes
        }

        form_param: {
          name: "Keywords"
          type: string
          required: yes
          default: "{{ value }}"
        }
      }
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
    ### @cathuang to delete after demo
    link: {
      label: "Items Lookup"
      #url: "https://demoeast.cloud.looker.com/dashboards/224?Product+Matches=500&Product+Description=90s+punk+rock&Created+Month=6+months"
      url: "https://demoeast.cloud.looker.com/dashboards/224?Product+Matches=500&Product+Description=gloves&Created+Month=6+months"
    }
  }





}
