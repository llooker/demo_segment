- dashboard: a_pageview
  title: Pageview Summary
  layout: tile
  tile_size: 100

#  filters:
  filters:

  - name: date
    title: "Date"
    type: date_filter
    default_value: 2014

  elements:

  - name: add_a_unique_name_978
    title: Total Pageviews
    type: single_value
    model: pages
    explore: event_facts
    measures: [pages.count_pageviews]
    sorts: [pages.count_pageviews desc]
    listen: 
      date: pages.received_date
    limit: 500
    font_size: medium
    width: 3
    height: 2


  
#   - name: add_a_unique_name_1460489084289
#   title: Untitled Visualization
#   type: single_value
#   model: pages
#   explore: event_facts
#   measures: [event_facts.count_visitors, pages.count_pageviews, pages.count_distinct_pageviews,
#     pages.avg_page_view_duration_minutes]
#   sorts: [event_facts.count_visitors desc]
#   limit: 500
#   font_size: medium
#   text_color: black

  - name: add_a_unique_name_325
    title: Distinct Pageviews
    type: single_value
    model: pages
    explore: event_facts
    measures: [pages.count_distinct_pageviews]
    sorts: [pages.count_distinct_pageviews desc]
    listen: 
      date: pages.sent_date
    limit: 500
    font_size: medium
    width: 3
    height: 2
  
  - name: add_a_unique_name_463
    title: User Count
    type: single_value
    model: pages
    explore: event_facts
    measures: [pages.count_visitors]
    sorts: [pages.count_visitors desc]
    listen: 
      date: pages.sent_date
    limit: 500
    font_size: medium
    width: 3
    height: 2

  - name: add_a_unique_name_555
    title: Average Pageview Minutes
    type: single_value
    model: pages
    explore: event_facts
    measures: [pages.avg_page_view_duration_minutes]
    sorts: [pages.avg_page_view_duration_minutes desc]
    listen: 
      date: pages.sent_date
    limit: 500
    font_size: medium
    width: 3
    height: 2

  


  - name: add_a_unique_name_5
    title: Daily Page Views
    type: looker_line
    model: pages
    explore: event_facts
    dimensions: [pages.sent_date]
    measures: [pages.count_pageviews, pages.count_distinct_pageviews]
    sorts: [pages.sent_date desc]
    listen: 
      date: pages.sent_date
    limit: 500
    colors: ['#446c80', '#00b2d8']
    show_null_points: true
    stacking: ''
    show_value_labels: false
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    point_style: none
    interpolation: linear
    y_axis_combined: true
  
  - name: add_a_unique_name_987
    title: Exit Page Frequency
    type: looker_pie
    model: pages
    explore: event_facts
    dimensions: [pages.path]
    measures: [pages.count_pageviews]
    filters:
      page_facts.is_last_page: 'Yes'
    listen: 
      date: pages.sent_date
    sorts: [pages.count desc, pages.path]
    colors: ['#446c80', '#00b2d8']
    limit: 500
  
  - name: add_a_unique_name_466
    title: Page Stats
    type: table
    model: pages
    explore: event_facts
    dimensions: [pages.url]
    measures: [pages.avg_page_view_duration_minutes, pages.count_distinct_pageviews,
      pages.count_pageviews, pages.count_visitors]
    filters:
      pages.avg_page_view_duration_minutes: NOT NULL
    listen: 
      date: pages.sent_date
    sorts: [pages.avg_page_view_duration_minutes desc]
    limit: 500
    width: 12



