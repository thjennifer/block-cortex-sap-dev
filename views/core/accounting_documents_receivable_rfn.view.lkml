include: "/views/base/accounting_documents_receivable.view"

view: +accounting_documents_receivable {
  fields_hidden_by_default: yes

  dimension: key {
    type: string
    primary_key: yes
    hidden: yes
    sql: CONCAT(${client_mandt},${company_code_bukrs},${accounting_document_number_belnr},${number_of_line_item_within_accounting_document_buzei},${fiscal_year_gjahr});;
  }

  parameter: parameter_num_monthly_periods_for_dso {
    type: number
    hidden: no
    description: "Enter number of months to use for DSO calculation."
    default_value: "1"
  }

  parameter: parameter_overdue_range_size_in_days {
    type: number
    description: "Number of days to use for generating overdue ranges. For example, a value of 10 will produce past due ranges 1 - 10 days, 11 - 20 days, 21 - 30 days and 31+ days."
    default_value: "10"
    allowed_value: {value: "10"}
    allowed_value: {value: "20"}
    allowed_value: {value: "30"}
  }

  dimension: accounting_document_number_belnr {
    hidden: no
    label: "Account Document BELNR"
  }


  dimension: fiscal_year_gjahr {
    hidden: no
    label: "Fiscal Year"
  }

  dimension: number_of_line_item_within_accounting_document_buzei {
    hidden: no
    label: "Accounting Document Line Number BUZEI"
    sql: ${TABLE}.NumberOfLineItemWithinAccountingDocument_BUZEI ;;
  }

  dimension_group: posting_date_in_the_document_budat {
    hidden: no
    label: "Posting"
  }



  dimension: accounts_receivable {
    label: "Accounts Receivable (Local Currency)"
  }

  dimension: accounts_receivable_target_currency {
    hidden: yes
    type: number
    label: "Accounts Receivable (Target Currency)"
    sql: round(${accounts_receivable} * ${currency_conversion_sdt.exchange_rate_ukurs},2) ;;
  }

  dimension: open_and_over_due {
    label: "Open and Overdue (Local Currency)"
    }

  dimension: open_and_overdue_target_currency {
    type: number
    label: "Open and Overdue (Target Currency)"
    sql: round(${open_and_over_due} * ${currency_conversion_sdt.exchange_rate_ukurs},2) ;;
  }

  #can't redo because AccountingDocumentsReceivable does not include ClearingDate_AUGDT or AmountInLocalCurrency_DMBTR
  #redo doubtful receivable due to calculation error in AccoutingDocuments reporting view
  # dimension: doubtful_receivables_corrected {
  #   hidden: no
  #   type: number
  #   # IF(BKPF.BUDAT < CURRENT_DATE() AND (DATE_DIFF(`{{ project_id_tgt }}.{{ dataset_reporting_tgt }}.NetDueDateCalc`(BSEG.KOART, BSEG.ZFBDT, BKPF.BLDAT, BSEG.SHKZG, BSEG.REBZG, BSEG.ZBD3T, BSEG.ZBD2T, BSEG.ZBD1T), CURRENT_DATE(), DAY) > 90 )
  #   #   AND BSEG.AUGDT IS NULL, BSEG.DMBTR, 0) AS DoubtfulReceivables,
  #   sql: @{default_target_date}
  #       if(${posting_date_in_the_document_budat_date} < DATE('{{td}}') AND
  #         augdt is null AND
  #         DATE_DIFF(DATE('{{td}}',${net_due_date}) > 90,
  #         ${amount_in_local_currency_dmbtr})
  # }

  dimension: doubtful_receivables {
    label: "Doubtful Receivables (Local Currency)"
  }

  dimension: doubtful_receivables_target_currency {
    type: number
    label: "Doubtful Receivables (Target Currency)"
    sql: round(${doubtful_receivables} * ${currency_conversion_sdt.exchange_rate_ukurs},2) ;;
  }

  dimension: sales {
    label: "Sales (Local Currency)"
  }


  dimension: sales_target_currency {
    hidden: yes
    type: number
    label: "Sales (Target Currency)"
    sql: round(${sales} * ${currency_conversion_sdt.exchange_rate_ukurs},2) ;;
  }

  dimension: company_text_butxt {
    hidden: yes
    label: "Company Code Text"
  }

  dimension: company_code_text {
    hidden: no
    type: string
    label: "Company Code"
    sql: ${company_text_butxt} ;;
  }

  dimension: sold_to_name {
    hidden: no
    type: string
    sql: COALESCE(${name1_name1},${customer_number_kunnr}) ;;
  }

  dimension: days_overdue {
    hidden: no
    sql: DATE_DIFF(DATE(@{default_target_date}),${net_due_date},DAY);;
  }

  dimension: overdue_day_ranges {
    hidden: no
    type: string

    sql: {% assign range_width = parameter_overdue_range_size_in_days._parameter_value | times: 1 %}
         {% assign range_end2 = range_width | times: 2 %}{% assign range_end3 = range_width | times: 3 %}
            CASE WHEN ${days_overdue} BETWEEN 1 and {{range_width}} THEN '{{ range_width | prepend: "1 - " | append: " days" }}'
                 WHEN ${days_overdue} BETWEEN {{range_width | plus: 1}} and {{range_end2 }} THEN '{{range_width | plus: 1 | append: " - " | append: range_end2 | append: " days"}}'
                 WHEN ${days_overdue} BETWEEN {{range_end2 | plus: 1}} and {{range_end3 }} THEN '{{range_end2 | plus: 1 | append: " - " | append: range_end3 | append: " days"}}'
                 WHEN ${days_overdue} > {{range_end3}} THEN '>= {{range_end3 | plus: 1 | append: " days"}}'
        END;;
    # sql: if((date_diff(cast({% parameter Key_Date %} as Date),${TABLE}.NetDueDate, DAY)>0 and date_diff(cast({% parameter Key_Date %} as Date),${TABLE}.NetDueDate, DAY)<({% parameter Aging_Interval %}+1)),concat('1- ',({% parameter Aging_Interval %}),' Days'),
    #     (if((date_diff(cast({% parameter Key_Date %} as Date),${TABLE}.NetDueDate, DAY)<(({% parameter Aging_Interval %}*2)+1)),concat(({% parameter Aging_Interval %}+1),'-',({% parameter Aging_Interval %}*2),' Days'),
    #     (if((date_diff(cast({% parameter Key_Date %} as Date),${TABLE}.NetDueDate, DAY)<(({% parameter Aging_Interval %}*3)+1)),concat(({% parameter Aging_Interval %}*2+1),'-',({% parameter Aging_Interval %}*3),' Days'),
    #     (if((date_diff(cast({% parameter Key_Date %} as Date),${TABLE}.NetDueDate, DAY)>(({% parameter Aging_Interval %}*3)+1)),concat('> ',({% parameter Aging_Interval %}*3),' Days'),'Due after Key Date' )) )) )) ) ;;
  }

  measure: count {
    hidden: no
    label: "Row Count"
  }

  measure: count_accounting_documents {
    hidden: no
    type: count_distinct
    sql: ${accounting_document_number_belnr} ;;
  }

  measure: total_receivable_target_currency {
    hidden: no
    type: sum
    label: "@{label_currency}Total Receivable ({{currency}})"
    sql: ${accounts_receivable_target_currency} ;;
    value_format_name: "format_large_numbers_d1"
  }

  measure: total_open_and_overdue_target_currency {
    hidden: no
    type: sum
    label: "@{label_currency}Total Open and Overdue ({{currency}})"
    sql: ${open_and_overdue_target_currency} ;;
    value_format_name: "format_large_numbers_d1"
    link: {
      label: "Show by Company"
      url: "{{ dummy_drill_overdue_by_company._link }}"
    }
  }

  measure: total_doubtful_receivables_target_currency {
    hidden: no
    type: sum
    label: "@{label_currency}Total Doubtful Receivable ({{currency}})"
    sql: ${doubtful_receivables_target_currency} ;;
    value_format_name: "format_large_numbers_d1"
    link: {
      label: "Show by Company"
      url: "{{ dummy_drill_doubtful_by_company._link }}"
    }
  }

  measure: total_sales_target_currency {
    hidden: no
    type: sum
    label: "@{label_currency}Total Sales ({{currency}})"
    sql: ${sales_target_currency} ;;
    value_format_name: "format_large_numbers_d1"
  }



  #DSO = The average time in days a company takes to receive payments from customers.
#   DSO is calculated in SAP by:
#
    # Average Accounts Receivable: SAP takes the average balance of your open accounts receivable (customer invoices not yet paid) over a specific period.
    # Average Daily Sales: SAP calculates the average daily sales revenue for the same period.
    # Formula:
    # DSO = (Average Accounts Receivable / Average Daily Sales)
  measure: sales_dso {
    type: sum
    hidden: yes
    label: "Sales DSO"
    sql:
     --case when PostingDateInTheDocument_BUDAT <= Current Date AND
     --          PostingDateInTheDocument_BUDAT >= (Current_Date - parameter_num_monthly_periods_for_dso MONTHS)
     --       THEN sales_target_currency
     -- for test data using CURRENT_DATE will always return 0
      CASE
      WHEN
          ${posting_date_in_the_document_budat_date} <= DATE(@{default_target_date}) AND
          ${posting_date_in_the_document_budat_date} >=
          DATE_SUB(DATE(@{default_target_date}),INTERVAL {% parameter parameter_num_monthly_periods_for_dso %} MONTH )
        THEN ${sales}
      END;;
    }

  measure: sales_target_currency_dso {
    type: sum
    hidden: no
    label: "@{label_currency}Sales DSO ({{currency}})"
    sql:
     --case when PostingDateInTheDocument_BUDAT <= Current Date AND
     --          PostingDateInTheDocument_BUDAT >= (Current_Date - parameter_num_monthly_periods_for_dso MONTHS)
     --       THEN sales_target_currency
     -- for test data using CURRENT_DATE will always return 0
      CASE
      WHEN
          ${posting_date_in_the_document_budat_date} <= DATE(@{default_target_date}) AND
          ${posting_date_in_the_document_budat_date} >=
          DATE_SUB(DATE(@{default_target_date}),INTERVAL {% parameter parameter_num_monthly_periods_for_dso %} MONTH )
        THEN ${sales_target_currency}
      END;;
    value_format_name: "format_large_numbers_d1"
  }

  measure: accounts_receivable_dso {
    type: sum
    hidden: yes
    label: "Accounts Receivable DSO"
    sql:
    --case when PostingDateInTheDocument_BUDAT <= Current Date AND
     --          PostingDateInTheDocument_BUDAT >= (Current_Date - parameter_num_monthly_periods_for_dso MONTHS)
     --       THEN accounts_receivable_target_currency

    CASE WHEN
        ${posting_date_in_the_document_budat_date} <= DATE(@{default_target_date}) AND
        ${posting_date_in_the_document_budat_date} >=
          DATE_SUB(DATE(@{default_target_date}), INTERVAL {% parameter parameter_num_monthly_periods_for_dso %} MONTH )
      THEN ${accounts_receivable}
    END;;
    value_format_name: "format_large_numbers_d1"
  }

  measure: accounts_receivable_target_currency_dso {
    type: sum
    hidden: no
    label: "@{label_currency}Accounts Receivable DSO ({{currency}})"
    sql:
    --case when PostingDateInTheDocument_BUDAT <= Current Date AND
     --          PostingDateInTheDocument_BUDAT >= (Current_Date - parameter_num_monthly_periods_for_dso MONTHS)
     --       THEN accounts_receivable_target_currency

      CASE WHEN
      ${posting_date_in_the_document_budat_date} <= DATE(@{default_target_date}) AND
      ${posting_date_in_the_document_budat_date} >=
      DATE_SUB(DATE(@{default_target_date}), INTERVAL {% parameter parameter_num_monthly_periods_for_dso %} MONTH )
      THEN ${accounts_receivable_target_currency}
      END;;
  }

  # Days Sales Outstanding = (Accounts Receivable/Net Credit Sales) x Number of days
  #   If a company has $30,000 in accounts receivable and $200,000 in revenue, then
  #. the DSO is 15% (0.15) of 365 days, or approximately 55 days.
  #  This means that it takes the company about 55 days to collect payment after making a sale.

  #  If a company has $1,000,000 in sales over a year and
  #. $100,000 in accounts receivable at the end of the year,
  #  then the DSO is 36.5 days. This means that the average number of days
  #  it takes customers to pay the company is 36.5 days.

  measure: days_sales_outstanding {
    type: number
    hidden: no
    sql:  SAFE_DIVIDE(${accounts_receivable_target_currency_dso}, ${sales_target_currency_dso}) * {% parameter parameter_num_monthly_periods_for_dso %} * 30;;
  }

  measure: dso_original {
    type: number
    hidden: yes
    sql: floor(if(${sales_dso}=0,0,(${accounts_receivable_dso}/${sales_dso})*{% parameter parameter_num_monthly_periods_for_dso %}*30)) ;;
  }


  measure: dummy_drill_overdue_by_company {
    hidden: yes
    drill_fields: [company_code_text,total_open_and_overdue_target_currency]
    sql: 1=1 ;;
  }

  measure: dummy_drill_doubtful_by_company {
    hidden: yes
    drill_fields: [company_code_text,total_doubtful_receivables_target_currency]
    sql: 1=1 ;;
  }


  # measure: percent_orders_with_return {
  #   hidden: no
  #   description: "Percent of Orders with at least 1 item returned"
  #   type: number
  #   sql:  safe_divide(${count_returns},${sales_orders_v2.count_orders});;
  #   value_format_name: percent_1
  #   link: {
  #     label: "Show Top 10 products with highest Return Rate"
  #     url: "{{ dummy_set_product_with_return._link }}&limit=10"
  #   }

  #   link: {
  #     label: "Show Orders with Returns"
  #     # url: "{{ dummy_set_details._link }}&f[Is+Order+Late]=\"Yes\""
  #     # url: "{{ dummy_set_details._link}}&f[sales_order_item_delivery_summary_ndt.test_dimension]=odd"
  #     url: "{{ dummy_set_details_orders_with_returns._link}}&f[returns_sdt.is_return]=Yes"
  #     # url: "{{ link }}&f[view_name.status]=active&f[view_name.count]=%3E1"
  #   }
  # }


  # set: set_details_orders_with_returns {
  #   fields: [sales_orders_v2.sales_document_vbeln,
  #     sales_order_item_partner_function_sdt.customer_names_ship_to,
  #     sales_orders_v2.order_date_as_string,
  #     set_product*,
  #     returns_sdt.is_return,
  #     returns_sdt.return_sales_document_vbeln,
  #     returns_sdt.return_order_date_as_string,
  #     sales_orders_v2.total_quantity_ordered,
  #     returns_sdt.total_quantity_returned
  #   ]
  # }


  # set: set_product {
  #   fields: [sales_orders_v2.material_number_matnr, materials_md.material_text_maktx]
  # }

  # measure: dummy_set_details_orders_with_returns {
  #   hidden:yes
  #   drill_fields: [set_details_orders_with_returns*]
  #   sql: 1=1 ;;
  # }

  # measure: dummy_set_product {
  #   hidden:yes
  #   drill_fields: [set_product*]
  #   sql: 1=1 ;;
  # }

  # measure: dummy_set_product_with_return {
  #   hidden:yes
  #   drill_fields: [set_product*,percent_orders_with_return]
  #   sql: 1=1 ;;
  # }





  dimension: test_target_date {
    hidden: yes
    type: string
    sql: 'DATE(@{default_target_date})' ;;
  }
}
