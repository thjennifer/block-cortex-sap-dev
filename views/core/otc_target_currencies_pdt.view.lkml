######################
# this persisted sdt view finds the distinct list of TCURR values found in CurrencyConversion
#
# recommend setting a data trigger based on how often the TCURR value is expected to change
# datagroup trigger set initially as Monthly on First day of month. To use a different trigger:
#     1. define datagroup in datagroups.lkml file found in components folder
#     2. replace datagroup_trigger: value below with name of datagroup
#
# this view is used in Explore Target Currency List to provide suggestions for Local Currency filter values and Exchange Rate Type parameter values
#
######################

view: otc_target_currencies_pdt {
    derived_table: {
      datagroup_trigger: monthly_on_day_1

      sql: select distinct ExchangeRateType_KURST, ToCurrency_TCURR
           from `@{GCP_PROJECT_ID}.@{REPORTING_DATASET}.CurrencyConversion` ;;
    }

  dimension: exchange_rate_type_kurst {
    type: string
    sql: ${TABLE}.ExchangeRateType_KURST ;;
  }

  dimension: to_currency_tcurr {
    type: string
    sql: ${TABLE}.ToCurrency_TCURR ;;
  }

  }