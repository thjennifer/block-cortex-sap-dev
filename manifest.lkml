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

constant: otc_shared_filters {
  value: "sales_orders_v2.creation_date_erdat_date|Order Date||divisions_md.division_name_vtext|Division||countries_md.country_name_landx|Country||materials_md.material_text_maktx|Product||sales_organizations_md.sales_org_name_vtext|Sales Org||distribution_channels_md.distribution_channel_name_vtext|Distribution Channel||currency_conversion_sdt.select_target_currency|Target Currency"
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



constant: link_vis_table {
  value: "{% assign vis_config = '{\"type\":\"looker_grid\"}' | url_encode | prepend: '&vis_config=' %}"
}

constant: link_vis_column {
  value: "{% assign vis_config = '{\"type\":\"looker_column\"}' | url_encode | prepend: '&vis_config=' %}"
}

constant: link_vis_bar {
  value: "{% assign vis_config = '{\"type\":\"looker_bar\"}' | url_encode | prepend: '&vis_config=' %}"
}

constant: link_vis_area {
  value: "{% assign vis_config = '{\"type\":\"looker_area\"}' | url_encode | prepend: '&vis_config=' %}"
}

constant: link_vis_line {
  value: "{% assign vis_config = '{\"type\":\"looker_line\"}' | url_encode | prepend: '&vis_config=' %}"
}

constant: link_vis_map {
  value: "{% assign vis_config = '{\"type\":\"looker_map\"}' | url_encode | prepend: '&vis_config=' %}"
}

constant: link_vis_pie {
  value: "{% assign vis_config = '{\"type\":\"looker_pie\"}' | url_encode | prepend: '&vis_config=' %}"
}

constant: link_vis_single {
  value: "{% assign vis_config = '{\"type\":\"single_value\"}' | url_encode | prepend: '&vis_config=' %}"
}



constant: link_generate_variable_defaults {
  value: "
  {% comment %} Variables to default if not created {% endcomment %}

  {% comment %} User Customizable Parameters {% endcomment %}
  {% assign drill_fields = '' %}
  {% assign pivots = '' %}
  {% assign subtotals = '' %}
  {% assign sorts = '' %}
  {% assign limit = '500' %}
  {% assign column_limit = '50' %}
  {% assign total = '' %}
  {% assign row_total = '' %}
  {% assign query_timezone = '' %}
  {% assign dynamic_fields = '' %}

  {% comment %} Default Visualizations Parameters {% endcomment %}
  @{link_vis_table}

  {% comment %} Default Behavior Parameters {% endcomment %}
  {% assign default_filters_override = false %}
  {% assign default_filters = '' %}
  {% assign new_page = false %}
  {% assign different_explore = false %}
  {% assign target_model = '' %}
  {% assign target_explore = '' %}

  {% comment %} Variables to be built in code below {% endcomment %}
  {% assign filters_mapping = '' %}
  {% assign target_content_filters = '' %}
  {% assign target_default_content_filters = '' %}
  {% assign link_host = '' %}
  "
}

constant: link_host {
  #Could assign a user_attribute since it won't be used with the generator
  value: "{% assign link_host = 'https://cortexdev.cloud.looker.com' %}"
}

constant: link_extract_context {
  value: "
  {% assign filters_array = '' %}
  {% for parameter in link_query_parameters %}
    {% assign parameter_key = parameter | split:'=' | first %}
    {% assign parameter_value = parameter | split:'=' | last %}
    {% assign parameter_test = parameter_key | slice: 0,2 %}
    {% if parameter_test == 'f[' %} {% comment %} Link contains multiple parameters, need to test if filter {% endcomment %}
      {% if parameter_key != parameter_value %} {% comment %} Tests if the filter value is is filled in, if not it skips  {% endcomment %}
        {% assign parameter_key_size = parameter_key | size %}
        {% assign slice_start = 2 %}
        {% assign slice_end = parameter_key_size | minus: slice_start | minus: 1 %}
        {% assign parameter_key = parameter_key | slice: slice_start, slice_end %}
        {% assign parameter_clean = parameter_key | append:'|' |append: parameter_value %}
        {% assign filters_array =  filters_array | append: parameter_clean | append: ',' %}
      {% endif %}
    {% elsif parameter_key == 'dynamic_fields' %}
      {% assign dynamic_fields = parameter_value %}
    {% elsif parameter_key == 'query_timezone' %}
      {% assign query_timezone = parameter_value %}
    {% endif %}
  {% endfor %}
  {% assign size = filters_array | size | minus: 1 %}
  {% assign filters_array = filters_array | slice: 0, size %}
  "
}

constant: link_match_filters_to_destination {
  value: "
  {% assign filters_mapping = filters_mapping | split: '||' %}
  {% assign filters_array = filters_array | split: ',' %}
  {% assign filters_array_destination = '' %}

  {% for source_filter in filters_array %}
    {% assign source_filter_key = source_filter | split:'|' | first %}
    {% assign source_filter_value = source_filter | split:'|' | last %}

    {% for destination_filter in filters_mapping %} {% comment %} This will loop through the value pairs to determine if there is a match to the destination {% endcomment %}
      {% assign destination_filter_key = destination_filter | split:'|' | first %}
      {% assign destination_filter_value = destination_filter | split:'|' | last %}
      {% if source_filter_key == destination_filter_key %}
        {% assign parameter_clean = destination_filter_value | append:'|' | append: source_filter_value %}
        {% assign filters_array_destination =  filters_array_destination | append: parameter_clean | append:',' %}
      {% endif %}
    {% endfor %}
  {% endfor %}
  {% assign size = filters_array_destination | size | minus: 1 %}
  {% assign filters_array_destination = filters_array_destination | slice: 0, size %}
  "
}

constant: link_build_filter_string {
  value: "
  {% assign filter_string = '' %}
  {% assign filters_array_destination = filters_array_destination | split: ',' %}
  {% for filter in filters_array_destination %}
    {% assign filter_key = filter | split:'|' | first %}
    {% assign filter_value = filter | split:'|' | last %}

    {% if content == '/explore/' %}
      {% assign filter_compile = 'f[' | append: filter_key | append:']=' | append: filter_value %}
    {% else %}
      {% assign filter_value = filter_value | encode_url %}
      {% assign filter_compile = filter_key | append:'=' | append: filter_value %}
    {% endif %}

    {% assign filter_string = filter_string | append: filter_compile | append:'&' %}
  {% endfor %}
  {% assign size = filter_string | size | minus: 1 %}
  {% assign filter_string = filter_string | slice: 0, size %}
  "
}

constant: link_build_default_filter_string {
  value: "
  {% assign default_filter_string = '' %}
  {% assign default_filters = default_filters | split: ',' %}
  {% for filter in default_filters %}
    {% assign filter_key = filter | split:'=' | first %}
    {% assign filter_value = filter | split:'=' | last %}
    {% if content == '/explore/' %}
      {% assign filter_compile = 'f[' | append: filter_key | append:']=' | append: filter_value %}
    {% else %}
      {% assign filter_value = filter_value | encode_url %}
      {% assign filter_compile = filter_key | append:'=' | append: filter_value %}
    {% endif %}
    {% assign default_filter_string = default_filter_string | append: filter_compile | append:'&' %}
  {% endfor %}
  {% assign size = default_filter_string | size | minus: 1 %}
  {% assign default_filter_string = default_filter_string | slice: 0, size %}
  "
}


constant: link_generate_dashboard_url {
  value: "
  {% assign content = '/dashboards/' %}
  {% assign link_query = link | split: '?' | last %}
  {% assign link_query_parameters = link_query | split: '&' %}
  {% assign target_content_filters = '' %}
  {% assign link_host = '' %}

  {% if new_page %}
    @{link_host}
  {% endif %}

  @{link_extract_context}
  @{link_match_filters_to_destination}
  @{link_build_filter_string}

  {% if default_filters != '' %}
    @{link_build_default_filter_string}
  {% endif %}

  {% if default_filters_override == true and default_filters != '' %}
    {% assign target_content_filters = default_filter_string | append:'&' | append: filter_string %}
  {% elsif default_filters_override == false and default_filters != '' %}
    {% assign target_content_filters = filter_string | append:'&' | append: default_filter_string %}
  {% else %}
    {% assign target_content_filters = filter_string %}
  {% endif %}

  {% comment %} Builds final link to be presented in frontend {% endcomment %}
  {{ link_host | append:content | append:target_dashboard | append: '?' | append: target_content_filters }}
  "
}
