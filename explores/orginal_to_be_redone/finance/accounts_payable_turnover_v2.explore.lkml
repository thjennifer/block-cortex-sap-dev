include: "/views/original_to_be_redone/**/*.view"

explore: accounts_payable_turnover_v2 {

  sql_always_where: ${accounts_payable_turnover_v2.client_mandt} = '{{ _user_attributes['client_id_rep'] }}' ;;
}