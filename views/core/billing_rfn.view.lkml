include: "/views/base/billing.view"

view: +billing {

  fields_hidden_by_default: yes

  dimension: key {
    type: string
    primary_key: yes
    sql: CONCAT(${client_mandt},${billing_document_vbeln},${billing_item_posnr});;
  }

  dimension: client_mandt {
    hidden: yes
  }

  dimension: billing_document_vbeln {
    hidden: no
    label: "@{label_field_name}"
  }

  dimension: billing_item_posnr {
    hidden: no
    label: "@{label_field_name}"
  }

  dimension: is_cancelled {
    hidden: no
    type: yesno
    sql: ${TABLE}.BillingDocumentIsCancelled_FKSTO = 'X' ;;
  }

  dimension: sales_document_aubel {
    hidden: no
    label: "@{label_field_name}"
  }

  dimension: sales_document_item_aupos {
    hidden: no
    label: "@{label_field_name}"
  }

  measure: invoice_count {
    hidden: no
    type:count_distinct
    sql:  CONCAT(${client_mandt},${billing_document_vbeln}) ;;
  }

  measure: invoice_line_count {
    hidden: no
    type: count
  }



 }
