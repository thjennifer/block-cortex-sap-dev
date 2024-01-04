include: "/views/base/accounting_documents_receivable.view"

view: +accounting_documents_receivable {
  fields_hidden_by_default: yes

  dimension: key {
    type: string
    primary_key: yes
    hidden: yes
    sql: CONCAT(${client_mandt},${accounting_document_number_belnr},${company_code_bukrs},${fiscal_year_gjahr},${number_of_line_item_within_accounting_document_buzei});;
  }



  dimension: accounting_document_number_belnr {
    hidden: no
    label: "Account Document BELNR"
  }

  dimension: company_code_bukrs {
    hidden: no
    label: "Company Code BUKRS"
  }

  dimension: fiscal_year_gjahr {
    hidden: no
    label: "Fiscal Year"
  }

  dimension: number_of_line_item_within_accounting_document_buzei {
    hidden: no
    label: "Line Item Number BUZEI"
    sql: ${TABLE}.NumberOfLineItemWithinAccountingDocument_BUZEI ;;
  }

}
