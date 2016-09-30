- view: lists
  sql_table_name: sendgrid.lists
  fields:

  - dimension: id
    primary_key: true
    type: string
    sql: ${TABLE}.id

  - dimension: _id
    type: number
    sql: ${TABLE}._id

  - dimension_group: received
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.received_at

  - dimension: recipient_count
    type: number
    sql: ${TABLE}.recipient_count

  - measure: count
    type: count
    drill_fields: [id, segments.count]

