include: "/views/core_org_to_be_redone/*.view"

explore: inventory_metrics_overview {
  sql_always_where: ${inventory_metrics_overview.client_mandt} = '{{ _user_attributes['client_id_rep'] }}'
    and ${language_map.looker_locale}='{{ _user_attributes['locale'] }}';;

  join: inventory_by_plant {
    type: left_outer
    relationship: many_to_one
    fields: [inventory_by_plant.stock_characteristic]
    sql_on: ${inventory_by_plant.client_mandt} = ${inventory_metrics_overview.client_mandt}
      and ${inventory_by_plant.company_code_bukrs} = ${inventory_metrics_overview.company_code_bukrs}
    ;;
  }

  join: language_map {
    fields: []
    type: left_outer
    sql_on: ${inventory_metrics_overview.language_spras} = ${language_map.language_key} ;;
    relationship: many_to_one
  }
}