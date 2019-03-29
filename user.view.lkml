include: "//app-sales/user_core.view.lkml"
include: "//app-sales-adapter/user_adapter.view.lkml"

# Customize: Change the schema or table name.
view: user_schema {
  sql_table_name: salesforce.user ;;
  extension: required
}

# Customize: Override dimensions or measures here
view: user {
  extends: [user_core]

# Identify the Sales reps using this dimension
  dimension: is_sales_rep {
    type: yesno
    sql: 1=1 ;;
#     ${department} = 'Sales' AND ${title} IN ('Outside AE', 'AE', 'Inside AE', 'Account Executive', 'MM AE', 'Commercial AE');;
  }

  # How longh does it take an AE to ramp # Used in Comparison Views, this will filter ramping AE's from rankings.
  dimension: is_ramped {
    type: yesno
    sql: ${months_age} > 3 ;;
  }

  # TODO: Set your Salesforce domain (i.e. https:// _____________ .com )
  dimension: salesforce_domain_config {
    sql: looker.my.salesforce.com;;
  }
}