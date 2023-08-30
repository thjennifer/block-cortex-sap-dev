include: "/views/core_org_to_be_redone/**/data_intelligence*.view"
include: "/views/core_org_to_be_redone/**/currency_conversion_new.view"

explore: data_intelligence_ar {
  sql_always_where: ${Client_ID} = "@{CLIENT}" ;;
  join: currency_conversion_new {
    type: left_outer
    relationship: one_to_many
    sql_on: ${data_intelligence_ar.Client_ID}=${currency_conversion_new.mandt}
          and ${data_intelligence_ar.Local_Currency_Key}=${currency_conversion_new.fcurr}
          and ${data_intelligence_ar.Posting_date} = ${currency_conversion_new.conv_date}
          and ${currency_conversion_new.kurst} = "M"
          and ${currency_conversion_new.tcurr} = {% parameter data_intelligence_ar.Currency_Required %};;
    fields: [] #this view used for currency convesion only so no fields need to be included in the explore
  }
}