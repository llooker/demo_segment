- dashboard: segment_dashboard
  title: Tracking Pulse
  layout: tile
  tile_size: 100

  filters:

  - name: date
    title: "Date"
    type: date_filter
    default_value: last 60 days
  
  - name: event
    title: Event Type
    type: select_filter
    base_view: tracks
    dimension: tracks.event
    
  elements:

  - name: add_a_unique_name_438
    title: Unique Users
    type: single_value
    model: demo_segment
    explore: tracks
    measures: [tracks.count_users]
    listen:
      date: tracks.sent_date
      event: tracks.event
    sorts: [tracks.count_users desc]
    limit: 500
    font_size: medium
    width: 4
    height: 2
  
  - name: add_a_unique_name_438
    title: Total Tracks
    type: single_value
    model: demo_segment
    explore: tracks
    measures: [tracks.count]
    listen:
      date: tracks.sent_date
      event: tracks.event
    sorts: [tracks.count desc]
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
      event: tracks.event
    sorts: [pages.count_pageviews desc]
    limit: 500
    font_size: medium
    width: 4
    height: 2

  - name: add_a_unique_name_110
    title: Daily Tracks Count
    type: looker_line
    model: demo_segment
    explore: tracks
    dimensions: [tracks.sent_date]
    measures: [tracks.count]
    listen:
      date: tracks.sent_date
      event: tracks.event
    sorts: [tracks.sent_date]
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
    explore: tracks
    dimensions: [tracks.event]
    measures: [tracks.count]
    listen:
      date: tracks.sent_date
    sorts: [tracks.count desc]
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

  - name: add_a_unique_name_416
    title: Distribution of Users Days Spent on Site
    type: looker_column
    model: demo_segment
    explore: tracks
    dimensions: [user_track_facts.days_tracked_on_site_tiered]
    measures: [tracks.count_users]
    listen:
      date: tracks.sent_date
      event: tracks.event
    sorts: [user_track_facts.days_tracked_on_site_tiered]
    limit: 14
    show_null_points: true
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_gridlines: false
    x_axis_scale: auto
    show_value_labels: false
    show_view_names: true
    stacking: normal
    y_axis_gridlines: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    show_null_labels: false

  - name: add_a_unique_name_489
    title: New vs Returning User Breakdown
    type: looker_area
    model: demo_segment
    explore: tracks
    dimensions: [tracks.is_new_user, tracks.sent_date]
    pivots: [tracks.is_new_user]
    measures: [tracks.count_users]
    listen:
      date: tracks.sent_date
      event: tracks.event
    sorts: [tracks.sent_date]
    limit: 500
    show_null_points: true
    stacking: normal
    show_value_labels: false
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    point_style: none
    interpolation: linear

  
  - name: add_a_unique_name_954
    title: Count Users Tracked by First Visit Week
    type: looker_line
    model: demo_segment
    explore: tracks
    dimensions: [user_track_facts.first_track_week, tracks.weeks_since_first_visit]
    pivots: [user_track_facts.first_track_week]
    measures: [tracks.count_users]
    filters:
      user_track_facts.first_track_week: 4 months
    sorts: [user_track_facts.first_track_week, tracks.weeks_since_first_visit]
    limit: 500
    show_null_points: false
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
    point_style: none
    interpolation: linear
    width: 12
    








  
