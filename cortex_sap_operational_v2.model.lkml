connection: "@{CONNECTION_NAME}"

include: "/components/**/*.lkml"
include: "/explores/*.explore"
include: "/dashboards/*.dashboard"
include: "/dashboards/finance/*.dashboard"

label: "Cortex SAP Operational v2"

persist_with: cortex_sap_default_datagroup
