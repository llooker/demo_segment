
- dashboard: 3_event_flow_dashboard
  title: Event Flow Analysis
  layout: tile
  tile_size: 100

  filters:

  - name: date
    title: "Date"
    type: date_filter
    default_value: 2016

  - name: event
    title: 'First Event'
    type: text
    model: tracks
    explore: track_facts
    field: track_facts.event
    default_value: 'login'

  elements:

  - name: tracks_drop_off
    title: Tracks Drop Off
    type: looker_column
    model: tracks
    explore: track_facts
    measures: [tracks.count, tracks_flow.event_2_drop_off, tracks_flow.event_3_drop_off,
      tracks_flow.event_4_drop_off, tracks_flow.event_5_drop_off]
#     listen:
#       event: tracks.event
    sorts: [tracks.count desc]
    limit: 500
    height: 4
    width: 12
    stacking: ''
    colors: ['#a6cee3', '#1f78b4', '#b2df8a', '#33a02c', '#fdbf6f', '#ff7f00', '#cab2d6',
      '#6a3d9a', '#edbc0e', '#b15928']
    show_value_labels: true
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    show_null_labels: false
    show_dropoff: true

  - name: event_flow
    title: Event Flow
    type: table
    model: tracks
    explore: track_facts
    dimensions: [tracks.event, tracks_flow.event_2, tracks_flow.event_3, tracks_flow.event_4,
      tracks_flow.event_5]
    measures: [tracks.count]
#     listen:
#       event: tracks.event
    filters:
      tracks_flow.event_2: -NULL
      tracks_flow.event_3: -NULL
      tracks_flow.event_4: -NULL
      tracks_flow.event_5: -NULL
    sorts: [tracks.count desc]
    height: 4
    width: 12
    limit: 500
    show_view_names: false
    show_row_numbers: true
    truncate_column_names: false

  - name: top_five_second
    title: Top 5 Second Events
    type: looker_bar
    model: tracks
    explore: track_facts
    dimensions: [tracks_flow.event_2]
    measures: [tracks.count]
#     listen:
#       event: tracks.event
    filters:
      tracks_flow.event_2: -NULL
      tracks_flow.event_3: -NULL
      tracks_flow.event_4: -NULL
      tracks_flow.event_5: -NULL
    sorts: [tracks.count desc]
    height: 4
    width: 3
    limit: 5
    stacking: ''
    colors: ['#a6cee3', '#1f78b4', '#b2df8a', '#33a02c', '#fb9a99', '#e31a1c', '#fdbf6f',
      '#ff7f00', '#cab2d6', '#6a3d9a', '#edbc0e', '#b15928']
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: true
    x_axis_scale: auto
    show_null_labels: false

  - name: top_five_third
    title: Top 5 Third Events
    type: looker_bar
    model: tracks
    explore: track_facts
    dimensions: [tracks_flow.event_3]
    measures: [tracks.count]
#     listen:
#       event: tracks.event
    filters:
      tracks_flow.event_2: -NULL
      tracks_flow.event_3: -NULL
      tracks_flow.event_4: -NULL
      tracks_flow.event_5: -NULL
    sorts: [tracks.count desc]
    limit: 5
    height: 4
    width: 3
    stacking: ''
    colors: ['#a6cee3', '#1f78b4', '#b2df8a', '#33a02c', '#fb9a99', '#e31a1c', '#fdbf6f',
      '#ff7f00', '#cab2d6', '#6a3d9a', '#edbc0e', '#b15928']
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: true
    x_axis_scale: auto
    show_null_labels: false

  - name: top_five_fourth
    title: Top 5 Fourth Events
    type: looker_bar
    model: tracks
    explore: track_facts
    dimensions: [tracks_flow.event_4]
    measures: [tracks.count]
#     listen:
#       event: tracks.event
    filters:
      tracks_flow.event_2: -NULL
      tracks_flow.event_3: -NULL
      tracks_flow.event_4: -NULL
      tracks_flow.event_5: -NULL
    sorts: [tracks.count desc]
    limit: 5
    height: 4
    width: 3
    stacking: ''
    colors: ['#a6cee3', '#1f78b4', '#b2df8a', '#33a02c', '#fb9a99', '#e31a1c', '#fdbf6f',
      '#ff7f00', '#cab2d6', '#6a3d9a', '#edbc0e', '#b15928']
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: true
    x_axis_scale: auto
    show_null_labels: false

  - name: top_five_fifth
    title: Top 5 Fifth Events
    type: looker_bar
    model: tracks
    explore: track_facts
    dimensions: [tracks_flow.event_5]
    measures: [tracks.count]
#     listen:
#       event: tracks.event
    filters:
      tracks_flow.event_2: -NULL
      tracks_flow.event_3: -NULL
      tracks_flow.event_4: -NULL
      tracks_flow.event_5: -NULL
    sorts: [tracks.count desc]
    limit: 5
    height: 4
    width: 3
    stacking: ''
    colors: ['#a6cee3', '#1f78b4', '#b2df8a', '#33a02c', '#fb9a99', '#e31a1c', '#fdbf6f',
      '#ff7f00', '#cab2d6', '#6a3d9a', '#edbc0e', '#b15928']
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: true
    x_axis_scale: auto
    show_null_labels: false

  - name: top_second
    title: Second Event
    type: table
    model: tracks
    explore: track_facts
    dimensions: [tracks_flow.event_2]
    measures: [tracks.count, tracks.count_percent_of_total]
#     listen:
#       event: tracks.event
    filters:
      tracks_flow.event_2: -NULL
      tracks_flow.event_3: -NULL
      tracks_flow.event_4: -NULL
      tracks_flow.event_5: -NULL
    sorts: [tracks.count desc]
    limit: 500
    height: 4
    width: 3
    show_view_names: false
    show_row_numbers: true
    truncate_column_names: false

  - name: top_third
    title: Third Event
    type: table
    model: tracks
    explore: track_facts
    dimensions: [tracks_flow.event_3]
    measures: [tracks.count, tracks.count_percent_of_total]
#     listen:
#       event: tracks.event
    filters:
      tracks_flow.event_2: -NULL
      tracks_flow.event_3: -NULL
      tracks_flow.event_4: -NULL
      tracks_flow.event_5: -NULL
    sorts: [tracks.count desc]
    limit: 500
    height: 4
    width: 3
    show_view_names: false
    show_row_numbers: true
    truncate_column_names: false

  - name: top_fourth
    title: Fourth Event
    type: table
    model: tracks
    explore: track_facts
    dimensions: [tracks_flow.event_4]
    measures: [tracks.count, tracks.count_percent_of_total]
#     listen:
#       event: tracks.event
    filters:
      tracks_flow.event_2: -NULL
      tracks_flow.event_3: -NULL
      tracks_flow.event_4: -NULL
      tracks_flow.event_5: -NULL
    sorts: [tracks.count desc]
    limit: 500
    height: 4
    width: 3
    show_view_names: false
    show_row_numbers: true
    truncate_column_names: false

  - name: top_fifth
    title: Fifth Event
    type: table
    model: tracks
    explore: track_facts
    dimensions: [tracks_flow.event_5]
    measures: [tracks.count, tracks.count_percent_of_total]
#     listen:
#       event: tracks.event
    filters:
      tracks_flow.event_2: -NULL
      tracks_flow.event_3: -NULL
      tracks_flow.event_4: -NULL
      tracks_flow.event_5: -NULL
    sorts: [tracks.count desc]
    limit: 500
    height: 4
    width: 3
    show_view_names: false
    show_row_numbers: true
    truncate_column_names: false
