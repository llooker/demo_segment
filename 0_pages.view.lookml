- view: pages
  sql_table_name: hoodie.pages
  fields:
  
## Required Fields ##

  - dimension: event_id
    primary_key: true
    sql: ${TABLE}.event_id

  - dimension: anonymous_id
    hidden: true
    sql: ${TABLE}.anonymous_id
 
  - dimension_group: received
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.received_at
    
  
  - dimension: user_id
    hidden: true
    sql: ${TABLE}.user_id
  
  - dimension: path
    sql: ${TABLE}.path
  
  - dimension: url
    sql: ${TABLE}.url
    
    
## Additional Fields ##

  - dimension: context_ip
    sql: ${TABLE}.context_ip

  - dimension: context_library_name
    sql: ${TABLE}.context_library_name

  - dimension: context_library_version
    sql: ${TABLE}.context_library_version

  - dimension: context_user_agent
    sql: ${TABLE}.context_user_agent

  - dimension: referrer
    sql: ${TABLE}.referrer

  - dimension: search
    sql: ${TABLE}.search

  - dimension_group: sent
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.sent_at
    
#   - dimension_group: send
#     type: time                                ##DEPRECATED
#     timeframes: [time, date, week, month]
#     sql: ${TABLE}.send_at
  
  - dimension: title
    sql: ${TABLE}.title
    
#   - measure: count_visitors
#     type: count_distinct 
#     sql: ${page_aliases_mapping.looker_visitor_id}

  - measure: count_pageviews
    type: count
    drill_fields: [context_library_name]

  - measure: avg_page_view_duration_minutes
    type: average
    value_format_name: decimal_1
    sql: ${page_facts.duration_page_view_seconds}/60.0
  
  - measure: count_distinct_pageviews
    type: number
    sql: COUNT(DISTINCT CONCAT(${event_facts.looker_visitor_id}, ${url}))