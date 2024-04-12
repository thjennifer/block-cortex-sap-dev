view: sales_order_item_billing_summary_sdt {
  fields_hidden_by_default: yes
  derived_table: {
    sql:  SELECT
             so.Client_MANDT,
             so.SalesDocument_VBELN,
             so.Item_POSNR,
             so.CumulativeOrderQuantity_KWMENG,
             b.billing_quantity,
             so.CumulativeOrderQuantity_KWMENG = coalesce(b.billing_quantity,0) AS is_item_order_and_billing_quantity_equal,
             MIN(so.CumulativeOrderQuantity_KWMENG =  COALESCE(b.billing_quantity,0)) over (PARTITION by so.Client_MANDT, so.SalesDocument_VBELN) AS is_order_billed_in_full
          FROM `@{GCP_PROJECT_ID}.@{REPORTING_DATASET}.SalesOrders_V2` so
          LEFT JOIN
          (SELECT
              Client_MANDT
             ,SalesDocument_AUBEL
             ,SalesDocumentItem_AUPOS
             ,SUM(ActualBilledQuantity_FKIMG) AS billing_quantity
          FROM `@{GCP_PROJECT_ID}.@{REPORTING_DATASET}.Billing`
          WHERE BillingType_FKART in ('F1','F2')
          AND BillingDocumentIsCancelled_FKSTO is NULL
          GROUP BY 1,2,3) b
          ON so.Client_MANDT = b.Client_MANDT
          AND so.SalesDocument_VBELN = b.SalesDocument_AUBEL
          AND so.Item_POSNR = b.SalesDocumentItem_AUPOS ;;
  }

  dimension: key {
    primary_key: yes
    sql: concat(${client_mandt},${sales_document_vbeln},${item_posnr}) ;;
  }

  dimension: client_mandt {
    type: string
    sql: ${TABLE}.Client_MANDT ;;
  }

  dimension: sales_document_vbeln {
    type: string
    sql: ${TABLE}.SalesDocument_VBELN ;;
  }

  dimension: item_posnr {
    type: string
    sql: ${TABLE}.Item_POSNR ;;
  }

  dimension: cumulative_order_quantity_kwmeng {
    type: number
    sql: ${TABLE}.CumulativeOrderQuantity_KWMENG ;;
  }

  dimension: billing_quantity {
    hidden: no
    type: number
    sql: ${TABLE}.billing_quantity ;;
  }

  dimension: is_item_order_and_billing_quantity_equal {
    type: yesno
    sql: ${TABLE}.is_item_order_and_billing_quantity_equal ;;
  }

  dimension: is_order_billed_in_full {
    hidden: no
    type: yesno
    sql: ${TABLE}.is_order_billed_in_full ;;
  }

  measure: total_quantity_billed {
    hidden: no
    type: sum
    sql: ${billing_quantity} ;;
  }


}
