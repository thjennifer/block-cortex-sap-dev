include: "/views/core/sales_order_partner_function_sdt.view"
include: "/test/views/partner_function_tmp.view"

view: +sales_order_partner_function_sdt {

  derived_table: {
    sql:
      SELECT
        *
      FROM (
        SELECT
          t.client_MANDT,
          t.SalesDocument_VBELN,
          '000000' as Item_POSNR,
          CASE t.PartnerFunction_PARVW
            WHEN 'AG' THEN 'sold_to'
            WHEN 'RE' THEN 'bill_to'
            WHEN 'WE' THEN 'ship_to'
        END
          AS PartnerFunction_Label,
          ARRAY_TO_STRING(array_customer_name, ", ") AS customer_names
        FROM (
          SELECT
            pf.client_MANDT,
            pf.SalesDocument_VBELN,
            pf.PartnerFunction_PARVW,
            ARRAY_AGG(DISTINCT pf.Customer_KUNNR) AS array_customer_kunnr,
            ARRAY_AGG(DISTINCT COALESCE(c.name1_name1,pf.Customer_KUNNR)) AS array_customer_name
          FROM
            ${partner_function_tmp.SQL_TABLE_NAME} pf
          JOIN
            `@{GCP_PROJECT_ID}.@{REPORTING_DATASET}.CustomersMD` c
          ON
            pf.Client_MANDT = c.client_MANDT
            AND pf.Customer_KUNNR = c.CustomerNumber_KUNNR
          WHERE pf.Client_MANDT = '@{CLIENT_ID}'
          GROUP BY
            pf.client_MANDT,
            pf.SalesDocument_VBELN,
            pf.PartnerFunction_PARVW
            ) t ) c PIVOT(MAX(customer_names) customer_names FOR PartnerFunction_Label IN ('sold_to',
            'bill_to',
            'ship_to'))
      ;;
  }

   }
