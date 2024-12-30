include: "/test/views/accounting_documents_receivable_pdt.view"
include: "/views/core/otc_common_parameters_xvw.view"
include: "/views/core/currency_conversion_sdt.view"
# include: "/views/core/language_map_sdt.view"
include: "/views/core/companies_md_rfn.view"
include: "/views/core/customers_md_rfn.view"

explore: accounting_documents_receivable_pdt {
  sql_always_where: ${client_mandt} = '@{CLIENT_ID}' ;;

  join: otc_common_parameters_xvw {
    relationship: one_to_one
    sql:  ;;
  }

  # join: language_map_sdt {
  #   type: cross
  #   relationship: many_to_one
  #   fields: []
  # }


  join: currency_conversion_sdt {
   type: inner
    relationship: many_to_one
    sql_on: ${accounting_documents_receivable_pdt.client_mandt}=${currency_conversion_sdt.client_mandt} AND
            ${accounting_documents_receivable_pdt.local_currency_hwaer}=${currency_conversion_sdt.from_currency_fcurr} AND
           -- ${accounting_documents_receivable_pdt.currency_key_waers}=${currency_conversion_sdt.from_currency_fcurr} AND
            ${accounting_documents_receivable_pdt.posting_date_in_the_document_budat} = ${currency_conversion_sdt.conv_date};;
    fields: []
  }

  join: companies_md {
    view_label: "Accounting Documents Receivable"
    type: left_outer
    relationship: many_to_one
    sql_on:  ${accounting_documents_receivable_pdt.client_mandt}=${companies_md.client_mandt} AND
             ${accounting_documents_receivable_pdt.company_code_bukrs} = ${companies_md.company_code_bukrs} AND
             ${companies_md.language_spras} = @{user_language}
            ;;
  }

  join: customers_md {
    view_label: "Accounting Documents Receivable"
    type: left_outer
    relationship: many_to_one
    sql_on:  ${accounting_documents_receivable_pdt.client_mandt}=${customers_md.client_mandt} AND
             ${accounting_documents_receivable_pdt.customer_number_kunnr} = ${customers_md.customer_number_kunnr} AND
             ${customers_md.language_spras} = @{user_language}
            ;;
  }

}
