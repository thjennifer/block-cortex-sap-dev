connection: "@{CONNECTION_NAME}"

include: "/components/**/*.lkml"
include: "/views/standard/**/*.view"
include: "/explores/**/*.explore"
include: "/dashboards/**/*.dashboard"




persist_with: cortex_default_datagroup
