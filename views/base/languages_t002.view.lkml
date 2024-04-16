view: languages_t002 {
  sql_table_name: `@{GCP_PROJECT_ID}.@{REPORTING_DATASET}.Languages_T002` ;;

  dimension: degree_of_translation_of_language_lahq {
    type: string
    description: "Degree of Translation of Lang."
    sql: ${TABLE}.DegreeOfTranslationOfLanguage_LAHQ ;;
  }
  dimension: language_key_spras {
    type: string
    description: "Language Key"
    sql: ${TABLE}.LanguageKey_SPRAS ;;
  }
  dimension: language_specifications_laspez {
    type: string
    description: "Language specifications"
    sql: ${TABLE}.LanguageSpecifications_LASPEZ ;;
  }
  dimension: two_character_sap_language_code_laiso {
    type: string
    description: "Lang. (ISO 639)"
    sql: ${TABLE}.TwoCharacterSapLanguageCode_LAISO ;;
  }
  measure: count {
    type: count
  }
}