include: "/views/core/billing_rfn.view"

view: +billing {

dimension: test_field_name {
  hidden: no
  view_label: "TEST STUFF"
sql: {%- assign show = _user_attributes['cortex_sap_show_original_sap_field_name'] | upcase -%}
  {%- assign sap_code = _field._name | split:'_' | last -%}
  {%- assign fname = _field._name | split: '.' | last | remove: sap_code -%}
  {%- assign fname_array = fname | split: '_' -%}
  {%- for word in fname_array -%}
    {%- assign cap = word | capitalize -%}
    {%- assign field_name = field_name | append: cap -%}
    {%- unless forloop.last -%}{%- assign field_name = field_name | append: ' ' -%}{%- endunless -%}
  {%- endfor -%}
  {%- if show == 'YES' -%}
    {%- assign sap_code = sap_code | upcase | prepend: ' ' -%}
    {%- assign field_name = field_name | append: sap_code -%}
  {%- endif -%}
  '{{ show }}' ;;
}
  }