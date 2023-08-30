######################
# select from CurrencyConversion for given:
#   - Client ID
#   - Exchange Rate Type
#   - Target Currency (from parameter select_target_currency)
#   - Conversion Date Range (from filter partition_date_filter)
######################

view: currency_conversion_sdt {
  label: "Currency Conversion"

  derived_table: {
    sql: select  Client_MANDT
                ,ConvDate
                ,StartDate
                ,EndDate
                ,ExchangeRateType_KURST
                ,ExchangeRate_UKURS
                ,FromCurrency_FCURR
                ,ToCurrency_TCURR
      from `@{GCP_PROJECT_ID}.@{REPORTING_DATASET}.CurrencyConversion`
      where Client_MANDT = '@{CLIENT_ID}'
      and ExchangeRateType_KURST = '@{EXCHANGE_RATE_TYPE}'
      and ToCurrency_TCURR = {% parameter select_target_currency %}
      and {% condition partition_date_filter %} timestamp(ConvDate) {% endcondition %}
      ;;
  }

  dimension: key {
    hidden: yes
    primary_key: yes
    sql: concat(${client_mandt},${exchange_rate_type_kurst},${from_currency_fcurr}, ${to_currency_tcurr},${conv_date} ;;
  }

  filter: partition_date_filter {
    type: date
  }

  parameter: select_target_currency {
    type: string
    allowed_value: {
      label: "USD"
      value: "USD"
    }
    allowed_value: {
      label: "EUR"
      value: "EUR"
    }
    allowed_value: {
      label: "CAD"
      value: "CAD"
    }
    allowed_value: {
      label: "JPY"
      value: "JPY"
    }
    hidden: no
    default_value: "USD"
  }

  dimension: client_mandt {
    label: "Client MANDT"
    type: string
    sql: ${TABLE}.Client_MANDT ;;
  }

  dimension: conv_date {
    label: "Conversion Date"
    type: date
    sql: ${TABLE}.ConvDate ;;
  }

  dimension: start_date {
    type: date
    sql: ${TABLE}.StartDate ;;
  }

  dimension: end_date {
    type: date
    sql: ${TABLE}.EndDate ;;
  }

  dimension: exchange_rate_type_kurst {
    label: "Exchange Rate Type KURST"
    type: string
    sql: ${TABLE}.ExchangeRateType_KURST ;;
  }

  dimension: from_currency_fcurr {
    label: "From Currency FCURR"
    type: string
    sql: ${TABLE}.FromCurrency_FCURR ;;
  }

  dimension: to_currency_tcurr {
    label: "To Currency TCURR"
    type: string
    sql: ${TABLE}.ToCurrency_TCURR ;;
  }

  dimension: exchange_rate_ukurs {
    label: "Exchange Rate UKURS"
    type: number
    sql: ${TABLE}.ExchangeRate_UKURS ;;
  }



 measure: count {
    type: count
  }
}
