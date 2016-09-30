- view: created_a_project
  sql_table_name: segment.created_a_project
  fields:

  - dimension: anonymous_id
    type: string
    sql: ${TABLE}.anonymous_id

  - dimension: user_id
    type: string
    # hidden: true
    sql: ${TABLE}.user_id

  - dimension: auto_generated
    type: yesno
    sql: ${TABLE}.auto_generated

  - dimension: owner_id
    type: string
    sql: ${TABLE}.owner_id

  - dimension: project_id
    type: string
    sql: ${TABLE}.project_id

  - dimension_group: received
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.received_at

  - dimension: workspace_id
    type: string
    sql: ${TABLE}.workspace_id

  - measure: count
    type: count
    drill_fields: [users.id]

