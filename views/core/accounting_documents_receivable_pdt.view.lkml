view: accounting_documents_receivable_pdt {

   derived_table: {
      sql: SELECT
        Client_MANDT,
        --ExchangeRateType_KURST,
        CompanyCode_BUKRS,
        CustomerNumber_KUNNR,
        FiscalYear_GJAHR,
        AccountingDocumentNumber_BELNR,
        NumberOfLineItemWithinAccountingDocument_BUZEI as AccountingDocumentLineItem_BUZEI,
        CurrencyKey_WAERS,
        LocalCurrency_HWAER,
        AccountType_KOART,

        DocumentDateInDocument_BLDAT,
        InvoiceToWhichTheTransactionBelongs_REBZG,
        BillingDocument_VBELN,

        ---needed to derive receivable-related flags
        AmountInLocalCurrency_DMBTR, --currfix applied based on HWAER

        SpecialGlIndicator_UMSKZ, --for bad debt
        Indicator_SalesRelatedItem_XUMSW, --for sales

        PostingDateInTheDocument_BUDAT,
        ClearingDate_AUGDT,
        netDueDateCalc AS NetDueDate,
        Sk1DtCalc AS CashDiscount1Date,
        Sk2DtCalc AS CashDiscount2Date

      FROM `thjennifer3.CORTEX_SAP_REPORTING.AccountingDocuments`
      WHERE
         AccountType_KOART = "D"
          ;;
    }

  dimension: key {
    type: string
    primary_key: yes
    hidden: yes
    sql: CONCAT(${client_mandt},${company_code_bukrs},${accounting_document_number_belnr},${accounting_document_line_item_buzei},${fiscal_year_gjahr});;
  }

  parameter: parameter_overdue_range_size_in_days {
    type: number
    description: "Number of days to use for generating overdue ranges. For example, a value of 10 will produce past due ranges 1 - 10 days, 11 - 20 days, 21 - 30 days and 31+ days."
    default_value: "10"
    allowed_value: {value: "10"}
    allowed_value: {value: "20"}
    allowed_value: {value: "30"}
  }


  dimension: client_mandt {
    type: string
    sql: ${TABLE}.Client_MANDT ;;
  }

  dimension: company_code_bukrs {
    type: string
    sql: ${TABLE}.CompanyCode_BUKRS ;;
  }

  dimension: customer_number_kunnr {
    type: string
    sql: ${TABLE}.CustomerNumber_KUNNR ;;
  }

  dimension: fiscal_year_gjahr {
    type: string
    sql: ${TABLE}.FiscalYear_GJAHR ;;
  }

  dimension: accounting_document_number_belnr {
    type: string
    sql: ${TABLE}.AccountingDocumentNumber_BELNR ;;
  }

  dimension: accounting_document_line_item_buzei {
    type: string
    sql: ${TABLE}.AccountingDocumentLineItem_BUZEI ;;
  }

  dimension: currency_key_waers {
    type: string
    sql: ${TABLE}.CurrencyKey_WAERS ;;
  }

  dimension: local_currency_hwaer {
    type: string
    sql: ${TABLE}.LocalCurrency_HWAER ;;
  }

  dimension: account_type_koart {
    type: string
    sql: ${TABLE}.AccountType_KOART ;;
  }

  dimension: document_date_in_document_bldat {
    type: date
    datatype: date
    sql: ${TABLE}.DocumentDateInDocument_BLDAT ;;
  }

  dimension: invoice_to_which_the_transaction_belongs_rebzg {
    type: string
    sql: ${TABLE}.InvoiceToWhichTheTransactionBelongs_REBZG ;;
  }

  dimension: billing_document_vbeln {
    type: string
    sql: ${TABLE}.BillingDocument_VBELN ;;
  }

  dimension: amount_in_local_currency_dmbtr {
    type: number
    sql: ${TABLE}.AmountInLocalCurrency_DMBTR ;;
  }

  dimension: amount_in_target_currency_dmbtr {
    type: number
    sql: round(${amount_in_local_currency_dmbtr} * ${currency_conversion_sdt.exchange_rate_ukurs},2);;
  }

  dimension: special_gl_indicator_umskz {
    type: string
    sql: ${TABLE}.SpecialGlIndicator_UMSKZ ;;
  }

  dimension: indicator_sales_related_item_xumsw {
    type: string
    sql: ${TABLE}.Indicator_SalesRelatedItem_XUMSW ;;
  }

  dimension: posting_date_in_the_document_budat {
    type: date
    datatype: date
    sql: ${TABLE}.PostingDateInTheDocument_BUDAT ;;
  }

  dimension: clearing_date_augdt {
    type: date
    datatype: date
    sql: ${TABLE}.ClearingDate_AUGDT ;;
  }

  dimension: net_due_date {
    type: date
    datatype: date
    sql: ${TABLE}.NetDueDate ;;
  }

  dimension: cash_discount1_date {
    type: date
    datatype: date
    sql: ${TABLE}.CashDiscount1Date ;;
  }

  dimension: cash_discount2_date {
    type: date
    datatype: date
    sql: ${TABLE}.CashDiscount2Date ;;
  }

  dimension: is_account_receivables {
    type: yesno
    sql: @{default_target_date}
        ${posting_date_in_the_document_budat} < DATE('{{td}}') AND
        ${clearing_date_augdt} IS NULL
    ;;

    # IF(BSEG.KOART = 'D' AND BSEG.AUGDT IS NULL AND BKPF.BUDAT < CURRENT_DATE(), BSEG.DMBTR, 0) AS AccountsReceivable
  }

  dimension: is_open_and_overdue {
    type: yesno
    sql: @{default_target_date}
        ${posting_date_in_the_document_budat} < DATE('{{td}}') AND
        ${net_due_date} < DATE('{{td}}') AND
        ${clearing_date_augdt} IS NULL
    ;;
    # IF(BKPF.BUDAT < CURRENT_DATE() AND `{{ project_id_tgt }}.{{ dataset_reporting_tgt }}.NetDueDateCalc`(BSEG.KOART, BSEG.ZFBDT, BKPF.BLDAT, BSEG.SHKZG, BSEG.REBZG, BSEG.ZBD3T, BSEG.ZBD2T, BSEG.ZBD1T) < CURRENT_DATE()
    # AND BSEG.AUGDT IS NULL, BSEG.DMBTR, 0) AS OpenAndOverdue,
  }

  dimension: is_doubtful {
    type: yesno
    sql: @{default_target_date}
          ${posting_date_in_the_document_budat} < DATE('{{td}}') AND
          DATE_DIFF(DATE('{{td}}'),${net_due_date},DAY) > 90 AND
          ${clearing_date_augdt} IS NULL
      ;;
      # IF(BKPF.BUDAT < CURRENT_DATE() AND (DATE_DIFF(`{{ project_id_tgt }}.{{ dataset_reporting_tgt }}.NetDueDateCalc`(BSEG.KOART, BSEG.ZFBDT, BKPF.BLDAT, BSEG.SHKZG, BSEG.REBZG, BSEG.ZBD3T, BSEG.ZBD2T, BSEG.ZBD1T), CURRENT_DATE(), DAY) > 90 )
      # AND BSEG.AUGDT IS NULL, BSEG.DMBTR, 0)
  }

  measure: total_accounts_receivable_amount_target_currency {
    type: sum
    label: "@{derive_currency_label}Total Accounts Receivable ({{currency}})"
    sql: ${amount_in_target_currency_dmbtr} ;;
    filters: [is_account_receivables: "Yes"]
    value_format_name: "format_large_numbers_d1"
  }

  measure: percent_of_total_receivable {
    type: percent_of_total
    sql: ${total_accounts_receivable_amount_target_currency} ;;
    value_format_name: percent_1
  }

  measure: total_open_and_overdue_amount_target_currency {
    type: sum
    label: "@{derive_currency_label}Total Overdue Receivable({{currency}})"
    sql: ${amount_in_target_currency_dmbtr} ;;
    filters: [is_open_and_overdue: "Yes"]
    value_format_name: "format_large_numbers_d1"
  }

  measure: total_doubtful_amount_target_currency {
    type: sum
    label: "@{derive_currency_label}Total Doubtful Receivable({{currency}})"
    sql: ${amount_in_target_currency_dmbtr} ;;
    filters: [is_doubtful: "Yes"]
    value_format_name: "format_large_numbers_d1"
  }

  measure: row_count {
    type: count
  }





 }
