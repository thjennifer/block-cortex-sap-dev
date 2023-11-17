include: "/zBlock_v1/views/**/*.view"

explore: accounts_payable_overview_v2 {

  sql_always_where: ${accounts_payable_overview_v2.client_mandt} =  '{{ _user_attributes['client_id_rep'] }}' ;;
}
