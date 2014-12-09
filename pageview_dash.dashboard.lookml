- dashboard: pageview_dash
  title: Pages Dashboard
  layout: tile
  tile_size: 100

#  filters:

  elements:

  - name: add_a_unique_name_5
    title: Daily Page Views
    type: looker_line
    model: demo_segment
    explore: pages
    dimensions: [pages.sent_date]
    measures: [pages.count_pageviews, pages.count_distinct_pageviews]
    sorts: [pages.sent_date desc]
    limit: 500
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
  
  - name: add_a_unique_name_159
    title: Average Time on Page
    type: table
    model: demo_segment
    explore: pages
    dimensions: [pages.url]
    measures: [pages.avg_page_view_duration_minutes]
    filters:
      pages.avg_page_view_duration_minutes: NOT NULL
    sorts: [pages.avg_page_view_duration_minutes desc]
    limit: 500
  
  - name: add_a_unique_name_987
    title: Exit Page Frequency
    type: looker_pie
    model: demo_segment
    explore: pages
    dimensions: [pages.path]
    measures: [pages.count_pageviews]
    filters:
      page_facts.is_last_page: 'Yes'
    sorts: [pages.count desc, pages.path]
    limit: 500


