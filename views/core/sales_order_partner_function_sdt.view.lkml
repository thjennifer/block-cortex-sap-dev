######################
# derives list of sold_to, ship_to and bill_to customers for an Order
#
#
# once finished testing REPLACE references to partner_function_tmp.SQL_TABLE_NAME
#  with `@{GCP_PROJECT_ID}.@{REPORTING_DATASET}.SalesOrderPartnerFunction`
######################

view: sales_order_partner_function_sdt {

  fields_hidden_by_default: yes

  derived_table: {
    sql:
      SELECT
        *
      FROM (
        SELECT
          t.client_MANDT,
          t.SalesDocument_VBELN,
          t.Item_POSNR,
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
            '000000' AS Item_POSNR,
            pf.PartnerFunction_PARVW,
            ARRAY_AGG(DISTINCT pf.Customer_KUNNR) AS array_customer_kunnr,
            ARRAY_AGG(DISTINCT COALESCE(c.name1_name1,pf.Customer_KUNNR)) AS array_customer_name
          FROM
            ${partner_function_tmp.SQL_TABLE_NAME} pf
          JOIN
            `thjennifer3.CORTEX_SAP_REPORTING.CustomersMD` c
          ON
            pf.Client_MANDT = c.client_MANDT
            AND pf.Customer_KUNNR = c.CustomerNumber_KUNNR
          GROUP BY
            1,
            2,
            3,
            4 ) t ) c PIVOT(MAX(customer_names) customer_names FOR PartnerFunction_Label IN ('sold_to',
            'bill_to',
            'ship_to'))
      ;;
  }

  dimension: key {
    type: string
    primary_key: yes
    sql: concat(${client_mandt},${sales_document_vbeln}) ;;
  }

  dimension: client_mandt {
    type: string
    sql: ${TABLE}.client_MANDT ;;
  }

  dimension: sales_document_vbeln {
    type: string
    sql: ${TABLE}.SalesDocument_VBELN ;;
  }

  dimension: item_posnr {
    type: string
    sql: ${TABLE}.Item_POSNR ;;
  }

  dimension: customer_names_sold_to {
    type: string
    sql: ${TABLE}.customer_names_sold_to ;;
  }

  dimension: customer_names_bill_to {
    type: string
    sql: ${TABLE}.customer_names_bill_to ;;
  }

  dimension: customer_names_ship_to {
    type: string
    sql: ${TABLE}.customer_names_ship_to ;;
  }


}
