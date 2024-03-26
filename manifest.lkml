project_name: "bqml_genai_blocks"

# # Use local_dependency: To enable referencing of another project
# # on this instance with include: statements
#
# local_dependency: {
#   project: "name_of_other_project"
# }

constant: BQML_REMOTE_CONNECTION_MODEL_ID {
  value: "looker-private-demo.ecomm.email_promotion"
}

constant: BQML_REMOTE_CONNECTION_ID {
  value: "us.ecomm-email"
}

constant: LOOKER_BIGQUERY_CONNECTION_NAME {
  value: "looker-private-demo"
}
