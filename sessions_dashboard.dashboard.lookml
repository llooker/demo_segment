- dashboard: sessions_dashboard
  title: Session Overview
  layout: tile
  tile_size: 100

#  filters:

  filters:

  - name: date
    title: "Date"
    type: date_filter
    default_value: last 60 days
    
  elements:

  - name: add_a_unique_name_663
    title: Total Sessions
    type: single_value
    model: demo_segment
    explore: sessions
    measures: [sessions.count]
    listen: 
      date: sessions.start_date
    sorts: [sessions.count desc]
    limit: 500
    show_null_points: true
    show_value_labels: false
    show_view_names: true
    stacking: normal
    font_size: medium
    width: 3
    height: 2
  
  - name: add_a_unique_name_938
    title: Distinct Users
    type: single_value
    model: demo_segment
    explore: sessions
    measures: [sessions.count_users]
    listen: 
      date: sessions.start_date
    sorts: [sessions.count_users desc]
    limit: 500
    show_null_points: true
    show_value_labels: false
    show_view_names: true
    stacking: normal
    font_size: medium
    width: 3
    height: 2
  
  - name: add_a_unique_name_788
    title: Average Session Duration (Minutes)
    type: single_value
    model: demo_segment
    explore: sessions
    measures: [sessions.avg_session_duration_minutes]
    listen: 
      date: sessions.start_date
    sorts: [sessions.avg_session_duration_minutes desc]
    limit: 500
    show_null_points: true
    show_value_labels: false
    show_view_names: true
    stacking: normal
    font_size: medium
    width: 3
    height: 2
  
  - name: add_a_unique_name_820
    title: Average Number of Events per Session
    type: single_value
    model: demo_segment
    explore: sessions
    measures: [sessions.avg_events_per_session]
    listen: 
      date: sessions.start_date
    sorts: [sessions.avg_events_per_session desc]
    limit: 500
    show_null_points: true
    show_value_labels: false
    show_view_names: true
    stacking: normal
    font_size: medium
    width: 3
    height: 2

  - name: add_a_unique_name_363
    title: Daily Sessions by New Users
    type: looker_area
    model: demo_segment
    explore: sessions
    dimensions: [sessions.is_new_user, sessions.start_date]
    pivots: [sessions.is_new_user]
    measures: [sessions.count]
    listen: 
      date: sessions.start_date
    sorts: [sessions.count desc 0]
    limit: 500
    show_null_points: true
    show_value_labels: false
    show_view_names: true
    stacking: normal
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    point_style: none
    interpolation: linear
    width: 8
  
  - name: add_a_unique_name_674
    title: New User Session Percentage
    type: looker_pie
    model: demo_segment
    explore: sessions
    dimensions: [sessions.is_new_user]
    measures: [sessions.count]
    listen: 
      date: sessions.start_date
    sorts: [sessions.is_new_user]
    limit: 500
    show_null_points: true
    show_value_labels: false
    show_view_names: true
    stacking: normal
    width: 4

  - name: add_a_unique_name_709
    title: Daily Bounced Sessions
    type: looker_line
    model: demo_segment
    explore: sessions
    dimensions: [sessions.is_bounced, sessions.start_date]
    pivots: [sessions.is_bounced]
    measures: [sessions.count]
    listen: 
      date: sessions.start_date
    sorts: [sessions.start_date]
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
    point_style: none
    interpolation: linear
    width: 8
    colors: [orange,'#7f889b']
  
  - name: add_a_unique_name_764
    title: Session Bounce Rate
    type: looker_pie
    model: demo_segment
    explore: sessions
    dimensions: [sessions.is_bounced]
    measures: [sessions.count]
    listen: 
      date: sessions.start_date
    sorts: [sessions.is_bounced]
    limit: 500
    show_null_points: true
    width: 4
    colors: ['#7f889b',orange]

  - name: add_a_unique_name_548
    title: Session Conversion Funnel
    type: looker_column
    model: demo_segment
    explore: sessions
    measures: [sessions.count_view_buy_page, sessions.count_added_item, sessions.count_tapped_shipit,
      sessions.count_made_purchase]
    sorts: [sessions.count_view_buy_page desc]
    listen: 
      date: sessions.start_date
    limit: 500
    y_axis_gridlines: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_combined: true
    show_dropoff: true
    show_value_labels: false
    show_view_names: false
    show_null_labels: false
    x_axis_gridlines: false
    show_x_axis_label: true
    show_x_axis_ticks: true
    stacking: ''
    x_axis_scale: auto
    width: 12
    
  - name: add_a_unique_name_78
    title: Sessions per User Distribution
    type: looker_column
    model: demo_segment
    explore: sessions
    dimensions: [user_session_facts.number_of_sessions_tiered]
    measures: [sessions.count_users]
    listen: 
      date: sessions.start_date
    sorts: [sessions.count_users desc]
    limit: 500
    x_axis_gridlines: false
    show_x_axis_label: true
    show_x_axis_ticks: true
    stacking: ''
    show_value_labels: false
    y_axis_gridlines: true
    show_view_names: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    x_axis_scale: auto
    show_null_labels: false
  
  - name: add_a_unique_name_249
    title: Distribution of Events per Session
    type: looker_column
    model: demo_segment
    explore: sessions
    dimensions: [sessions.number_events_tiered]
    measures: [sessions.count]
    listen: 
      date: sessions.start_date
    sorts: [sessions.number_events_tiered]
    limit: 6
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
    show_null_labels: false
    colors: [orange]