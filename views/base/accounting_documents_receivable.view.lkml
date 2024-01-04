view: accounting_documents_receivable {
  sql_table_name: `thjennifer3.CORTEX_SAP_REPORTING.AccountingDocumentsReceivable` ;;

  dimension: account_type_koart {
    type: string
    sql: ${TABLE}.AccountType_KOART ;;
  }
  dimension: accounting_document_number_belnr {
    type: string
    sql: ${TABLE}.AccountingDocumentNumber_BELNR ;;
  }
  dimension: accounts_receivable {
    type: number
    sql: ${TABLE}.AccountsReceivable ;;
  }
  dimension: bad_debt_dmbtr {
    type: number
    sql: ${TABLE}.BadDebt_DMBTR ;;
  }
  dimension: billing_document_vbeln {
    type: string
    sql: ${TABLE}.BillingDocument_VBELN ;;
  }
  dimension_group: cash_discount_date1 {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.CashDiscountDate1 ;;
  }
  dimension_group: cash_discount_date2 {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.CashDiscountDate2 ;;
  }
  dimension: city_ort01 {
    type: string
    sql: ${TABLE}.City_ORT01 ;;
  }
  dimension: cleared_after_due_date {
    type: number
    sql: ${TABLE}.ClearedAfterDueDate ;;
  }
  dimension: cleared_on_or_before_due_date {
    type: number
    sql: ${TABLE}.ClearedOnOrBeforeDueDate ;;
  }
  dimension: client_mandt {
    type: string
    sql: ${TABLE}.Client_MANDT ;;
  }
  dimension: company_city {
    type: string
    sql: ${TABLE}.Company_City ;;
  }
  dimension: company_code_bukrs {
    type: string
    sql: ${TABLE}.CompanyCode_BUKRS ;;
  }
  dimension: company_country {
    type: string
    sql: ${TABLE}.Company_Country ;;
  }
  dimension: company_text_butxt {
    type: string
    sql: ${TABLE}.CompanyText_BUTXT ;;
  }
  dimension: country_key_land1 {
    type: string
    sql: ${TABLE}.CountryKey_LAND1 ;;
  }
  dimension: currency_key_waers {
    type: string
    sql: ${TABLE}.CurrencyKey_WAERS ;;
  }
  dimension: current_period {
    type: string
    sql: ${TABLE}.Current_Period ;;
  }
  dimension: customer_number_kunnr {
    type: string
    sql: ${TABLE}.CustomerNumber_KUNNR ;;
  }
  dimension: days_in_arrear {
    type: number
    sql: ${TABLE}.DaysInArrear ;;
  }
  dimension_group: document_date_in_document_bldat {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.DocumentDateInDocument_BLDAT ;;
  }
  dimension: doubtful_receivables {
    type: number
    sql: ${TABLE}.DoubtfulReceivables ;;
  }
  dimension: exchange_rate_type_kurst {
    type: string
    sql: ${TABLE}.ExchangeRateType_KURST ;;
  }
  dimension: fiscal_year_gjahr {
    type: string
    sql: ${TABLE}.FiscalYear_GJAHR ;;
  }
  dimension: fiscalyear_variant_periv {
    type: string
    sql: ${TABLE}.FiscalyearVariant_PERIV ;;
  }
  dimension: invoice_to_which_the_transaction_belongs_rebzg {
    type: string
    sql: ${TABLE}.InvoiceToWhichTheTransactionBelongs_REBZG ;;
  }
  dimension: local_currency_hwaer {
    type: string
    sql: ${TABLE}.LocalCurrency_HWAER ;;
  }
  dimension: name1_name1 {
    type: string
    sql: ${TABLE}.NAME1_NAME1 ;;
  }
  dimension_group: net_due {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.NetDueDate ;;
  }
  dimension: number_of_line_item_within_accounting_document_buzei {
    type: string
    sql: ${TABLE}.NumberOfLineItemWithinAccountingDocument_BUZEI ;;
  }
  dimension: open_and_not_due {
    type: number
    sql: ${TABLE}.OpenAndNotDue ;;
  }
  dimension: open_and_over_due {
    type: number
    sql: ${TABLE}.OpenAndOverDue ;;
  }
  dimension: period {
    type: string
    sql: ${TABLE}.Period ;;
  }
  dimension_group: posting_date_in_the_document_budat {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.PostingDateInTheDocument_BUDAT ;;
  }
  dimension: sales {
    type: number
    sql: ${TABLE}.Sales ;;
  }
  dimension: written_off_amount_dmbtr {
    type: number
    sql: ${TABLE}.WrittenOffAmount_DMBTR ;;
  }
  measure: count {
    type: count
  }
}
