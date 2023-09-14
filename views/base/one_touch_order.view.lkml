view: one_touch_order {
  sql_table_name: `thjennifer3.CORTEX_SAP_REPORTING.OneTouchOrder` ;;

  dimension: actual_billed_quantity_fkimg {
    type: number
    sql: ${TABLE}.ActualBilledQuantity_FKIMG ;;
  }
  dimension: one_touch_order_count {
    type: number
    sql: ${TABLE}.OneTouchOrderCount ;;
  }
  dimension: vbapclient_mandt {
    type: string
    sql: ${TABLE}.VBAPClient_MANDT ;;
  }
  dimension: vbapsales_document_item_posnr {
    type: string
    sql: ${TABLE}.VBAPSalesDocument_Item_POSNR ;;
  }
  dimension: vbapsales_document_vbeln {
    type: string
    sql: ${TABLE}.VBAPSalesDocument_VBELN ;;
  }
  dimension: vbaptotal_order_kwmeng {
    type: number
    sql: ${TABLE}.VBAPTotalOrder_KWMENG ;;
  }
  measure: count {
    type: count
  }
}
