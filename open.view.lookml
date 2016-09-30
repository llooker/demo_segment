- view: _open
  sql_table_name: sendgrid._open
  fields:

  - dimension: id
    primary_key: true
    type: string
    sql: ${TABLE}.id

  - dimension: category
    type: string
    sql: ${TABLE}.category

  - dimension: event
    type: string
    sql: ${TABLE}.event

  - dimension: marketing_campaign_id
    type: number
    sql: ${TABLE}.marketing_campaign_id

  - dimension: nlvx_campaign_id
    type: number
    sql: ${TABLE}.nlvx_campaign_id

  - dimension: nlvx_user_id
    type: number
    sql: ${TABLE}.nlvx_user_id

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

  - dimension: sg_user_id
    type: number
    sql: ${TABLE}.sg_user_id

  - dimension: timestamp
    type: number
    sql: ${TABLE}.timestamp

  - measure: count
    type: count
    drill_fields: [id]

