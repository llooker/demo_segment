- view: pages
  sql_table_name: hoodie.pages
  fields:

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
    primary_key: true
    sql: ${TABLE}.event_id

  - dimension: path
    sql: ${TABLE}.path

  - dimension: referrer
    sql: ${TABLE}.referrer

  - dimension: search
    sql: ${TABLE}.search

  - dimension_group: send
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.send_at

  - dimension_group: sent
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.sent_at
  
  - dimension: title
    sql: ${TABLE}.title

  - dimension: url
    sql: ${TABLE}.url

  - dimension: user_id
    hidden: true
    sql: ${TABLE}.user_id
  
  - dimension: mapped_user_id
    label: "PAGES User Id"
    sql: coalesce(${aliases_mapping.mapped_user_id},${user_id},${anonymous_id})

  - measure: count_pageviews
    type: count
    drill_fields: [context_library_name]
  
  - measure: count_users
    label: "PAGES User Count"
    type: count_distinct
    sql: ${mapped_user_id}

  - measure: avg_page_view_duration_minutes
    type: average
    decimals: 1
    sql: ${page_facts.duration_page_view_seconds}/60.0
  
  - measure: count_distinct_pageviews
    type: number
    sql: COUNT(DISTINCT CONCAT(${user_id}, ${url}))
