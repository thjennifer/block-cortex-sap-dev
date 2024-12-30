include: "/test/views/accounting_documents_receivable_rfn.view"
include: "/views/core/otc_common_parameters_xvw.view"
include: "/views/core/currency_conversion_sdt.view"

explore: accounting_documents_receivable {
  sql_always_where: ${client_mandt} = '@{CLIENT_ID}' ;;

  join: otc_common_parameters_xvw {
    relationship: one_to_one
    sql:  ;;
  }

  join: currency_conversion_sdt {
    type: inner
    relationship: many_to_one
    sql_on: ${accounting_documents_receivable.client_mandt}=${currency_conversion_sdt.client_mandt} and
            ${accounting_documents_receivable.currency_key_waers}=${currency_conversion_sdt.from_currency_fcurr} and
            ${accounting_documents_receivable.posting_date_in_the_document_budat_raw} = ${currency_conversion_sdt.conv_date};;
    fields: []
  }

}
