
- dashboard: 2_session_dashboard
  title: Sessions Overview
  layout: tile
  tile_size: 100

  filters:

  - name: date
    title: "Date"
    type: date_filter
    default_value: 2016

  elements:

  - name: add_a_unique_name_787
    title: Total Sessions
    type: single_value
    model: tracks
    explore: sessions_trk
    measures: [sessions_trk.count]
    listen:
      date: sessions_trk.start_date
    sorts: [sessions_trk.count desc]
    limit: 500
    width: 3
    height: 2

  - name: add_a_unique_name_425
    title: Distinct Visitors
    type: single_value
    model: tracks
    explore: sessions_trk
    measures: [sessions_trk.count_visitors]
    listen:
      date: sessions_trk.start_date
    sorts: [sessions_trk.count_visitors desc]
    limit: 500
    width: 3
    height: 2

  - name: add_a_unique_name_676
    title: Average Sessions Per User
    type: single_value
    model: tracks
    explore: sessions_trk
    measures: [sessions_trk.avg_sessions_per_user]
    listen:
      date: sessions_trk.start_date
    sorts: [sessions_trk.avg_sessions_per_user desc]
    limit: 500
    total: false
    font_size: medium
    width: 3
    height: 2

  - name: add_a_unique_name_804
    title: Average Session Duration
    type: single_value
    model: tracks
    explore: sessions_trk
    measures: [sessions_trk.avg_session_duration_minutes]
    listen:
      date: sessions_trk.start_date
    sorts: [sessions_trk.avg_session_duration_minutes desc]
    limit: 500
    total: false
    font_size: medium
    width: 3
    height: 2



  - name: add_a_unique_name_47
    title: Daily Session Count - Bounce Analysis
    type: looker_area
    model: tracks
    explore: sessions_trk
    dimensions: [session_trk_facts.is_bounced_session, sessions_trk.start_date]
    pivots: [session_trk_facts.is_bounced_session]
    measures: [sessions_trk.count]
    colors: ['#fcd15c', '#485963']
    listen:
      date: sessions_trk.start_date
    sorts: [sessions_trk.count desc 0]
    limit: 500
    show_null_points: true
    stacking: normal
    show_value_labels: false
    show_view_names: true
    x_axis_scale: auto
    x_axis_label_rotation: -45
    point_style: none
    interpolation: linear
    width: 8

  - name: add_a_unique_name_837
    title: Bounced Session Percentage
    type: looker_pie
    model: tracks
    explore: sessions_trk
    dimensions: [session_trk_facts.is_bounced_session]
    measures: [sessions_trk.count]
    colors: ['#fcd15c', '#485963']
    listen:
      date: sessions_trk.start_date
    sorts: [sessions_trk.count desc]
    limit: 500
    show_null_points: true
    stacking: normal
    width: 4

  - name: add_a_unique_name_975
    title: Daily Sessions by New Users
    type: looker_area
    model: tracks
    explore: sessions_trk
    dimensions: [sessions_trk.start_date, sessions_trk.is_first_session]
    pivots: [sessions_trk.is_first_session]
    measures: [sessions_trk.count]
    colors: ['#446c80', '#00b2d8']
    listen:
      date: sessions_trk.start_date
    sorts: [sessions_trk.start_date desc]
    limit: 500
    show_null_points: true
    stacking: normal
    show_value_labels: false
    show_view_names: true
    x_axis_scale: auto
    x_axis_label_rotation: -45
    point_style: none
    interpolation: linear
    width: 8

  - name: add_a_unique_name_692
    title: New User Session Percentage
    type: looker_pie
    model: tracks
    explore: sessions_trk
    dimensions: [sessions_trk.is_first_session]
    measures: [sessions_trk.count]
    colors: ['#446c80', '#00b2d8']
    listen:
      date: sessions_trk.start_date
    sorts: [sessions_trk.count desc]
    limit: 500
    show_null_points: true
    width: 4

  - name: add_a_unique_name_812
    title: Cohort - Sessions Layered by First Session Month
    type: looker_area
    model: tracks
    explore: sessions_trk
    dimensions: [user_session_facts.first_month, sessions_trk.start_date]
    pivots: [user_session_facts.first_month]
    measures: [sessions_trk.count]
    colors: ['#fcd15c', '#485963','#446c80', '#00b2d8', orange]
#     filters:
#       sessions_trk.start_month: 2014/09/01 to 2015/03/01
#       user_session_facts.first_month: 2014/09/01 to 2015/03/01
    sorts: [user_sessions_trk_facts.first_month desc, sessions_trk.start_month]
    limit: 500
    total: false
    show_null_points: true
    show_value_labels: false
    show_view_names: true
    stacking: normal
    x_axis_gridlines: false
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    x_axis_label_rotation: -45
    y_axis_gridlines: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    point_style: none
    interpolation: linear
    width: 8

  - name: add_a_unique_name_113
    title: Customer Cohorts
    type: table
    model: tracks
    explore: sessions_trk
    dimensions: [sessions_trk.start_date, user_session_facts.first_month]
    pivots: [sessions_trk.start_month]
    measures: [sessions_trk.count]
#     filters:
#       sessions_trk.start_month: 2014/09/01 to 2015/03/01
#       user_session_facts.first_month: 2014/09/01 to 2015/03/01
    sorts: [user_sessions_trk_facts.first_month, sessions_trk.start_month desc, user_session_facts.first_month desc]
    limit: 500
    total: false
    width: 4

  - name: add_a_unique_name_629
    title: Conversion Funnel
    type: looker_column
    model: tracks
    explore: sessions_trk
    measures: [session_trk_facts.count_app_loaded, session_trk_facts.count_login,
      session_trk_facts.count_subscribed_to_blog, session_trk_facts.count_signup]
    listen:
      date: sessions_trk.start_date
    sorts: [session_trk_facts.count_view_buy_page desc]
    limit: 500
    colors: ['#fcd15c', '#485963','#446c80', '#00b2d8', orange]
    total: false
    y_axis_gridlines: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    show_dropoff: true
    y_axis_combined: true
    stacking: ''
    show_value_labels: false
    x_axis_gridlines: false
    show_view_names: true
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    show_null_labels: false
    width: 12
