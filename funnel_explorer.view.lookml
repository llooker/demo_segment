- view: funnel_explorer
  derived_table:
    sql: |
      SELECT tracks_sessions_map.session_id as session_id
        , MIN(
            CASE WHEN
              {% condition event1 %} tracks_sessions_map.event {% endcondition %} 
              THEN tracks_sessions_map.received_at
              ELSE NULL END
            ) as event1_time
        , MIN(
            CASE WHEN
              {% condition event2 %} tracks_sessions_map.event {% endcondition %} 
              THEN tracks_sessions_map.received_at
              ELSE NULL END
            ) as event2_time
        , MIN(
            CASE WHEN
              {% condition event3 %} tracks_sessions_map.event {% endcondition %} 
              THEN tracks_sessions_map.received_at
              ELSE NULL END
            ) as event3_time
      FROM ${track_facts.SQL_TABLE_NAME} as tracks_sessions_map
      GROUP BY 1

  fields:
    - filter: event1
      suggest_explore: event_list
      suggest_dimension: event_list.event_types

    - filter: event2
      suggest_explore: event_list
      suggest_dimension: event_list.event_types

    - filter: event3
      suggest_explore: event_list
      suggest_dimension: event_list.event_types

    - dimension: session_id
      type: string
      primary_key: TRUE
      sql: ${TABLE}.session_id

    - dimension: event1
      type: time
      timeframes: [time]
      sql: ${TABLE}.event1_time

    - dimension: event2
      type: time
      timeframes: [time]
      sql: ${TABLE}.event2_time

    - dimension: event3
      type: time
      timeframes: [time]
      sql: ${TABLE}.event3_time
    
    - dimension: event1_before_event2
      type: yesno
      sql: ${event1_time} < ${event2_time}

    - dimension: event2_before_event3
      type: yesno
      sql: ${event2_time} < ${event3_time}

    - measure: count_sessions
      type: count_distinct
      sql: ${session_id}

    - measure: count_sessions_event1
      type: count_distinct
      sql: ${session_id}
      filters: 
        event1_time: NOT NULL
    
    - measure: count_sessions_event12
      type: count_distinct
      sql: ${session_id}
      filters: 
        event1_time: NOT NULL
        event2_time: NOT NULL
        event1_before_event2: TRUE

    - measure: count_sessions_event123  
      type: count_distinct
      sql: ${session_id}
      filters: 
        event1_time: NOT NULL
        event2_time: NOT NULL
        event3_time: NOT NULL
        event1_before_event2: TRUE
        event2_before_event3: TRUE
