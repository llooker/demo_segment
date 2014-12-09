- view: tracks_sessions_map # Determines event sequence numbers within session

  derived_table:
    sql: |
            select pv.event_id
              , s.user_id
              , s.sessionidx
              , row_number() over(partition by s.user_id, s.sessionidx order by pv.sent_at) as sess_pv_seq_num
            from hoodie.tracks pv
            inner join ${sessions.SQL_TABLE_NAME}  as  s
              on pv.user_id = s.user_id
              and pv.sent_at >= s.session_start
              and pv.sent_at < s.next_session_start


    sql_trigger_value: select count(*) from ${sessions.SQL_TABLE_NAME}
    sortkeys: [event_id, user_id, sessionidx]
    distkey: user_id
    
  fields:
  - measure: count
    type: count
    drill_fields: detail*

  - dimension: event_id
    sql: ${TABLE}.event_id

  - dimension: user_id
    sql: ${TABLE}.user_id

  - dimension: sessionidx
    type: number
    sql: ${TABLE}.sessionidx

  - dimension: sess_pv_seq_num
    type: number
    sql: ${TABLE}.sess_pv_seq_num


