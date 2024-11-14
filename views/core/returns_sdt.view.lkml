view: returns_sdt {

  fields_hidden_by_default: yes

  derived_table: {
    sql: SELECT
        sv2.Client_Mandt,
        sv2.SalesDocument_VBELN as Return_SalesDocument_VBELN,
        sv2.Item_POSNR as Return_Item_POSNR,
        sv2.DocumentCategory_VBTYP as Return_DocumentCategory_VBTYP,
        sv2.CreationDate_ERDAT as Return_CreationDate_ERDAT,
        sv2.CreationTime_ERZET as Return_CreationTime_ERZET,
        sv2.CumulativeOrderQuantity_KWMENG as Return_ItemQuantity,
        sv2.NetPrice_NETPR as Return_NetPrice_NETPR,
        sv2.PrecedingDocCategory_VGTYP,
    --ReferenceDocument_VGBEL equals:
    -- SalesDocument_VBELN when PrecedingDocCategory_VGTYP = C
    -- BillingDocument when PrecedingDocCategory_VGTYP = M
        sv2.ReferenceDocument_VGBEL,
        sv2.ReferenceItem_VGPOS,
        sv2.DocumentNumberOfTheReferenceDocument_VGBEL,
        CASE sv2.PrecedingDocCategory_VGTYP
          WHEN 'C' THEN sv2.ReferenceDocument_VGBEL
          WHEN 'M' THEN b.SalesDocument_AUBEL
        END
          AS ReferenceSalesDocument_VBELN,
        CASE sv2.PrecedingDocCategory_VGTYP
          WHEN 'C' THEN sv2.ReferenceItem_VGPOS
          WHEN 'M' THEN b.SalesDocumentItem_AUPOS
        END
          AS ReferenceItem_POSNR
      FROM
        `@{GCP_PROJECT_ID}.@{REPORTING_DATASET}.SalesOrders_V2` sv2
      LEFT JOIN
        `@{GCP_PROJECT_ID}.@{REPORTING_DATASET}.Billing` b
      ON
        sv2.ReferenceDocument_VGBEL = b.BillingDocument_VBELN
        AND sv2.ReferenceItem_VGPOS = b.BillingItem_POSNR
        AND sv2.Client_Mandt = b.Client_MANDT
        AND b.BillingType_FKART IN ('F1',
          'F2')
        AND b.BillingDocumentIsCancelled_FKSTO IS NULL
      WHERE
        sv2.DocumentCategory_VBTYP = 'H' ;;
  }

  dimension: key {
    type: string
    primary_key: yes
    sql: concat(${client_mandt},${return_sales_document_vbeln},${return_item_posnr},${reference_sales_document_vbeln},${reference_item_posnr}) ;;
  }

  dimension: client_mandt {
    type: string
    sql: ${TABLE}.Client_Mandt ;;
  }

  dimension: return_sales_document_vbeln {
    type: string
    hidden: no
    sql: ${TABLE}.Return_SalesDocument_VBELN ;;
  }

  dimension: return_item_posnr {
    type: string
    sql: ${TABLE}.Return_Item_POSNR ;;
  }

  dimension: return_document_category_vbtyp {
    type: string
    sql: ${TABLE}.Return_DocumentCategory_VBTYP ;;
  }

  dimension: return_creation_date_erdat {
    type: date
    datatype: date
    sql: ${TABLE}.Return_CreationDate_ERDAT ;;
  }

  dimension: return_order_date_as_string {
    type: string
    label: "Return Order Date"
    sql: STRING(${TABLE}.Return_CreationDate_ERDAT) ;;
  }

  dimension: return_creation_time_erzet {
    type: string
    sql: ${TABLE}.Return_CreationTime_ERZET ;;
  }

  dimension: return_item_quantity {
    type: number
    sql: ${TABLE}.Return_ItemQuantity ;;
  }

  dimension: return_net_price_netpr {
    type: number
    sql: ${TABLE}.return_NetPrice_NETPR ;;
  }

  dimension: preceding_doc_category_vgtyp {
    type: string
    sql: ${TABLE}.PrecedingDocCategory_VGTYP ;;
  }

  dimension: reference_document_vgbel {
    type: string
    sql: ${TABLE}.ReferenceDocument_VGBEL ;;
  }

  dimension: reference_item_vgpos {
    type: string
    sql: ${TABLE}.ReferenceItem_VGPOS ;;
  }

  dimension: document_number_of_the_reference_document_vgbel {
    type: string
    sql: ${TABLE}.DocumentNumberOfTheReferenceDocument_VGBEL ;;
  }

  dimension: reference_sales_document_vbeln {
    type: string
    sql: ${TABLE}.ReferenceSalesDocument_VBELN ;;
  }

  dimension: reference_item_posnr {
    type: string
    sql: ${TABLE}.ReferenceItem_POSNR ;;
  }

  dimension: is_return {
    type: yesno
    sql: ${reference_sales_document_vbeln} is not null;;
  }

  # measure: has_return_sales_order_count {
  #   type: count_distinct
  #   sql: ${reference_sales_document_vbeln} ;;
  # }

  measure: total_returned_quantity {
    hidden: no
    type: sum
    sql: ${return_item_quantity} ;;
  }


}