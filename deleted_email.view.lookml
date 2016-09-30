- view: deleted_email
  sql_table_name: segment.deleted_email
  fields:

  - dimension: anonymous_id
    type: string
    sql: ${TABLE}.anonymous_id

  - dimension: project_id
    type: string
    sql: ${TABLE}.project_id

  - dimension_group: received
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.received_at

  - dimension: user_id
    type: string
    # hidden: true
    sql: ${TABLE}.user_id

  - dimension: workspace_id
    type: string
    sql: ${TABLE}.workspace_id

  - measure: count
    type: count
    drill_fields: [users.id]

