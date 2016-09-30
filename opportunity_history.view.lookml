- view: opportunity_history
  sql_table_name: salesforce.opportunity_history
  fields:

  - dimension: id
    primary_key: true
    type: string
    sql: ${TABLE}.id

  - dimension_group: close
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.close_date

  - dimension: created_by_id
    type: string
    sql: ${TABLE}.created_by_id

  - dimension_group: created
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.created_date

  - dimension: is_deleted
    type: yesno
    sql: ${TABLE}.is_deleted

  - dimension: opportunity_id
    type: string
    sql: ${TABLE}.opportunity_id

  - dimension_group: received
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.received_at

  - dimension: stage_name
    type: string
    sql: ${TABLE}.stage_name

  - measure: count
    type: count
    drill_fields: [id, stage_name]

