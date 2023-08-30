connection: "@{CONNECTION_NAME}"

include: "/components/**/*.lkml"
include: "/views/core/**/*.view"
include: "/explores/*.explore"
# include: "/dashboards/**/*.dashboard"




persist_with: cortex_default_datagroup



explore: currency_conversion_sdt {hidden: yes}
