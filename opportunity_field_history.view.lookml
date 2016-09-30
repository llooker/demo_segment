- view: opportunity_field_history
  sql_table_name: salesforce.opportunity_field_history
  fields:

  - dimension: id
    primary_key: true
    type: string
    sql: ${TABLE}.id

  - dimension: created_by_id
    type: string
    sql: ${TABLE}.created_by_id

  - dimension_group: created
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.created_date

  - dimension: field
    type: string
    sql: ${TABLE}.field

  - dimension: is_deleted
    type: yesno
    sql: ${TABLE}.is_deleted

  - dimension_group: new_value
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.new_value

  - dimension_group: old_value
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.old_value

  - dimension: opportunity_id
    type: string
    sql: ${TABLE}.opportunity_id

  - dimension_group: received
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.received_at

  - measure: count
    type: count
    drill_fields: [id]

