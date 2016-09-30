- view: segments
  sql_table_name: sendgrid.segments
  fields:

  - dimension: id
    primary_key: true
    type: string
    sql: ${TABLE}.id

  - dimension: _id
    type: number
    sql: ${TABLE}._id

  - dimension: list_id
    type: number
    # hidden: true
    sql: ${TABLE}.list_id

  - dimension_group: received
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.received_at

  - dimension: recipient_count
    type: number
    sql: ${TABLE}.recipient_count

  - dimension: uuid
    type: number
    value_format_name: id
    sql: ${TABLE}.uuid

  - measure: count
    type: count
    drill_fields: [id, lists.id]

