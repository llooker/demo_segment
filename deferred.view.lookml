- view: deferred
  sql_table_name: sendgrid.deferred
  fields:

  - dimension: id
    primary_key: true
    type: string
    sql: ${TABLE}.id

  - dimension: event
    type: string
    sql: ${TABLE}.event

  - dimension_group: received
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.received_at

  - dimension: sg_event_id
    type: string
    sql: ${TABLE}.sg_event_id

  - dimension: sg_message_id
    type: string
    sql: ${TABLE}.sg_message_id

  - dimension: smtp_id
    type: string
    sql: ${TABLE}.smtp_id

  - dimension: timestamp
    type: number
    sql: ${TABLE}.timestamp

  - measure: count
    type: count
    drill_fields: [id]

