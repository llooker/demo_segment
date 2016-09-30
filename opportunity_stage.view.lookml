- view: opportunity_stage
  sql_table_name: salesforce.opportunity_stage
  fields:

  - dimension: id
    primary_key: true
    type: string
    sql: ${TABLE}.id

  - dimension_group: created
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.created_date

  - dimension: is_active
    type: yesno
    sql: ${TABLE}.is_active

  - dimension: is_closed
    type: yesno
    sql: ${TABLE}.is_closed

  - dimension: is_won
    type: yesno
    sql: ${TABLE}.is_won

  - dimension_group: received
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.received_at

  - measure: count
    type: count
    drill_fields: [id]

