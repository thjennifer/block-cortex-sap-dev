include: "/views/core/distribution_channels_md_rfn.view"
include: "/views/core/sales_orders_v2_rfn.view"

explore: distribution_channels_md {
  label: "Distribution Channels"

  sql_always_where: ${language_spras} = @{user_language} AND ${client_mandt} = '@{CLIENT_ID}';;

  # always_join: [sales_orders_v2]

  # join: sales_orders_v2 {
  #   type: inner
  #   relationship: one_to_many
  #   sql_on: ${distribution_channels_md.client_mandt} = ${sales_orders_v2.client_mandt} AND
  #           ${distribution_channels_md.distribution_channel_vtweg} = ${sales_orders_v2.distribution_channel_vtweg} ;;
  #   fields: []
  # }


}