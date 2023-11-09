view: returns_sdt {

  fields_hidden_by_default: yes

  derived_table: {
    sql: SELECT
        sv2.Client_Mandt,
        sv2.SalesDocument_VBELN,
        sv2.Item_POSNR,
        sv2.DocumentCategory_VBTYP,
        sv2.CreationDate_ERDAT,
        sv2.CreationTime_ERZET,
        sv2.CumulativeOrderQuantity_KWMENG,
        sv2.NetPrice_NETPR,
        sv2.PrecedingDocCategory_VGTYP
        --ReferenceDocument_VGBEL equals:
        -- SalesDocument_VBELN when PrecedingDocCategory_VGTYP = C
        -- BillingDocument when PrecedingDocCategory_VGTYP = M
        ,
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
        `thjennifer3.CORTEX_SAP_REPORTING.SalesOrders_V2` sv2
      LEFT JOIN
        `thjennifer3.CORTEX_SAP_REPORTING.Billing` b
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
    sql: concat(${client_mandt},${sales_document_vbeln},${item_posnr},${reference_sales_document_vbeln},${reference_item_posnr}) ;;
  }

  dimension: client_mandt {
    type: string
    sql: ${TABLE}.Client_Mandt ;;
  }

  dimension: sales_document_vbeln {
    type: string
    sql: ${TABLE}.SalesDocument_VBELN ;;
  }

  dimension: item_posnr {
    type: string
    sql: ${TABLE}.Item_POSNR ;;
  }

  dimension: document_category_vbtyp {
    type: string
    sql: ${TABLE}.DocumentCategory_VBTYP ;;
  }

  dimension: creation_date_erdat {
    type: date
    datatype: date
    sql: ${TABLE}.CreationDate_ERDAT ;;
  }

  dimension: creation_time_erzet {
    type: string
    sql: ${TABLE}.CreationTime_ERZET ;;
  }

  dimension: cumulative_order_quantity_kwmeng {
    type: number
    sql: ${TABLE}.CumulativeOrderQuantity_KWMENG ;;
  }

  dimension: net_price_netpr {
    type: number
    sql: ${TABLE}.NetPrice_NETPR ;;
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

  measure: count_returns {
    type: count_distinct
    sql: ${reference_sales_document_vbeln} ;;
  }


}
