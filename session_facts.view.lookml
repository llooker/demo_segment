- view: session_facts 
  derived_table:
    sql: |
      SELECT s.user_id
        , s.sessionidx
        , LEAST(MAX(pv.sent_at) + INTERVAL '30 minutes', s.next_session_start) AS ended_at
        , count(distinct pv.event_id) AS num_pvs
        , count(case when pv.event = 'view_buy_page' then event_id else null end) as cnt_view_buy_page
        , count(case when pv.event = 'added_item' then event_id else null end) as cnt_added_item
        , count(case when pv.event = 'tapped_shipit' then event_id else null end) as cnt_shipit
        , count(case when pv.event = 'made_purchase' then event_id else null end) as cnt_made_purchase
      FROM ${sessions.SQL_TABLE_NAME} AS s
        LEFT JOIN ${tracks_sessions_map.SQL_TABLE_NAME} as map USING(user_id, sessionidx)
        LEFT JOIN ${mapped_tracks.SQL_TABLE_NAME} pv USING(event_id)
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
  
  - dimension: view_buy_page
    type: yesno
    sql: ${TABLE}.cnt_view_buy_page > 0
  
  - dimension: added_item
    type: yesno
    sql: ${TABLE}.cnt_added_item > 0
  
  - dimension: tapped_shipit
    type: yesno
    sql: ${TABLE}.cnt_shipit > 0
    
  - dimension: made_purchase
    type: yesno
    sql: ${TABLE}.cnt_made_purchase > 0


  
  sets:
    detail:
      - user_id
      - sessionidx
      - ended_at
      - num_pvs

