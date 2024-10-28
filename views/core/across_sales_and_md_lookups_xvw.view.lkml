view: across_sales_and_md_lookups_xvw {

  dimension: customer_name  {
    hidden: no
    label: "{%- if _explore._name == 'sales_orders_v2' -%}Sold to Party Name{%- else -%}Customer Name{%- endif -%}"
    description: "Customer Name (name1)"
    sql: COALESCE(${customers_md.customer_name},CONCAT('Sold to Party: ',${sales_orders_v2.sold_to_party_kunnr})) ;;
  }





  }
