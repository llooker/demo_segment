- dashboard: 4_funnel_dashboard
  title: 4 Funnel Dashboard
  layout: tile
  tile_size: 200

  filters:

  - name: event1
    title: 'First Event'
    type: field_filter
    model: tracks
    explore: track_facts
    field: track_facts.event
    default_value: 'signup'

  - name: event2
    title: 'Second Event'
    type: field_filter
    model: tracks
    explore: track_facts
    field: track_facts.event
    default_value: 'login'

  - name: event3
    title: 'Third Event'
    type: field_filter
    model: tracks
    explore: track_facts
    field: track_facts.event
    default_value: 'created_ticket'

  elements:

  - name: add_a_unique_name_1475003582
    title: Untitled Visualization
    type: looker_column
    model: tracks
    explore: funnel_explorer
    measures: [funnel_explorer.count_sessions_event1,
      funnel_explorer.count_sessions_event12, funnel_explorer.count_sessions_event123]
    listen:
      event1: funnel_explorer.event1
      event2: funnel_explorer.event2
      event3: funnel_explorer.event3
    sorts: [funnel_explorer.count_sessions desc]
    limit: '500'
    column_limit: '50'
    query_timezone: America/Los_Angeles
    stacking: ''
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
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: '#808080'
    show_dropoff: true
