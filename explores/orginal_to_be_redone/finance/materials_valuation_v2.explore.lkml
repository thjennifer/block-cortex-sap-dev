include: "/views/original_to_be_redone/**/*.view"

explore: materials_valuation_v2 {
  sql_always_where: ${client_mandt} = '{{ _user_attributes['client_id_rep'] }}' ;;
}