- view: sessions_pg_trk
  derived_table:
    sql_trigger_value: select count(1) from ${aliases_mapping.SQL_TABLE_NAME}
    sortkeys: [session_id]
    distkey: looker_visitor_id
    sql: |
      WITH events AS (
        select *
          , datediff(minutes, lag(sent_at) over(partition by looker_visitor_id order by sent_at), sent_at) as idle_time_minutes
        from (
                select t.event_id || '-t' as event_id
                  , a2v.looker_visitor_id
                  , t.sent_at
                  , t.event as event
                  , NULL as referrer
                  , 'tracks' as event_source
                from hoodie.tracks as t
                inner join ${aliases_mapping.SQL_TABLE_NAME} as a2v
                on a2v.alias = coalesce(t.user_id, t.anonymous_id)
                union all
                select t.event_id || '-p' as event_id
                  , a2v.looker_visitor_id
                  , t.sent_at
                  , t.path as event
                  , t.referrer as referrer
                  , 'pages' as event_source
                from hoodie.pages as t
                inner join ${aliases_mapping.SQL_TABLE_NAME} as a2v
                on a2v.alias = coalesce(t.user_id, t.anonymous_id)) as e 
              )
      
        select event_id as session_id
              , looker_visitor_id
              , sent_at as session_start_at
              , row_number() over(partition by looker_visitor_id order by sent_at) as session_sequence_number
              , lead(sent_at) over(partition by looker_visitor_id order by sent_at) as next_session_start_at
        from events
        where (idle_time_minutes > 30 or idle_time_minutes is null)
            

  fields:
  - measure: count
    type: count
    drill_fields: detail*

  - dimension: session_id
    sql: ${TABLE}.session_id

  - dimension: looker_visitor_id
    type: number
    sql: ${TABLE}.looker_visitor_id

  - dimension_group: session_start_at
    type: time
    timeframes: [time, date, week, month]
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

