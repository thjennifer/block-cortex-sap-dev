view: across_sales_and_md_lookups_xvw {

  dimension: customer_name  {
    hidden: no
    label: "{%- if _explore._name == 'sales_orders_v2' -%}Sold to Party Name{%- else -%}Customer Name{%- endif -%}"
    description: "Customer Name (name1)"
    sql: COALESCE(${customers_md.customer_name},CONCAT('Sold to Party: ',${sales_orders_v2.sold_to_party_kunnr})) ;;
  }

#--> cross reference
  dimension: selected_product_dimension_description {
    hidden: no
    # group_label: "Item Categories & Descriptions"
    label: "{%- if _field._is_selected -%}
              {%- if sales_orders_v2.parameter_display_product_level._parameter_value == 'Item' -%}Material Text{%- else -%}Division{%- endif -%}
            {%- else -%}Selected Product Dimension Description
            {%- endif -%}"
    description: "Values are either Material Text or Division Description based on user selection for Parameter Display Product Level"
    sql: {% if sales_orders_v2.parameter_display_product_level._parameter_value == 'Item' %}${materials_md.material_text_maktx}{%else%}${divisions_md.division_name_vtext}{%endif%} ;;
    can_filter: yes
  }

  }
