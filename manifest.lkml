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


constant: EXCHANGE_RATE_TYPE {
  value: "M"
  export: override_required
}


#### constants for label formatting
constant: SAP_LABEL {
  value: "{% if _user_attributes['sap_show_labels'] == 'Yes' %}
            {% assign sap_label = _field._name | split:'_' | last | upcase %}
            {% else %}{% assign sap_label = '' %}
            {% endif %}{{sap_label}}"
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
