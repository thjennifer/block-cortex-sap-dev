######################
# this persisted sdt view finds the distinct list Language_SPRAS values found in SalesOrganizationsMD
#
# recommend setting a data trigger based on how often the  Language_SPRAS value is expected to change
# datagroup trigger set initially as Monthly on First day of month. To use a different trigger:
#     1. define datagroup in datagroups.lkml file found in components folder
#     2. replace datagroup_trigger: value below with name of datagroup
#
# this view is used in Explore otc_languages_pdt to provide suggestions for Language parameter values
#
######################

view: otc_languages_pdt {
  derived_table: {
    datagroup_trigger: monthly_on_day_1

    sql: SELECT DISTINCT Language_SPRAS
         FROM `@{GCP_PROJECT_ID}.@{REPORTING_DATASET}.SalesOrganizationsMD` ;;
  }

  dimension: language_spras {
    type: string
    sql: ${TABLE}.Language_SPRAS ;;
  }

}
