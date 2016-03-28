- view: mapped_events
  derived_table:
    persist_for: 4 hours
    sortkeys: [event_id]
    distkey: looker_visitor_id
    sql: |
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
          on a2v.alias = coalesce(t.user_id, t.anonymous_id)                      
      ) as e 
                      

  fields:

  - dimension: event_id
    sql: ${TABLE}.event_id

  - dimension: looker_visitor_id
    sql: ${TABLE}.looker_visitor_id

  - dimension_group: sent_at
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.sent_at

  - dimension: event
    sql: ${TABLE}.event

  - dimension: referrer
    sql: ${TABLE}.referrer

  - dimension: event_source
    sql: ${TABLE}.event_source

  - dimension: idle_time_minutes
    type: number
    sql: ${TABLE}.idle_time_minutes

  sets:
    detail:
      - event_id
      - looker_visitor_id
      - sent_at
      - event
      - referrer
      - event_source
      - idle_time_minutes

