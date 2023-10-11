
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
