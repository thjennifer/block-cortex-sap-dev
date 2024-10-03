view: sales_order_pricing_sdt {

  fields_hidden_by_default: yes

  derived_table: {
    sql: SELECT
            Client_MANDT,
            NumberOfTheDocumentCondition_KNUMV,
            ConditionItemNumber_KPOSN,
            SUM(
            IF
              ( CalculationTypeForCondition_KRECH = 'C'
                AND ConditionClass_KOAID = 'B'
                AND ConditionIsInactive_KINAK IS NULL, ConditionValue_KWERT, NULL) ) AS ListPrice,
            SUM(
            IF
              ( CalculationTypeForCondition_KRECH = 'C'
                AND ConditionClass_KOAID = 'B'
                AND ConditionType_KSCHL = 'PB00'
                AND ConditionIsInactive_KINAK IS NULL, ConditionValue_KWERT, NULL) ) AS AdjustedPrice,
            SUM(
            IF
              ( ConditionForInterCompanyBilling_KFKIV = 'X'
                AND ConditionClass_KOAID = 'B'
                AND ConditionIsInactive_KINAK IS NULL
                AND CalculationTypeForCondition_KRECH <> 'C'
                AND StepNumber_STUNR = max_intercompany_stunr, ConditionValue_KWERT, NULL) ) AS InterCompanyPrice,
            SUM(
            IF
              ( ConditionClass_KOAID = 'A'
                AND ConditionIsInactive_KINAK IS NULL, ConditionValue_KWERT, NULL) ) AS Discount
        FROM (
          SELECT
            Client_MANDT,
            NumberOfTheDocumentCondition_KNUMV,
            ConditionItemNumber_KPOSN,
            StepNumber_STUNR,
            CalculationTypeForCondition_KRECH,
            ConditionForInterCompanyBilling_KFKIV,
            ConditionClass_KOAID,
            ConditionIsInactive_KINAK,
            ConditionType_KSCHL,
            ConditionValue_KWERT,
            MAX(CASE
                WHEN ConditionForInterCompanyBilling_KFKIV = 'X' AND ConditionClass_KOAID = 'B' AND ConditionIsInactive_KINAK IS NULL THEN StepNumber_STUNR
            END
              ) OVER (PARTITION BY Client_MANDT, NumberOfTheDocumentCondition_KNUMV, ConditionItemNumber_KPOSN) AS max_intercompany_stunr
          FROM
            `@{GCP_PROJECT_ID}.@{REPORTING_DATASET}.PricingConditions`
          WHERE Client_MANDT = '@{CLIENT_ID}'
          ) AS pc
    GROUP BY
      Client_MANDT,
      NumberOfTheDocumentCondition_KNUMV,
      ConditionItemNumber_KPOSN
       ;;
    }

  dimension: key {
    type: string
    primary_key: yes
    hidden: yes
    sql: CONCAT(${client_mandt},${number_of_the_document_condition_knumv},${condition_item_number_kposn}) ;;
  }

  dimension: client_mandt {
    type: string
    sql: ${TABLE}.Client_MANDT ;;
  }

  dimension: number_of_the_document_condition_knumv {
    type: string
    sql: ${TABLE}.NumberOfTheDocumentCondition_KNUMV ;;
  }

  dimension: condition_item_number_kposn {
    type: string
    sql: ${TABLE}.ConditionItemNumber_KPOSN ;;
  }

  dimension: list_price {
    type: number
    label: "List Price (Local Currency)"
    description: "Standard price at which product is typically sold (Local Currency)"
    sql: ${TABLE}.ListPrice ;;
  }

  dimension: list_price_target {
    type: number
    label: "List Price (Target Currency)"
    description: "Standard price at which product is typically sold (Target Currency)"
    sql: ${list_price} * ${currency_conversion_sdt.exchange_rate_ukurs} ;;
    value_format_name: decimal_2
  }

  dimension: adjusted_price {
    type: number
    description: "Price after applying discounts, rebates and/or promotions (Local Currency)"
    sql: ${TABLE}.AdjustedPrice ;;
  }

  dimension: adjusted_price_target_curr {
    type: number
    label: "Adjusted Price (Target Currency)"
    description: "Price after applying discounts, rebates and/or promotions (Target Currency)"
    sql: ${adjusted_price} * ${currency_conversion_sdt.exchange_rate_ukurs} ;;
    value_format_name: decimal_2
  }

  dimension: inter_company_price {
    type: number
    label: "Intercompany Price"
    description: "Price at which goods are transferred between different company codes (Local Currency)"
    sql: ${TABLE}.InterCompanyPrice ;;
    value_format_name: decimal_2
  }

  dimension: intercompany_price_target_curr {
    type: number
    label: "@{label_currency}Intercompany Price ({{currency}})"
    # label: "{% assign currency = otc_common_parameters_xvw.parameter_target_currency._parameter_value | remove: \"'\" %}Intercompany Price ({{currency}})"
    description: "Price at which goods are transferred between different company codes (Target Currency)"
    sql: ${inter_company_price} * ${currency_conversion_sdt.exchange_rate_ukurs} ;;
    value_format_name: decimal_2
  }

  dimension: discount {
    type: number
    label: "Discount Amount"
    description: "Discount amount taken off of list price (Local Currency)"
    sql: ${TABLE}.Discount ;;
  }

  measure: avg_list_price_target {
    hidden: no
    type: average
    label: "@{label_currency}Average List Price ({{currency}})"
    # label: "{% assign currency = otc_common_parameters_xvw.parameter_target_currency._parameter_value | remove: \"'\" %}Average List Price ({{currency}})"
    sql: ${list_price_target} ;;
    value_format_name: format_large_numbers_d1
  }

  measure: avg_adjusted_price_target_curr {
    hidden: no
    type: average
    label: "@{label_currency}Average Adjusted Price ({{currency}})"
    sql: ${adjusted_price_target_curr} ;;
    value_format_name: format_large_numbers_d1
  }

  measure: abs_difference_list_and_adjusted_price {
    hidden: no
    type: number
    description: "Absolute value difference between avg list price and avg adjusted price."
    sql: ABS(${avg_list_price_target} - ${avg_adjusted_price_target_curr});;
    value_format_name: decimal_2
  }

  measure: difference_list_and_adjusted_price {
    hidden: no
    type: number
    description: "Difference between avg list price and avg adjusted price."
    sql: ${avg_list_price_target} - ${avg_adjusted_price_target_curr};;
    value_format_name: decimal_2
  }

  measure: avg_intercompany_price_target_curr {
    hidden: no
    type: average
    label: "@{label_currency}Average Intercompany Price ({{currency}})"
    sql: ${intercompany_price_target_curr} ;;
    value_format_name: format_large_numbers_d1
  }

  }