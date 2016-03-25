- view: aliases
  sql_table_name: hoodie.aliases
  fields:
  
  - dimension: user_id
    primary_key: true
    sql: ${TABLE}.user_id

  - dimension: anonymous_id
    sql: ${TABLE}.anonymous_id

  - dimension: context_ip
    sql: ${TABLE}.context_ip

  - dimension: context_library_name
    sql: ${TABLE}.context_library_name

  - dimension: context_library_version
    sql: ${TABLE}.context_library_version

  - dimension: context_user_agent
    sql: ${TABLE}.context_user_agent

  - dimension: event_id
    sql: ${TABLE}.event_id

  - dimension: previous_id
    sql: ${TABLE}.previous_id

  - dimension_group: send
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.send_at

  - dimension_group: sent
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.sent_at

  - measure: count
    type: count
    drill_fields: [context_library_name]

