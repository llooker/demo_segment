- view: user_session_facts
  derived_table:
    sql_trigger_value: SELECT CURRENT_DATE
    distkey: user_id
    sortkeys: [user_id]
    
    sql: |
        SELECT 
          user_id                               
          , MIN(DATE(session_start)) as first_date              
          , MAX(DATE(session_start)) as last_date                
          , COUNT(*) as number_of_sessions                        
        FROM ${sessions.SQL_TABLE_NAME}
        GROUP BY 1
      
  fields:
#     Define your dimensions and measures here, like this:
    - dimension: user_id
      hidden: true
      primary_key: true
      sql: ${TABLE}.user_id

    - dimension: number_of_sessions
      type: number
      sql: ${TABLE}.number_of_sessions
    
    - dimension: number_of_sessions_tiered
      type: tier
      sql: ${number_of_sessions}
      tiers: [1,2,3,4,5,10]
    
    - dimension_group: first
      type: time
      timeframes: [date, week, month]
      sql: ${TABLE}.first_date
    
    - dimension_group: last
      type: time
      timeframes: [date, week, month]
      sql: ${TABLE}.last_date
      
