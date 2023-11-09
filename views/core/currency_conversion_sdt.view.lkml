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
      and ExchangeRateType_KURST = {% parameter select_exchange_rate_type_kurst %}
      and ToCurrency_TCURR = {% parameter select_local_currency %}
      --and {% condition select_local_currency %} ToCurrency_TCURR {% endcondition %}
      and
        {% if _explore._name == 'sales_orders_v2' %}
            {% condition sales_orders_v2.date_filter %} timestamp(ConvDate) {% endcondition %}
        {% else %}

          {% condition partition_date_filter %} timestamp(ConvDate) {% endcondition %}
        {% endif %}
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

  parameter: select_local_currency {
    type: string
    # default_value: "USD" default will be populated by dashboard filter using user_attribute sap_default_local_currency
    suggest_explore: local_currency_list
    suggest_dimension: to_currency_tcurr
    default_value: "USD"
  }

  parameter: select_exchange_rate_type_kurst {
    type: string
    label: "Select Exchange Rate Type KURST"
    default_value: "M"
    suggest_explore: local_currency_list
    suggest_dimension: exchange_rate_type_kurst
  }

  # parameter: select_target_currency {
  #   type: string
  #   allowed_value: {
  #     label: "USD"
  #     value: "USD"
  #   }
  #   allowed_value: {
  #     label: "EUR"
  #     value: "EUR"
  #   }
  #   allowed_value: {
  #     label: "CAD"
  #     value: "CAD"
  #   }
  #   allowed_value: {
  #     label: "JPY"
  #     value: "JPY"
  #   }
  #   hidden: no
  #   default_value: "USD"
  # }

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