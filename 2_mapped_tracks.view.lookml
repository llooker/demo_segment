## Intermediate Table

- view: mapped_tracks
  derived_table:
    sortkeys: [event_id]
    distkey: looker_visitor_id  
    sql_trigger_value: select current_date
    sql: |
      select *
        , datediff(minutes, lag(sent_at) over(partition by looker_visitor_id order by sent_at), sent_at) as idle_time_minutes
        from (
          select t.event_id as event_id
          , t.anonymous_id
          , a2v.looker_visitor_id
          , t.sent_at
          , t.event as event
          from hoodie.tracks as t
          inner join ${aliases_mapping.SQL_TABLE_NAME} as a2v
          on a2v.alias = coalesce(t.user_id, t.anonymous_id)
        )
                        

  fields:

  - dimension: anonymous_id
    sql: ${TABLE}.anonymous_id
    
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

  - dimension: idle_time_minutes
    type: number
    sql: ${TABLE}.idle_time_minutes

  sets:
    detail:
      - event_id
      - looker_visitor_id
      - sent_at
      - event
      - idle_time_minutes

