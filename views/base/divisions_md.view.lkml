view: divisions_md {
  sql_table_name: `@{GCP_PROJECT_ID}.@{REPORTING_DATASET}.DivisionsMD` ;;

  dimension: client_mandt {
    type: string
    sql: ${TABLE}.Client_MANDT ;;
  }
  dimension: division_name_vtext {
    type: string
    sql: ${TABLE}.DivisionName_VTEXT ;;
  }
  dimension: division_spart {
    type: string
    sql: ${TABLE}.Division_SPART ;;
  }
  dimension: language_key_spras {
    type: string
    sql: ${TABLE}.LanguageKey_SPRAS ;;
  }
  measure: count {
    type: count
  }
}