######################
# use this template to generate an html navigation bar or tabs
# this template can only be extended into another view
#
# this template provides two styles and up to 10 possible filters:
#       horizontal table with gray background (set with parameter navigation_style = "bar")
#       tabbed (set with parameter navigation_style = "tabs")
#
# modify this template if you want different styles or more filters
#
# extend this template into a view and customize for:
#     list of dashboards (ids and names)
#     list of filters (filter1, filter2, etc... with label used in dashboard filters)
#
# To extend this template:
#   - create new view
#   - add extend: parameter and reference this view (navigation_template)
#   - required updates:
#       - edit the sql: parameter of dashBindings dimension with list of dashboard ids and names:
#             for udd dashboards use numeric id:
#                 sql: '131|Dashboard 1||132|Dashboard 2' ;;
#
#             for lookml dashboards use lookml dashboard name with or without model name:
#                 sql: 'dashboard_name1|Dashboard 1||dashboard_name2|Dashboard 2';;
#                 sql: 'model_name::dashboard_name1|Dashboard 1||model_name::dashboard_name2|Dashboard 2';;
#
#       - edit the sql: parameter of filterBindings dimension with list of filters that should be passed from one dashboard to another
#             sql: 'filter1|Filter 1 Name||filter2|Filter 2 Name' ;;
#
#       - edit filter1 to filterN (up to 10) to unhide and label
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
  filter: filter6 { hidden: yes label: "filter6" }
  filter: filter7 { hidden: yes label: "filter7" }
  filter: filter8 { hidden: yes label: "filter8" }
  filter: filter9 { hidden: yes label: "filter9" }
  filter: filter10 { hidden: yes label: "filter10" }

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

  # use parameter to choose navigation style
  parameter: navigation_style {
    hidden: no
    type: unquoted
    allowed_value: {value: "bar"}
    allowed_value: {value: "tabs"}
    default_value: "tabs"
  }


  # use parameter to set focus page until bug with _explore._dashboard_url is fixed
  # update allowed values to match number of dashboards defined in extension
  parameter: navigation_focus_page {
    hidden: no
    description: "Used in dashboard navigation to set focus on selected dashboard page"
    type: unquoted
    allowed_value: {value:"1"}
    allowed_value: {value:"2"}
    allowed_value: {value:"3"}
    allowed_value: {value:"4"}
    allowed_value: {value:"5"}
    default_value: "1"
  }

  ########################################
  ###### Navbar definition
  ########################################

  dimension: navigation {
    type: string
    hidden: no
    sql: '' ;;
    html:
     <!-- initial splits -->
      {% assign navItems = dashBindings._value | split: itemDelimiter._value %}
      {% assign filterItems = filterBindings._value | split: itemDelimiter._value %}

      <!-- initialize variables -->
      {% assign counter = 1 %}
      {% assign navStyle = navigation_style._parameter_value %}
      {% assign focus = navigation_focus_page._parameter_value | times: 1 %}
      {% assign queryString = "" %}
      {% assign modelName = _model._name %}

      <!-- establish link, div and span styles based on navigation_style parameter -->
      {% case navStyle %}
          {% when "bar" %}
              {% assign linkStyle = "color: #0059D6; padding: 5px 15px; float: left; line-height: 40px;" %}
              {% assign currentPageLinkStyle = linkStyle | append: "font-weight:bold;font-size: 20px;" %}
              {% assign divStyle = "border-radius: 5px; padding-top: 6px; padding-bottom: 20px; height: 60px; background: #F5F5F5;" %}
              {% assign spanStyle = "font-size: 18px; display: table; margin:0 auto;" %}
              {% assign imgStyle = "float: left; vertical-align: middle; height: 45px;" %}
              {% assign imgSrc = "https://marketplace-api.looker.com/block-icons/cortex_icon.png" %}
          {% when "tabs" %}
              {% assign sharedStyle = "font-color: #4285F4; padding: 5px 15px; border-style: solid; border-radius: 5px 5px 0 0; float: left; line-height: 20px; "%}
              {% assign linkStyle = sharedStyle | append: "border-width: 1px; border-color: #D3D3D3;" %}
              {% assign currentPageLinkStyle = sharedStyle | append: "border-width: 2px; border-color: #808080 #808080 #F5F5F5 #808080; font-weight: bold; background-color: #F5F5F5;" %}
              {% assign divStyle = "border-bottom: solid 2px #808080; padding: 6px 10px 5px 10px; height: 40px;" %}
              {% assign spanStyle = "font-size: 16px; padding: 6px 10px 0 10px; height: 40px;" %}
              {% assign imgStyle = "float: left; vertical-align: middle; height: 39px;" %}
              {% assign imgSrc = "https://marketplace-api.looker.com/block-icons/cortex_icon.png" %}
      {% endcase %}


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
                {% assign filterValue = _filters['filter1'] | url_encode %}
              {% when "filter2" %}
                {% assign filterValue = _filters['filter2'] | url_encode %}
              {% when "filter3" %}
                {% assign filterValue = _filters['filter3'] | url_encode %}
              {% when "filter4" %}
                {% assign filterValue = _filters['filter4'] | url_encode %}
              {% when "filter5" %}
                {% assign filterValue = _filters['filter5'] | url_encode %}
              {% when "filter6" %}
                {% assign filterValue = _filters['filter6'] | url_encode %}
              {% when "filter7" %}
                {% assign filterValue = _filters['filter7'] | url_encode %}
              {% when "filter8" %}
                {% assign filterValue = _filters['filter8'] | url_encode %}
              {% when "filter9" %}
                {% assign filterValue = _filters['filter9'] | url_encode %}
              {% when "filter10" %}
                {% assign filterValue = _filters['filter10'] | url_encode %}
          {% else %}
                {% assign filterValue = "out of range filter" %}
          <!-- if you see this value, you've added more filters than supported in filterBindings -->
          {% endcase %}

      <!-- create individual filterString -->
      {% assign filterString = filterName | append: "=" | append: filterValue %}

      <!-- tack individual filterString onto end of queryString -->
      {% assign queryString = queryString | append: filterString | append: '&' %}

      {% endfor %}


       <!-- begin HTML -edit styles as needed -->
      <center>
      <div style="{{ divStyle }}">
      <span style="{{ spanStyle }}">
      <img style="{{ imgStyle }}" src="{{ imgSrc }}"/>

      <!-- Loop through navigation items as defined in dashBindings dimension-->
      {% for navItem in navItems %}
          {% assign navParts = navItem | split: valueDelimiter._value %}
          {% assign dashName = navParts[1] %}
          {% assign dashID = navParts[0] %}
          {% assign dashIDcheckType = dashID | plus: 0 %}

          <!-- check if id is numeric for UDD ids or string for LookML dashboards -->
          <!-- if LookML Dashboard then append model name if not provided -->

          <!-- if dashIDcheckType equals 0 then string else numeric-->
          {% if dashIDcheckType == 0 %}
              <!-- if dashID contains '::' then model_name is already provided-->
              {% if dashID contains '::' %}
              {% else %}
                {% assign dashID = modelName | append: '::' | append: dashID %}
              {% endif %}
          {% endif %}


          {% assign dashUrl = "/dashboards/" | append: dashID %}


          <!-- build links -->
          {% if navigation_focus_page._in_query and counter == focus %}
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
      <!-- until fixed use paramter navigation_focus_page or advise users to clear cache & refresh-->
      {% if navigation_focus_page._in_query == false %}
      <div>
      <span style="font-size: 10px;">{{ _explore._dashboard_url }} - clear cache & refresh to see active page</span>
      </div>
      {% endif %}
      </center>

    ;;
  }


}