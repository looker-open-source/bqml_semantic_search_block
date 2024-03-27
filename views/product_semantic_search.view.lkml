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
}
