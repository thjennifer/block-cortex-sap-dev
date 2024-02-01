include: "/zBlock_v1/views/**/*.view"

explore: inventory_by_plant {
  sql_always_where: ${inventory_by_plant.client_mandt} = '{{ _user_attributes['client_id_rep'] }}'
        and ${language_map.looker_locale}='{{ _user_attributes['locale'] }}'
    ;;

  join: language_map {
    fields: []
    type: left_outer
    sql_on: ${inventory_by_plant.language_spras} = ${language_map.language_key} ;;
    relationship: many_to_one
  }
}
