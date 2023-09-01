view: distribution_channels_md {
  sql_table_name: `thjennifer3.CORTEX_SAP_REPORTING.DistributionChannelsMD` ;;

  dimension: client_mandt {
    type: string
    sql: ${TABLE}.Client_MANDT ;;
  }
  dimension: distribution_channel_name_vtext {
    type: string
    sql: ${TABLE}.DistributionChannelName_VTEXT ;;
  }
  dimension: distribution_channel_vtweg {
    type: string
    sql: ${TABLE}.DistributionChannel_VTWEG ;;
  }
  dimension: language_spras {
    type: string
    sql: ${TABLE}.Language_SPRAS ;;
  }
  measure: count {
    type: count
  }
}
