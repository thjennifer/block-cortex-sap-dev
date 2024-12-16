connection: "@{CONNECTION_NAME}"

include: "/components/**/*.lkml"
include: "/explores/*.explore"
include: "/dashboards/*.dashboard"
# include: "/dashboards/finance/*.dashboard"
include: "/dashboards/finance/balance_*.dashboard"
include: "/dashboards/finance/income_*.dashboard"

label: "Cortex SAP Operational v2"


persist_with: cortex_sap_default_datagroup
