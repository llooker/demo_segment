- view: sessions  # Creates sessions by user_id with 30 minute idle timeout window
  derived_table:
    sql_trigger_value: SELECT CURRENT_DATE
    distkey: start_event_id
    sortkeys: [start_event_id]
    sql: |
            SELECT lag.event_id AS start_event_id 
              , lag.user_id
              , lag.e_tstamp AS session_start
              , lag.idle_time AS idle_time
              , lag.context_device_model as context_device_model
              , ROW_NUMBER() OVER(PARTITION BY lag.user_id ORDER BY lag.e_tstamp) AS sessionidx
              , COALESCE(LEAD(lag.e_tstamp) OVER (PARTITION BY lag.user_id ORDER BY lag.e_tstamp)
              , '3000-01-01') AS next_session_start
            FROM (SELECT e.event_id AS event_id
                    , e.user_id
                    , e.sent_at AS e_tstamp
                    , e.context_device_model
                    , DATEDIFF(minutes, LAG(e.sent_at) OVER(PARTITION BY e.user_id ORDER BY e.sent_at), e.sent_at) AS idle_time
                  FROM hoodie.tracks AS e) AS lag
            WHERE (lag.idle_time > 30 OR lag.idle_time IS NULL)  

  fields:

  - dimension: start_event_id
    sql: ${TABLE}.start_event_id

  - dimension: user_id
    sql: ${TABLE}.user_id

  - dimension_group: start
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.session_start

  - dimension: is_new_user
    sql:  |
        CASE 
        WHEN ${start_date} = ${user_track_facts.first_track_date} THEN 'New User'
        ELSE 'Returning User' END
    
  - dimension: context_device_model
    sql: ${TABLE}.context_device_model
    
  - dimension: idle_time
    sql: ${TABLE}.idle_time

  - dimension: sessionidx
    type: number
    sql: ${TABLE}.sessionidx

  - dimension_group: next_session_start
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.next_session_start

  - measure: count
    type: count
    drill_fields: detail*
  
  - measure: count_users
    type: count_distinct
    sql: ${user_id}
  
  - measure: avg_sessions_per_user
    type: number
    decimals: 2
    sql: 1.00 * ${count} / NULLIF(${count_users}, 0)
   
  
  sets:
    detail:
      - start_event_id
      - user_id
      - session_start
      - idle_time
      - sessionidx
      - next_session_start

