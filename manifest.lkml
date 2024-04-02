project_name: "bqml_genai_blocks"

# This is the ID of the BQML MODEL setup with the remote connect
constant: BQML_REMOTE_CONNECTION_MODEL_ID {
  value: "looker-private-demo.ecomm.email_promotion"
}

# This is the ID of the remote connection setup in BigQuery
constant: BQML_REMOTE_CONNECTION_ID {
  value: "us.ecomm-email"
}

# This is the name of the Looker BigQuery Database connection
constant: LOOKER_BIGQUERY_CONNECTION_NAME {
  value: "looker-private-demo"
}
