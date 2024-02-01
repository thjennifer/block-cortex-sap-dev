include: "/views/base/billing.view"

view: +billing {

  fields_hidden_by_default: yes

  dimension: key {
    type: string
    primary_key: yes
    sql: CONCAT(${client_mandt},${billing_document_vbeln},${billing_item_posnr});;
  }

  dimension: client_mandt {
    hidden: no
  }

  dimension: billing_document_vbeln {
    hidden: no
  }

  dimension: billing_item_posnr {
    hidden: no
  }

  dimension: billing_document_is_cancelled_fksto {
    hidden: no
  }

  dimension: sales_document_aubel {
    hidden: no
  }

  dimension: sales_document_item_aupos {
    hidden: no
  }

 }
