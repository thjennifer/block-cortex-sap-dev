
datagroup: cortex_default_datagroup {
  max_cache_age: "1 hour"
}

datagroup: one_time {
  # pdt will be create when initially called but not updated again
  sql_trigger: select 1 ;;
  description: "Triggered only one time"
}

datagroup: monthly_on_day_1 {
  sql_trigger: select extract(month from current_date) ;;
  description: "Triggers on first day of the month"
}

datagroup: balance_sheet_node_count {
  sql_trigger:
  SELECT COUNT(0)
  FROM (
       SELECT
          Client,
          ChartOfAccounts,
          HierarchyName,
          Level,
          Node
        FROM
          `@{GCP_PROJECT_ID}.@{REPORTING_DATASET}.BalanceSheet`
        GROUP BY
          1, 2, 3, 4, 5) t ;;

  description: "Triggered when the Number of Distinct Client, Chart of Accounts, HierarchyName, Level and Nodes changes"
}

datagroup: profit_and_loss_node_count {
  sql_trigger:
  SELECT COUNT(0)
  FROM (
       SELECT
          Client,
          ChartOfAccounts,
          GLHierarchy,
          GLLevel,
          GLNode
        FROM
          `@{GCP_PROJECT_ID}.@{REPORTING_DATASET}.ProfitAndLoss`
        GROUP BY
          1, 2, 3, 4, 5) t ;;

  description: "Triggered when the Number of Distinct Client, Chart of Accounts, GLHierarchy, GLLevel and GLNodes changes"
}