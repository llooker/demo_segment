- view: session_trk_facts 
  derived_table:
    sql: |

      SELECT s.session_id
        , LEAST(MAX(pv.sent_at) + INTERVAL '30 minutes', min(s.next_session_start_at)) AS ended_at
        , count(distinct pv.event_id) AS num_pvs
        , count(case when pv.event = 'view_buy_page' then event_id else null end) as cnt_view_buy_page
        , count(case when pv.event = 'added_item' then event_id else null end) as cnt_added_item
        , count(case when pv.event = 'tapped_shipit' then event_id else null end) as cnt_shipit
        , count(case when pv.event = 'made_purchase' then event_id else null end) as cnt_made_purchase
      FROM ${sessions_trk.SQL_TABLE_NAME} AS s
      LEFT JOIN ${track_facts.SQL_TABLE_NAME} as map USING(session_id)
      LEFT JOIN ${mapped_tracks.SQL_TABLE_NAME} pv USING(event_id)
      GROUP BY 1
                  
    sql_trigger_value: select count(1) from ${track_facts.SQL_TABLE_NAME}
    sortkeys: [session_id]
    distkey: session_id

  fields:

  - dimension: session_id
    hidden: true
    primary_key: true
    type: number
    sql: ${TABLE}.session_id

  - dimension_group: ended_at
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.ended_at

  - dimension: number_events
    type: number
    sql: ${TABLE}.num_pvs
  
  - dimension: is_bounced_session
    type: yesno
    sql: ${number_events} = 1
  
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
  
  - measure: count_view_buy_page
    type: count
    filter: 
      view_buy_page: yes
      
  - measure: count_added_item
    type: count
    filter: 
      added_item: yes
  
  - measure: count_tapped_shipit
    type: count
    filter: 
      tapped_shipit: yes
  
  - measure: count_made_purchase
    type: count
    filter: 
      made_purchase: yes


  
  sets:
    detail:
      - user_id
      - sessionidx
      - ended_at
      - num_pvs

