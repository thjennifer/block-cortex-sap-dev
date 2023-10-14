######################
# use this template to generate an html navigation bar or tabs
# this template can only be extended into another view
#
# this template provides two styles and up to 5 possible filters:
#       horizontal table with gray background (see dimension navigation_bar)
#       tabbed (see dimension navigation_tabbed)
#
# modify this template if you want different styles or more filters
#
# extend this template into a view and customize for:
#     list of dashboards (ids and names)
#     list of filters (filter1, filter2, etc... with name used in dashboard filters)
#
# To use:
#   - create new view
#   - add extend: parameter and reference this view (navigation_template)
#   - required updates:
#       - edit the sql: parameter of dashBindings dimension with list of dashboard ids and names following this format:
#             sql: '131|Dashboard 1||132|Dashboard 2' ;;
#
#       - edit the sql: parameter of filterBindings dimension with list of filters that should be passed from one dashboard to another
#             sql: 'filter1|Filter 1 Name||filter2|Filter 2 Name' ;;
#
#       - edit filter1 to filterN (up to 5) to unhide and label
#
#   - optional updates:
#       - change itemDelimiter (||) and valueDelimiter (|) to match delimiters used in Bindings dimensions
######################

view: navigation_template {
  extension: required
  ########################################
  ###### Fields *requiring override* in extension
  ########################################

  dimension: dashBindings {
    hidden: yes
    type: string
    sql: '131|Dashboard 1||132|Dashboard 2' ;;
  }

  dimension: filterBindings {
    hidden: yes
    type: string
    sql: 'filter1|Filter 1 Name||filter1|Filter 2 Name' ;;
  }

  # ** override hidden and label in extension as required **
  # ** Add more as required, currently supports 5 **
  filter: filter1 { hidden: yes label: "filter1" }
  filter: filter2 { hidden: yes label: "filter2" }
  filter: filter3 { hidden: yes label: "filter3" }
  filter: filter4 { hidden: yes label: "filter4" }
  filter: filter5 { hidden: yes label: "filter5" }

  ########################################
  ###### Fields *optionally overriden* in extension
  ########################################

  dimension: itemDelimiter {
    hidden: yes
    type: string
    sql: '||' ;;
  }

  dimension: valueDelimiter {
    hidden: yes
    type: string
    sql: '|' ;;
  }


  # use parameter to set focus page until bug with _explore._dashboard_url is fixed
  # update allowed values to match number of dashboards defined in extension
  parameter: focus_page {
    hidden: no
    type: unquoted
    allowed_value: {value:"1"}
    allowed_value: {value:"2"}
    allowed_value: {value:"3"}
    default_value: "1"
  }

  ########################################
  ###### Navbar definition
  ########################################

  dimension: navigation_bar {
    description: "Derives horizontal bar with gray background and html links to select Dashboards including filter selections"
    type: string
    hidden: no
    sql: '' ;;
    html:
      <!-- initial splits -->
      {% assign navItems = dashBindings._value | split: itemDelimiter._value %}
      {% assign filterItems = filterBindings._value | split: itemDelimiter._value %}

      <!-- initialize counter, focus and queryString -->
      {% assign counter = 1 %}
      {% assign focus = focus_page._parameter_value | times: 1 %}
      {% assign queryString = "" %}

      <!-- loop through filterItems defined in filterBindings dimension to create queryString used in dashboard url-->
      {% for filterItem in filterItems %}
          <!-- split filter into parts -->
          {% assign filterParts = filterItem | split: valueDelimiter._value %}
          {% assign filterField = filterParts[0] %} <!-- for readability -->
          {% assign filterName = filterParts[1] %} <!-- for readability -->

          <!-- case on filter, because we can't mix value interpolation into logic evaluation -->
          <!-- for example, this will not work: {% assign filterValue = _filters['{{ filter }}'] %} -->
          <!-- ** Add more cases for more filters ** -->
          {% case filterField %}
              {% when "filter1" %}
                {% assign filterValue = _filters['filter1'] %}
              {% when "filter2" %}
                {% assign filterValue = _filters['filter2'] %}
              {% when "filter3" %}
                {% assign filterValue = _filters['filter3'] %}
              {% when "filter4" %}
                {% assign filterValue = _filters['filter4'] %}
              {% when "filter5" %}
                {% assign filterValue = _filters['filter5'] %}
          {% else %}
                {% assign filterValue = "out of range filter" %}
          <!-- if you see this value, you've added more filters than supported in filterBindings -->
          {% endcase %}

      <!-- create individual filterString -->
      {% assign filterString = filterName | append: "=" | append: filterValue %}

      <!-- tack individual filterString onto end of queryString -->
      {% assign queryString = queryString | append: filterString | append: '&' %}
      {% endfor %}

      <!-- begin HTML - probably want to edit styles as needed -->
      <!-- note: it may be worth making styles part of the dimensional configuration -->
      <center>
      <div style="border-radius: 5px; padding-top: 8px; padding-bottom: 20px; height: 60px; background: #F5F5F5;">
      <span style="font-size: 18px; display: table; margin:0 auto;">
      <img style="float: left; vertical-align: middle; height: 39px;" src="@{DASHBOARD_LOGO}"/>

      <!-- Loop through navigation items as defined in dashBindings dimension-->
      {% for navItem in navItems %}

          {% assign navParts = navItem | split: valueDelimiter._value %}
          {% assign dashName = navParts[1] %}
          {% assign dashUrl = "/dashboards/" | append: navParts[0] %}

          <!-- establish link style -->
          {% assign linkStyle = "color: #0059D6; padding: 5px 15px; float: left; line-height: 40px;" %}
          {% assign currentPageLinkStyle = linkStyle | append: "font-weight:bold;font-size: 20px;" %}

          <!-- build links -->
          {% if focus_page._in_query and counter == focus %}
              <span style="{{ currentPageLinkStyle }}">{{ dashName }}</span>
          {% elsif _explore._dashboard_url == dashUrl %}
              <span style="{{ currentPageLinkStyle }}">{{ dashName }}</span>
          {% else %}
              <a style="{{ linkStyle }}" href="{{ dashUrl }}?{{ queryString }}">{{ dashName }}</a>
          {% endif %}

          <!-- increment counter by 1 -->
          {% assign counter = counter | plus: 1 %}
      {% endfor %}

      </span>
      </div>


      <!-- NOTE: There's a bug in _explore._dashboard_url liquid implementation -->
      {% if focus_page._in_query == false %}
      <div>
      <span style="font-size: 10px;">{{ _explore._dashboard_url }} - clear cache & refresh to see active page html link in bold</span>
      </div>
      {% endif %}
      </center>
      ;;
  }
  }
