- view: track_facts # Determines event sequence numbers within session

  derived_table:
    sql: |
      
        select t.event_id
            , t.event
            , s.session_id
            , t.looker_visitor_id
            , row_number() over(partition by s.session_id order by t.sent_at) as track_sequence_number
          from ${mapped_tracks.SQL_TABLE_NAME} as t
          inner join ${sessions_trk.SQL_TABLE_NAME} as s
          on t.looker_visitor_id = s.looker_visitor_id
            and t.sent_at >= s.session_start_at
            and (t.sent_at < s.next_session_start_at or s.next_session_start_at is null)


    sql_trigger_value: select count(1) from ${sessions_trk.SQL_TABLE_NAME}
    sortkeys: [event_id]
    distkey: looker_visitor_id
    
  fields:

  - dimension: event_id
    primary_key: true
    hidden: true
    sql: ${TABLE}.event_id
  
  - dimension: event
    hidden: true
    sql: ${TABLE}.event

  - dimension: session_id
    sql: ${TABLE}.session_id
    
  - dimension: looker_visitor_id
    sql: ${TABLE}.looker_visitor_id

  - dimension: sequence_number
    type: number
    sql: ${TABLE}.track_sequence_number
  
  - measure: count_visitors
    type: count_distinct
    sql: ${looker_visitor_id}


