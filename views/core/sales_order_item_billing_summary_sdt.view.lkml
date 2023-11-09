view: sales_order_item_billing_summary_sdt {
  fields_hidden_by_default: yes
  derived_table: {
    sql: select so.Client_MANDT,
             so.SalesDocument_VBELN,
             so.Item_POSNR,
             so.CumulativeOrderQuantity_KWMENG,
             b.total_billing_quantity,
             so.CumulativeOrderQuantity_KWMENG = b.total_billing_quantity as is_item_order_qty_equal_billing_qty,
             min(so.CumulativeOrderQuantity_KWMENG = b.total_billing_quantity) over (partition by so.Client_MANDT, so.SalesDocument_VBELN) as is_order_qty_equal_billing_qty

      from `thjennifer3.CORTEX_SAP_REPORTING.SalesOrders_V2` so
      inner join
          (select  Client_MANDT
             ,SalesDocument_AUBEL
             ,SalesDocumentItem_AUPOS
             ,sum(ActualBilledQuantity_FKIMG) as total_billing_quantity
          from `thjennifer3.CORTEX_SAP_REPORTING.Billing`
          where BillingType_FKART in ('F1','F2')
          and BillingDocumentIsCancelled_FKSTO is null
          group by 1,2,3) b

            on so.Client_MANDT = b.Client_MANDT
            and so.SalesDocument_VBELN = b.SalesDocument_AUBEL
            and so.Item_POSNR = b.SalesDocumentItem_AUPOS ;;
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

  dimension: total_billing_quantity {
    type: number
    sql: ${TABLE}.total_billing_quantity ;;
  }

  dimension: is_item_order_qty_equal_billing_qty {
    type: yesno
    sql: ${TABLE}.is_item_order_qty_equal_billing_qty ;;
  }

  dimension: is_order_qty_equal_billing_qty {
    type: yesno
    sql: ${TABLE}.is_order_qty_equal_billing_qty ;;
  }


}
