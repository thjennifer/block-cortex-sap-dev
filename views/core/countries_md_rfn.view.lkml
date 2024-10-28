include: "/views/base/countries_md.view"

view: +countries_md {
  fields_hidden_by_default: yes

  dimension: key {
    hidden: yes
    primary_key: yes
    sql: concat(${client_mandt},${country_key_land1},${language_spras}) ;;
  }

  dimension: client_mandt {
    hidden: no
    label: "Client MANDT"
  }

  dimension: country_key_land1 {
    hidden: no
    label: "@{label_field_name}"
    description: "Country (2-character abbreviation)"
  }

  dimension: country_name_landx {
    hidden: no
    label: "{% if _explore._name == 'sales_orders_v2' %}Sold to Party Region{%else%}Country Name{%endif%} @{label_append_sap_code}"
    # full_suggestions: yes
    # suggest_persist_for: "5 minutes"
  }

  dimension: language_spras {
    hidden: no
  }

  }
