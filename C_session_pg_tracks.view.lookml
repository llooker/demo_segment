- view: sessions_pg_trk
  derived_table:
    sortkeys: [session_start_at]
    distkey: looker_visitor_id  
    sql_trigger_value: select count(*) from ${mapped_events.SQL_TABLE_NAME}
    
    sql: |
        select row_number() over(partition by looker_visitor_id order by received_at) || ' - '||  looker_visitor_id as session_id
              , looker_visitor_id
              , received_at as session_start_at
              , row_number() over(partition by looker_visitor_id order by received_at) as session_sequence_number
              , lead(received_at) over(partition by looker_visitor_id order by received_at) as next_session_start_at
        from ${mapped_events.SQL_TABLE_NAME}
        where (idle_time_minutes > 30 or idle_time_minutes is null)
            

  fields:
  - measure: count
    type: count
    drill_fields: detail*

  - dimension: session_id
    hidden: true
    sql: ${TABLE}.session_id

  - dimension: looker_visitor_id
    type: number
    sql: ${TABLE}.looker_visitor_id

  - dimension_group: session_start_at
    type: time
    timeframes: [time, date, week, month, raw]
    sql: ${TABLE}.session_start_at

  - dimension: session_sequence_number
    type: number
    sql: ${TABLE}.session_sequence_number

  - dimension: next_session_start_at
    sql: ${TABLE}.next_session_start_at

  sets:
    detail:
      - session_id
      - looker_visitor_id
      - session_start_at
      - session_sequence_number
      - next_session_start_at

