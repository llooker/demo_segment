- view: ticket_metrics
  sql_table_name: zendesk.ticket_metrics
  fields:

  - dimension: id
    primary_key: true
    type: string
    sql: ${TABLE}.id

  - dimension: agent_wait_time_in_minutes_business
    type: number
    sql: ${TABLE}.agent_wait_time_in_minutes_business

  - dimension: agent_wait_time_in_minutes_calendar
    type: number
    sql: ${TABLE}.agent_wait_time_in_minutes_calendar

  - dimension_group: assigned
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.assigned_at

  - dimension: assignee_stations
    type: number
    sql: ${TABLE}.assignee_stations

  - dimension_group: assignee_updated
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.assignee_updated_at

  - dimension_group: created
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.created_at

  - dimension: first_resolution_time_in_minutes_business
    type: number
    sql: ${TABLE}.first_resolution_time_in_minutes_business

  - dimension: first_resolution_time_in_minutes_calendar
    type: number
    sql: ${TABLE}.first_resolution_time_in_minutes_calendar

  - dimension: full_resolution_time_in_minutes_business
    type: number
    sql: ${TABLE}.full_resolution_time_in_minutes_business

  - dimension: full_resolution_time_in_minutes_calendar
    type: number
    sql: ${TABLE}.full_resolution_time_in_minutes_calendar

  - dimension: group_stations
    type: number
    sql: ${TABLE}.group_stations

  - dimension_group: initially_assigned
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.initially_assigned_at

  - dimension_group: latest_comment_added
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.latest_comment_added_at

  - dimension: on_hold_time_in_minutes_business
    type: number
    sql: ${TABLE}.on_hold_time_in_minutes_business

  - dimension: on_hold_time_in_minutes_calendar
    type: number
    sql: ${TABLE}.on_hold_time_in_minutes_calendar

  - dimension_group: received
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.received_at

  - dimension: reopens
    type: number
    sql: ${TABLE}.reopens

  - dimension: replies
    type: number
    sql: ${TABLE}.replies

  - dimension: reply_time_in_minutes_business
    type: number
    sql: ${TABLE}.reply_time_in_minutes_business

  - dimension: reply_time_in_minutes_calendar
    type: number
    sql: ${TABLE}.reply_time_in_minutes_calendar

  - dimension_group: requester_updated
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.requester_updated_at

  - dimension: requester_wait_time_in_minutes_business
    type: number
    sql: ${TABLE}.requester_wait_time_in_minutes_business

  - dimension: requester_wait_time_in_minutes_calendar
    type: number
    sql: ${TABLE}.requester_wait_time_in_minutes_calendar

  - dimension_group: solved
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.solved_at

  - dimension_group: status_updated
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.status_updated_at

  - dimension: ticket_id
    type: string
    # hidden: true
    sql: ${TABLE}.ticket_id

  - dimension_group: updated
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.updated_at

  - measure: count
    type: count
    drill_fields: [id, tickets.id]

