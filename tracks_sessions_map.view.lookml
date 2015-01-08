- view: tracks_sessions_map # Determines event sequence numbers within session

  derived_table:
    sql: |
      select pv.event_id
        , pv.event
        , s.user_id
        , s.session_id
        , row_number() over(partition by s.user_id, s.sessionidx order by pv.sent_at) as sess_pv_seq_num
      from ${mapped_tracks.SQL_TABLE_NAME} pv
      inner join ${sessions.SQL_TABLE_NAME}  as  s
        on pv.user_id = s.user_id
        and pv.sent_at >= s.session_start
        and pv.sent_at < s.next_session_start


    sql_trigger_value: select count(*) from ${sessions.SQL_TABLE_NAME}
    sortkeys: [event_id, user_id, session_id]
    distkey: user_id
    
  fields:
  - measure: count
    type: count
    hidden: true
    drill_fields: detail*

  - dimension: event_id
    primary_key: true
    hidden: true
    sql: ${TABLE}.event_id
  
  - dimension: event
    hidden: true
    sql: ${TABLE}.event
  
  - dimension: user_id
    hidden: true
    sql: ${TABLE}.user_id

  - dimension: session_id
    hidden: true
    type: number
    sql: ${TABLE}.session_id

  - dimension: sess_pv_seq_num
    label: 'TRACKS Session Event Sequence Number'
    type: number
    sql: ${TABLE}.sess_pv_seq_num


