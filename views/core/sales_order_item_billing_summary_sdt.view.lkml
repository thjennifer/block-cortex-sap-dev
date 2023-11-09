view: sales_order_item_billing_summary_sdt {
  fields_hidden_by_default: yes
  derived_table: {
    sql: select so.Client_MANDT,
             so.SalesDocument_VBELN,
             so.Item_POSNR,
             so.CumulativeOrderQuantity_KWMENG,
             b.billing_quantity,
             so.CumulativeOrderQuantity_KWMENG = coalesce(b.billing_quantity,0) as is_item_order_and_billing_quantity_equal,
             min(so.CumulativeOrderQuantity_KWMENG =  coalesce(b.billing_quantity,0)) over (partition by so.Client_MANDT, so.SalesDocument_VBELN) as is_order_and_billing_quantity_equal

      from `thjennifer3.CORTEX_SAP_REPORTING.SalesOrders_V2` so
      left join
          (select  Client_MANDT
             ,SalesDocument_AUBEL
             ,SalesDocumentItem_AUPOS
             ,sum(ActualBilledQuantity_FKIMG) as billing_quantity
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

  dimension: billing_quantity {
    hidden: no
    type: number
    sql: ${TABLE}.billing_quantity ;;
  }

  dimension: is_item_order_and_billing_quantity_equal {
    type: yesno
    sql: ${TABLE}.is_item_order_and_billing_quantity_equal ;;
  }

  dimension: is_order_and_billing_quantity_equal {
    hidden: no
    type: yesno
    sql: ${TABLE}.is_order_and_billing_quantity_equal ;;
  }

  measure: total_quantity_billed {
    hidden: no
    type: sum
    sql: ${billing_quantity} ;;
  }


}
