# Replaces view SalesOrderPricing found in reporting later to correct IntercompanyPrice logic
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
                AND StepNumber_STUNR = max_intercompany_stunr, ConditionValue_KWERT, NULL) ) AS IntercompanyPrice,
            SUM(
            IF
              ( ConditionClass_KOAID = 'A'
                AND ConditionIsInactive_KINAK IS NULL, ConditionValue_KWERT, NULL) ) AS DiscountAmount
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
    label: "Document Condition Number@{label_append_sap_code}"
    description: "Number of the document condition (KNUMV)"
    sql: ${TABLE}.NumberOfTheDocumentCondition_KNUMV ;;
  }

  dimension: condition_item_number_kposn {
    type: string
    label: "@{label_field_name}"
    description: "Condition item number (KPOSN)"
    sql: ${TABLE}.ConditionItemNumber_KPOSN ;;
  }

#########################################################
# DIMENSIONS: Currency Conversion
#{
# Requires currency_conversion_sdt to be joined in same Explore


  dimension: target_currency {
    hidden: yes
    label: "Currency (Target)"
    description:  "Code indicating the target currency into which the source currency is converted"
    sql: {% parameter otc_common_parameters_xvw.parameter_target_currency %} ;;
  }

  dimension: exchange_rate_ukurs {
    hidden: yes
    label: "@{label_field_name}"
    sql: ${currency_conversion_sdt.exchange_rate_ukurs} ;;
  }

#}

  dimension: list_price {
    type: number
    label: "List Price (Source Currency)"
    description: "Standard price at which product is typically sold (Source Currency)"
    sql: ${TABLE}.ListPrice ;;
  }

  dimension: list_price_target_currency {
    hidden: no
    type: number
    label: "List Price (Target Currency)"
    description: "Standard price at which product is typically sold (Target Currency)"
    sql: ${list_price} * ${exchange_rate_ukurs} ;;
    value_format_name: decimal_2
  }

  dimension: adjusted_price {
    type: number
    description: "Price after applying discounts, rebates and/or promotions (Local Currency)"
    sql: ${TABLE}.AdjustedPrice ;;
  }

  dimension: adjusted_price_target_currency {
    hidden: no
    type: number
    label: "Adjusted Price (Target Currency)"
    description: "Price after applying discounts, rebates and/or promotions (Target Currency)"
    sql: ${adjusted_price} * ${exchange_rate_ukurs} ;;
    value_format_name: decimal_2
  }

  dimension: intercompany_price {
    type: number
    label: "Intercompany Price (Source Currency)"
    description: "Price at which goods are transferred between different company codes (Source Currency)"
    sql: ${TABLE}.IntercompanyPrice ;;
    value_format_name: decimal_2
  }

  dimension: intercompany_price_target_currency {
    hidden: no
    type: number
    label: "Intercompany Price (Target Currency)"
    description: "Price at which goods are transferred between different company codes (Target Currency)"
    sql: ${intercompany_price} * ${exchange_rate_ukurs} ;;
    value_format_name: decimal_2
  }

  dimension: discount_amount {
    type: number
    label: "Discount Amount"
    description: "Discount amount taken off of list price (Source Currency)"
    sql: ${TABLE}.DiscountAmount ;;
    value_format_name: decimal_2
  }

  dimension: discount_amount_target_currency {
    hidden: no
    type: number
    label: "Discount Amount (Target Currency)"
    description: "Discount amount taken off of list price (Target Currency)"
    sql: ${discount_amount} * ${exchange_rate_ukurs} ;;
    value_format_name: decimal_2
  }

  measure: average_list_price_target_currency {
    hidden: no
    type: average
    label: "@{label_currency_defaults}@{label_currency_field_name}@{label_currency_if_selected}"
    sql: ${list_price_target_currency} ;;
    value_format_name: decimal_0
  }

  measure: average_adjusted_price_target_currency {
    hidden: no
    type: average
    label: "@{label_currency_defaults}@{label_currency_field_name}@{label_currency_if_selected}"
    sql: ${adjusted_price_target_currency} ;;
    value_format_name: decimal_0
  }

  measure: difference_list_and_adjusted_price_target_currency {
    hidden: no
    type: number
    label: "@{label_currency_defaults}@{label_currency_field_name}@{label_currency_if_selected}"
    description: "Difference between average list price and average adjusted price in target currency"
    sql: ${average_list_price_target_currency} - ${average_adjusted_price_target_currency};;
    value_format_name: decimal_2
  }

  measure: absolute_difference_list_and_adjusted_price_target_currency {
    hidden: yes
    type: number
    label: "@{label_currency_defaults}@{label_currency_field_name}@{label_currency_if_selected}"
    description: "Absolute value of difference between average list price and average adjusted price"
    sql: ABS(${difference_list_and_adjusted_price_target_currency});;
    value_format_name: decimal_2
  }

  measure: average_intercompany_price_target_currency {
    hidden: no
    type: average
    label: "@{label_currency_defaults}@{label_currency_field_name}@{label_currency_if_selected}"
    sql: ${intercompany_price_target_currency} ;;
    value_format_name: decimal_0
  }

  measure: difference_list_and_intercompany_price_target_currency {
    hidden: no
    type: number
    label: "@{label_currency_defaults}@{label_currency_field_name}@{label_currency_if_selected}"
    description: "Difference between average list price and average intercompany price in target currency"
    sql: ${average_list_price_target_currency} - ${average_intercompany_price_target_currency};;
    value_format_name: decimal_2
  }

  measure: absolute_difference_list_and_intercompany_price_target_currency {
    hidden: yes
    type: number
    label: "@{label_currency_defaults}@{label_currency_field_name}@{label_currency_if_selected}"
    description: "Absolute value of difference between average list price and average intercompany price"
    sql: ABS(${difference_list_and_intercompany_price_target_currency});;
    value_format_name: decimal_2
  }

  measure: total_discount_amount_target_currency {
    hidden: no
    type: sum
    label: "@{label_currency_defaults}@{label_currency_field_name}@{label_currency_if_selected}"
    description: "Sum of Condition Value (KWERT) when Condition Class (KOAID) = 'A'. Value reported as a positive value"
    sql: ${discount_amount_target_currency} * -1 ;;
    value_format_name: decimal_2
  }

  measure: total_discount_amount_target_currency_formatted {
    hidden: no
    type: number
    label: "@{label_currency_defaults}{%- assign add_formatted = true  -%}@{label_currency_field_name}@{label_currency_if_selected}"
    description: "Sum of Condition Value (KWERT) when Condition Class (KOAID) = 'A'. Value reported as a positive value and formatted for large numbers"
    sql: ${total_discount_amount_target_currency} ;;
    value_format_name: format_large_numbers_d1
  }

  }
