- view: sessions_trk
  derived_table:
    sql_trigger_value: select count(1) from ${aliases_mapping.SQL_TABLE_NAME}
    sortkeys: [session_id]
    distkey: looker_visitor_id
    sql: |
        select row_number() over(partition by looker_visitor_id order by sent_at) || ' - ' || looker_visitor_id as session_id
              , looker_visitor_id
              , sent_at as session_start_at
              , row_number() over(partition by looker_visitor_id order by sent_at) as session_sequence_number
              , lead(sent_at) over(partition by looker_visitor_id order by sent_at) as next_session_start_at
        from ${mapped_tracks.SQL_TABLE_NAME}
        where (idle_time_minutes > 30 or idle_time_minutes is null)
            

  fields:

  - dimension: session_id
    primary_key: true
    sql: ${TABLE}.session_id

  - dimension: looker_visitor_id
    type: number
    sql: ${TABLE}.looker_visitor_id

  - dimension_group: start
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.session_start_at

  - dimension: sequence_number
    type: number
    sql: ${TABLE}.session_sequence_number
  
  - dimension: is_first_session
#     type: yesno
    sql: |
      CASE WHEN ${sequence_number} = 1 THEN 'First Session'
           ELSE 'Repeat Session'
      END

  - dimension: next_session_start_at
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.next_session_start_at
  
  - dimension: session_duration_minutes
    type: number
    sql: DATEDIFF(minutes, ${start_time}::timestamp, ${session_trk_facts.ended_at_time}::timestamp)
  
  - measure: count
    type: count
    drill_fields: detail*
  
  - measure: percent_of_total_count
    type: percent_of_total
    sql: ${count}
  
  - measure: count_visitors
    type: count_distinct
    sql: ${looker_visitor_id}
  
  - measure: avg_sessions_per_user
    type: number
    decimals: 2
    sql: ${count}::numeric / nullif(${count_visitors}, 0)
  
  - measure: avg_session_duration_minutes
    type: average
    sql: ${session_duration_minutes}

  sets:
    detail:
      - session_id
      - looker_visitor_id
      - session_start_at
      - session_sequence_number
      - next_session_start_at


