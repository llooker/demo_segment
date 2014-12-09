- explore: session_fact # Determines time session ended at and number of events in session
- view: session_facts
  derived_table:
    sql: |
                SELECT s.user_id
                  , s.sessionidx
                  , LEAST(MAX(pv.sent_at) + INTERVAL '30 minutes', s.next_session_start) AS ended_at
                  , count(distinct pv.event_id) AS num_pvs
                FROM ${sessions.SQL_TABLE_NAME} AS s
                  LEFT JOIN ${tracks_sessions_map.SQL_TABLE_NAME} as map USING(user_id, sessionidx)
                  LEFT JOIN hoodie.tracks pv USING(event_id)
                GROUP BY s.user_id
                  , s.sessionidx
                  , s.next_session_start
                  
    sql_trigger_value: select max(event_id) from ${tracks_sessions_map.SQL_TABLE_NAME}
    sortkeys: [user_id, sessionidx]
    distkey: user_id

  fields:


  - dimension: user_id
    hidden: true
    sql: ${TABLE}.user_id
  
#   - dimension: carrier
#     sql: ${TABLE}.carrier
#   
#   - dimension: device_manufacturer
#     sql: ${TABLE}.device_manufacturer
#   
#   - dimension: device_model
#     sql: ${TABLE}.device_model
# 
#   - dimension: os
#     sql: ${TABLE}.os

  - dimension: sessionidx
    hidden: true
    type: number
    sql: ${TABLE}.sessionidx

  - dimension_group: ended_at
    label: SESSIONS End
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.ended_at

  - dimension: number_events
    label: SESSIONS Number of Events
    type: number
    sql: ${TABLE}.num_pvs
  
  - dimension: number_events_tiered
    type: tier
    sql: ${number_events}
    tiers: [1,5,10,20,30,60]
  
#   - measure: count
#     type: count
  
  - dimension: is_bounced
    sql: CASE 
            WHEN ${number_events} = 1 THEN 'Bounced Session'
            ELSE 'Not Bounced' END
  
  - dimension: session_duration_minutes
    type: number
    sql: DATEDIFF(minutes, ${sessions.start_time}::timestamp, ${ended_at_time}::timestamp)
    
  - dimension: session_duration_minutes_tiered
    type: tier
    sql: ${session_duration_minutes}
    tiers: [1,5,10,20,30,60]
  
  - measure: avg_session_duration_minutes
    type: average
    sql: ${session_duration_minutes}
  
  - measure: avg_events_per_session
    type: average
    sql: ${number_events}
  


  
  sets:
    detail:
      - user_id
      - sessionidx
      - ended_at
      - num_pvs

