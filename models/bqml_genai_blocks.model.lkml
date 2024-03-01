connection: "looker-private-demo"

include: "/views/*.view.lkml"                # include all views in the views/ folder in this project
# include: "/**/*.view.lkml"                 # include all views in this project
# include: "my_dashboard.dashboard.lookml"   # include a LookML dashboard called my_dashboard

# # Select the views that should be a part of this model,
# # and define the joins that connect them together.

datagroup: ecomm_daily {
  sql_trigger: SELECT MAX(DATE(created_time)) FROM `looker-private-demo.thelook_ecommerce.order_items` ;;
  max_cache_age: "32 hours"
}

datagroup: ecomm_monthly {
  sql_trigger: SELECT MAX(MONTH(created_time)) FROM `looker-private-demo.thelook_ecommerce.order_items` ;;
  max_cache_age: "32 hours"
}
#
explore: audience_clustering {
  join: audience_labeling {
    type: left_outer
    relationship: many_to_one
    sql_on: ${audience_clustering.centroid_id} = ${audience_labeling.centroid_id} ;;
  }
}
explore: product_semantic_search {}

explore: order_items {
  join: product_semantic_search {
    type: left_outer
    relationship: many_to_one
    sql_on: ${order_items.product_id} = ${product_semantic_search.matched_product_id} ;;
  }

  join: users {
    type: left_outer
    relationship: many_to_one
    sql_on: ${order_items.user_id} = ${users.id} ;;
  }
}
# explore: order_items {
#   join: orders {
#     relationship: many_to_one
#     sql_on: ${orders.id} = ${order_items.order_id} ;;
#   }
#
#   join: users {
#     relationship: many_to_one
#     sql_on: ${users.id} = ${orders.user_id} ;;
#   }
# }
