include: "/views/base/sales_organizations_md.view"

view: +sales_organizations_md {
  fields_hidden_by_default: yes

  dimension: key {
    primary_key: yes
    sql: concat(${client_mandt},${sales_org_vkorg},${language_spras} ;;
  }

  dimension: client_mandt {
    hidden: no
    label: "Client MANDT"
  }

  dimension: sales_org_vkorg {
    hidden: no
    label: "Sales Org VKORG"
  }

  dimension: language_spras {
    hidden: no
    label: "Language SPRAS"
  }

  dimension: sales_org_name_vtext {
    hidden: no
    label: "Sales Org Name VTEXT"
  }

 }
