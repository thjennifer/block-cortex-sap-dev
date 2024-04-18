constant: CONNECTION_NAME {
  value: "qa-thjennifer3"
  export: override_required
}

constant: GCP_PROJECT_ID {
  value: "thjennifer3"
  export: override_required
}

constant: REPORTING_DATASET {
  value: "CORTEX_SAP_REPORTING"
  export: override_required
}

constant: CLIENT_ID {
  value: "100"
  export: override_required
}

constant: USE_DEMO_DATA {
  value: "Yes"
  export: override_required
}

# Revenue is generally displayed in general ledger as a negative number, which indicates a credit.
# By setting Sign Change value to 'yes', it's displayed as a positive number in income statement reports.
constant: SIGN_CHANGE {
  value: "yes"
  export: override_required
}

#############################
# Additional Constants used for formatting and other logic
#{

# Constant negative_format
# shows negative values in red, at this constant to the html: parameter
# example use:
#   measure: profit {
#     type: number
#     sql: ${total_sales} - ${total_cost} ;;
#     html: @{negative_format} ;;
#     }

constant: negative_format {
  value: "{% if value < 0 %}<p style='color:red;'>{{rendered_value}}</p>{% else %} {{rendered_value}} {% endif %}"
}

# Constant sign_change_multiplier
# derives multiplier of 1 or -1 based on value entered for SIGN_CHANGE constant
# example use:
#   dimension: amount_in_local_currency {
#     hidden: yes
#     sql: @{sign_change_multiplier}
#         ${TABLE}.AmountInLocalCurrency * {{multiplier}} ;;
#     }
#
constant: sign_change_multiplier {
  value: "{% assign choice = '@{SIGN_CHANGE}' | downcase %}
  {% if choice == 'yes' %}{% assign multiplier = -1 %}{% else %}{% assign multiplier = 1 %}{% endif %}"
}

# Constant derive_currency_label
# captures and formats selected Target Currency for use in 'labels' property
# example use:
#   measure: total_net_value_target {
#     type: sum
#     label: "@{derive_currency_label}Total Sales ({{currency}})"
#     sql: ${item_net_value_target_netwr} ;;
#     }
#
constant: derive_currency_label {
  value: "{% assign currency = currency_conversion_sdt.select_target_currency._parameter_value | remove: \"'\" %}"
}



#} end additional constants

#### constants for label formatting
constant: SAP_LABEL {
  value: "{% if _user_attributes['sap_show_labels'] == 'Yes' %}
            {% assign sap_label = _field._name | split:'_' | last | upcase %}
            {% else %}{% assign sap_label = '' %}
            {% endif %}{{sap_label}}"
}

constant: DASHBOARD_LOGO {
  value: "https://marketplace-api.looker.com/block-icons/cortex_icon.png"
}

# constant: DEFAULT_DATE_FILTER {
#   value: "{% if @{USE_DEMO_DATA} =='Yes' %}{% assign date_range = '2022/01/01 to 2022/03/22' %}
#           {% else %} {% assign date_range = 'last 1 year' %}
#           {% endif %}{{date_range}}"
# }
#### testing
# liquid camelcase and capitalize doesn't work
# {% assign fn = _field._name | split:'.' %} {% assign field_name = fn[1] | split:'_' %}{% assign word_cnt = field_name.size %}
#             {% assign label_name = '' %}
#             {% for word in field_name %} {% assign label_name = label_name | append: ' ' | append: word | camelcase %}{%endfor%}
#             Sales Document {{label_name}}

###### old will be deprecated:
constant: GCP_PROJECT {
  value: "thjennifer3"
  export: override_required
}

constant: CLIENT {
  value: "100"
  export: override_required
}

#############################
# Additional Constants used for formatting and other logic
#{

# to show negative values in red, at this constant to the html: parameter
# For example:
#         measure: profit {
#            type: number
#            sql: ${total_sales} - ${total_cost} ;;
#            html: @{negative_format} ;;
#         }

constant: negative_format {
  value: "{% if value < 0 %}<p style='color:red;'>{{rendered_value}}</p>{% else %} {{rendered_value}} {% endif %}"
}

# enter the max number of fiscal periods in a fiscal year.
# used to derive previous previous period when 1st period is selected
constant: max_fiscal_period {
  value: "12"
  export: override_optional
}

# comparison period derived based on select_comparison_type parameter:
#     if yoy then subtract year from period
#     if prior then subtract 1 from period (if period = 01 or 001 then substract 1 year and use max_fiscal_period for period)
#     if custom then use value from select_custom_comparison_period
#     if none use ''
constant: derive_comparison_period {
  value: "{% assign comparison_type = select_comparison_type._parameter_value %}
          {% assign fp = select_fiscal_period._parameter_value %}
          {% assign cp = select_custom_comparison_period._parameter_value %}
          {% assign max_fp_size = '@{max_fiscal_period}' | remove_first: '0' | size | times: 1 %}
          {% assign max_fp_size_neg = max_fp_size | times: -1 %}
          {% assign pad = '' %}
          {% for i in (1..max_fp_size) %}
              {% assign pad = pad | append: '0' %}
          {% endfor %}
          {% if comparison_type == 'custom' %}
               {% if fp == cp %}{% assign comparison_type = 'none' %}
               {% elsif cp == '' %}{% assign comparison_type = 'yoy' %}
               {% endif %}
          {% endif %}

        {% if comparison_type == 'prior' or comparison_type == 'yoy' %}
            {% assign p_array = fp | split: '.' %}
                {% if comparison_type == 'prior' %}
                    {% if p_array[1] == '001' or p_array[1] == '01' %}
                        {% assign m = '@{max_fiscal_period}' %}{% assign sub_yr = 1 %}
                    {% else %}
                        {% assign m = p_array[1] | times: 1 | minus: 1 | prepend: pad | slice: max_fp_size_neg, max_fp_size %}{% assign sub_yr = 0 %}
                    {% endif %}
                {% else %}
                  {% assign m = p_array[1] %}{% assign sub_yr = 1 %}
                {% endif %}
            {% assign yr = p_array[0] | times: 1 | minus: sub_yr %}
            {% assign cp =  yr | append: '.'| append: m %}
        {% elsif comparison_type == 'none' %} {% assign cp = '' %}
        {% endif %}"
}

#} end additional constants