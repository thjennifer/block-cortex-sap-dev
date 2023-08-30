include: "/views/core_org_to_be_redone/**/*.view"

explore: days_payable_outstanding_v2 {
  sql_always_where: ${client_mandt} = '{{ _user_attributes['client_id_rep'] }}' ;;
}