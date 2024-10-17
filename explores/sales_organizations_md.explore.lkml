include: "/views/core/sales_organizations_md_rfn.view"
include: "/views/core/sales_orders_v2_rfn.view"

explore: sales_organizations_md {
  label: "Sales Organizations"

  sql_always_where: ${language_spras} = @{user_language} AND ${client_mandt} = '@{CLIENT_ID}';;

  # always_join: [sales_orders_v2]

  # join: sales_orders_v2 {
  #   type: inner
  #   relationship: one_to_many
  #   sql_on: ${sales_organizations_md.client_mandt} = ${sales_orders_v2.client_mandt} AND
  #           ${sales_organizations_md.sales_org_vkorg} = ${sales_orders_v2.sales_organization_vkorg} ;;
  #   fields: []
  # }


}