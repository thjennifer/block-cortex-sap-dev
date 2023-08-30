include: "/views/core_org_to_be_redone/**/*.view"

explore: cash_discount_utilization {
  sql_always_where: ${client_mandt} = '{{ _user_attributes['client_id_rep'] }}';;
}