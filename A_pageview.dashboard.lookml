- dashboard: a_pageview
  title: Pageview Summary
  layout: tile
  tile_size: 100

  filters:

  - name: date
    title: "Date"
    type: date_filter
    default_value: 2016

  elements:

  - name: page_views
    title: Total Pageviews
    type: single_value
    model: pages
    explore: event_facts
    measures: [pages.count_pageviews, pages.count_distinct_pageviews, pages.avg_page_view_duration_minutes,
      pages.count_visitors]
    hidden_fields: [pages.count_distinct_pageviews, pages.avg_page_view_duration_minutes,
      pages.count_visitors]
    listen:
      date: pages.received_date
    sorts: [pages.count_pageviews desc]
    limit: 500
    custom_color_enabled: false
    show_single_value_title: true
    single_value_title: Total Pageviews
    show_comparison: false
    font_size: medium
    width: 3
    height: 2

  - name: distinct_page_views
    title: Distinct Pageviews
    type: single_value
    model: pages
    explore: event_facts
    measures: [pages.count_pageviews, pages.count_distinct_pageviews, pages.avg_page_view_duration_minutes,
      pages.count_visitors]
    hidden_fields: [pages.count_pageviews, pages.avg_page_view_duration_minutes,
      pages.count_visitors]
    listen:
      date: pages.received_date
    sorts: [pages.count_distinct_pageviews desc]
    limit: 500
    custom_color_enabled: false
    show_single_value_title: true
    single_value_title: Distinct Pageviews
    show_comparison: false
    font_size: medium
    width: 3
    height: 2

  - name: user_count
    title: User Count
    type: single_value
    model: pages
    explore: event_facts
    measures: [pages.count_pageviews, pages.count_distinct_pageviews, pages.avg_page_view_duration_minutes,
      pages.count_visitors]
    hidden_fields: [pages.count_pageviews, pages.count_distinct_pageviews, pages.avg_page_view_duration_minutes]
    listen:
      date: pages.received_date
    sorts: [pages.count_visitors desc]
    limit: 500
    custom_color_enabled: false
    show_single_value_title: true
    single_value_title: User Count
    show_comparison: false
    font_size: medium
    width: 3
    height: 2

  - name: pageview_minutes
    title: Average Pageview Minutes
    type: single_value
    model: pages
    explore: event_facts
    measures: [pages.count_pageviews, pages.count_distinct_pageviews, pages.avg_page_view_duration_minutes,
      pages.count_visitors]
    hidden_fields: [pages.count_pageviews, pages.count_distinct_pageviews, pages.count_visitors]
    listen:
      date: pages.received_date
    sorts: [pages.avg_page_view_duration_minutes desc]
    limit: 500
    custom_color_enabled: false
    show_single_value_title: true
    single_value_title: Average Pageview Minutes
    show_comparison: false
    font_size: medium
    width: 3
    height: 2

  - name: daily_page_views
    title: Daily Page Views
    type: looker_line
    model: pages
    explore: event_facts
    dimensions: [pages.received_date]
    measures: [pages.count_pageviews, pages.count_distinct_pageviews]
    sorts: [pages.received_date desc]
    listen:
      date: pages.received_date
    limit: 500
    stacking: ''
    colors: ['#446c80', '#00b2d8']
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    show_null_points: true
    point_style: none
    interpolation: linear

  - name: page_view_name
    title: Page Views by Type
    type: looker_pie
    model: pages
    explore: event_facts
    dimensions: [pages.name]
    measures: [pages.count_pageviews]
    filters:
      page_facts.is_last_page: 'Yes'
    listen:
      date: pages.received_date
    sorts: [pages.count_pageviews desc]
    colors: ['#446c80', '#00b2d8']
    limit: 500
    value_labels: legend
    show_view_names: true

  - name: page_stats
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
      date: pages.received_date
    sorts: [pages.avg_page_view_duration_minutes desc]
    limit: 500
    width: 12
    show_view_names: false
    show_row_numbers: false
    truncate_column_names: false
    table_theme: editable
    limit_displayed_rows: false

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
