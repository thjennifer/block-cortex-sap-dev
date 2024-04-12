include: "/views/base/sales_order_header_status.view"
view: +sales_order_header_status {

label: "Sales Order"
fields_hidden_by_default: yes

  dimension: key {
    primary_key: yes
    sql: CONCAT(${client_mandt},${sales_document_vbeln}) ;;
  }

  dimension: overall_processing_status_gbstk {
    label: "Overall Processing Status GBSTK"
    description: "Overall Processing Status"
    hidden: no
    case: {
      when: {
        sql: ${TABLE}.OverallProcessingStatus_GBSTK = "C" ;;
        label: "Completely Processed"
      }
      when: {
        sql: ${TABLE}.OverallProcessingStatus_GBSTK = "B" ;;
        label: "Partially Processed"
      }
      when: {
        sql: ${TABLE}.OverallProcessingStatus_GBSTK = "A" ;;
        label: "Not Processed"
      }
    }
  }

  measure: count_distinct_vbeln {
    type: count_distinct
    sql: ${sales_document_vbeln} ;;
  }

 }
