- view: activity
  sql_table_name: sendgrid.activity
  fields:

  - dimension: email
    type: string
    sql: ${TABLE}.email

  - dimension: event
    type: string
    sql: ${TABLE}.event

  - dimension: marketing_campaign_name
    type: string
    sql: ${TABLE}.marketing_campaign_name

  - dimension_group: received
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.received_at

  - measure: count
    type: count
    drill_fields: [marketing_campaign_name]

