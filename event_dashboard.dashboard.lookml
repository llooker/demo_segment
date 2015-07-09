- dashboard: segment_dashboard
  title: Tracks Overview
  layout: tile
  tile_size: 100

  filters:

  - name: date
    title: "Date"
    type: date_filter
    default_value: 2014
  
  - name: event
    title: Event Type
    explore: events
    type: field_filter
    base_view: tracks
    field: events.event
    
  elements:

  - name: add_a_unique_name_438
    title: Unique Users
    type: single_value
    model: demo_segment
    explore: events
    measures: [track_facts.count_visitors]
    listen:
      date: events.sent_date
      event: events.event
    sorts: [track_facts.count_visitors desc]
    limit: 500
    font_size: medium
    width: 4
    height: 2
  
  - name: add_a_unique_name_438
    title: Total Tracks
    type: single_value
    model: demo_segment
    explore: events
    measures: [events.count]
    listen:
      date: events.sent_date
      event: events.event
    sorts: [events.count desc]
    limit: 500
    font_size: medium
    width: 4
    height: 2
  
  - name: add_a_unique_name_863
    title: Pages Count
    type: single_value
    model: demo_segment
    explore: pages
    measures: [pages.count_pageviews]
    listen:
      date: pages.sent_date
#       event: tracks.event
    sorts: [pages.count_pageviews desc]
    limit: 500
    font_size: medium
    width: 4
    height: 2

  - name: add_a_unique_name_313
    title: Carrier Breakdown
    type: looker_pie
    model: demo_segment
    explore: events
    dimensions: [events.context_carrier]
    measures: [events.count]
    filters:
      events.context_carrier: -NULL
    sorts: [events.count desc]
    limit: 500
    width: 4
    height: 2
  
#   - name: add_a_unique_name_203
#     title: Manufacturer Breakdown
#     type: looker_pie
#     model: demo_segment
#     explore: tracks
#     dimensions: [tracks.context_device_manufacturer]
#     measures: [tracks.count]
#     filters:
#       tracks.context_device_manufacturer: -NULL
#     sorts: [tracks.count desc]
#     limit: 500
#     width: 3
#     height: 3
  
  - name: add_a_unique_name_769
    title: Device Type Breakdown
    type: looker_pie
    model: demo_segment
    explore: events
    dimensions: [events.context_device_type]
    measures: [events.count]
    filters:
      events.context_device_type: -NULL
    sorts: [events.count desc]
    limit: 500
    width: 4
    height: 2
  
  - name: add_a_unique_name_11
    title: Top Device Models
    type: table
    model: demo_segment
    explore: events
    dimensions: [events.context_device_model]
    measures: [events.count]
    filters:
      events.context_device_model: -NULL
    sorts: [events.count desc]
    limit: 50
    width: 4
    height: 2
    
  - name: add_a_unique_name_110
    title: Daily Tracks Count
    type: looker_line
    model: demo_segment
    explore: events
    dimensions: [events.sent_date]
    measures: [events.count]
    listen:
      date: events.sent_date
      event: events.event
    sorts: [events.sent_date]
    limit: 500
    show_null_points: true
    stacking: ''
    show_value_labels: false
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    reference_lines:
      - value: [max, mean]
        label: Above Average
        color: lightslategray
      - value: [median]
        label: Median
        color: lightslategray
    point_style: none
    interpolation: linear
    y_axis_orientation: [left, right]

  - name: add_a_unique_name_973
    title: Top 25 Event Types by Track Count
    type: looker_column
    model: demo_segment
    explore: events
    dimensions: [events.event]
    measures: [events.count]
    listen:
      date: events.sent_date
    sorts: [events.count desc]
    limit: 25
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_gridlines: false
    x_axis_label_rotation: -50
    stacking: ''
    show_value_labels: false
    y_axis_gridlines: true
    show_view_names: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    x_axis_scale: auto
    show_null_labels: false







  
