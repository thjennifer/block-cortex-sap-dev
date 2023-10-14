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

constant: DEFAULT_DATE_FILTER {
  value: "{% if @{USE_DEMO_DATA} =='Yes' %}{% assign date_range = '2022/01/01 to 2022/03/22' %}
          {% else %} {% assign date_range = 'last 1 year' %}
          {% endif %}{{date_range}}"
}
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
