######################
# temporary view that adds fake partner data at item level for VBELN '0000006550'
# to allow for testing
#
# will be only referenced in partner_function_sdt view temporarily
######################

view: partner_function_tmp {
  derived_table: {
    sql: select '100' as client_MANDT,
             '0000006550' as SalesDocument_VBELN,
             '000020' as Item_POSNR,
             'RE' as PartnerFunction_PARVW,
             '0001000000' as Customer_KUNNR
      union all
      select '100' as client_MANDT,
             '0000006550' as SalesDocument_VBELN,
             '000020' as Item_POSNR,
             'RE' as PartnerFunction_PARVW,
             '0001000002' as Customer_KUNNR
      union all
      select '100',
              '0000006550',
              '000010' as Item_POSNR,
               'RE' as PartnerFunction_PARVW,
               '0001000040' as Customer_KUNNOR
      union all
      select '100',
              '0000006550',
              '000000' as Item_POSNR,
               'AG' as PartnerFunction_PARVW,
               '0001000040' as Customer_KUNNOR
      union all
      select '100',
              '0000006550',
              '000000' as Item_POSNR,
               'AG' as PartnerFunction_PARVW,
               '0001000000' as Customer_KUNNOR
      union all
      select '100' as client_MANDT,
             '0000006550' as SalesDocument_VBELN,
             '000020' as Item_POSNR,
             'WE' as PartnerFunction_PARVW,
             '0001000000' as Customer_KUNNR
      union all
      select '100',
              '0000006550',
              '000010' as Item_POSNR,
               'WE' as PartnerFunction_PARVW,
               '0001000001' as Customer_KUNNOR
      union all
      select Client_MANDT,
             SalesDocument_VBELN,
             Item_POSNR,
             PartnerFunction_PARVW,
             Customer_KUNNR
      from `@{GCP_PROJECT_ID}.@{REPORTING_DATASET}.SalesOrderPartnerFunction`
      where SalesDocument_VBELN <> '0000006550' ;;
  }

}
