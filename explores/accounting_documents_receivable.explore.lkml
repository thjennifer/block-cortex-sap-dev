include: "/views/core/accounting_documents_receivable_rfn.view"
include: "/views/core/currency_conversion_sdt.view"

explore: accounting_documents_receivable {
  sql_always_where: ${client_mandt} = '@{CLIENT_ID}' ;;

  join: currency_conversion_sdt {
    view_label: "🔍 Filters & 🛠 Tools"
    type: inner
    relationship: many_to_one
    sql_on: ${accounting_documents_receivable.client_mandt}=${currency_conversion_sdt.client_mandt} and
            ${accounting_documents_receivable.currency_key_waers}=${currency_conversion_sdt.from_currency_fcurr} and
            ${accounting_documents_receivable.posting_date_in_the_document_budat_raw} = ${currency_conversion_sdt.conv_date};;
  }

}
