connection: "@{CONNECTION_NAME}"

include: "/components/**/*.lkml"
include: "/explores/*.explore"
include: "/dashboards/*.dashboard"
# include: "/dashboards/finance/*.dashboard"
include: "/dashboards/finance/balance_*.dashboard"
include: "/dashboards/finance/income_*.dashboard"

label: "Cortex SAP Operational v2"


persist_with: cortex_sap_default_datagroup



# explore: currency_conversion_sdt {hidden: yes}
# explore: language_map_sdt {hidden:yes}
# explore: billing {
#   hidden: yes
# }


# include: "/views/core/sales_order_header_status_rfn.view"
# explore: sales_order_header_status {}
