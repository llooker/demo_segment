- explore: funnel
- view: funnel
  derived_table:
    sql: |
      SELECT 
        step1.user_id as user_id
        , step1.sessionidx as sessionidx
        , step1.seq_num as step1
        , step2.seq_num as step2
        , step3.seq_num as step3
        , step4.seq_num as step4
        
      FROM
        (select user_id, sessionidx, min(sess_pv_seq_num) as seq_num 
        FROM ${tracks_sessions_map.SQL_TABLE_NAME}
        where event = 'view_buy_page'
        group by 1,2) as step1
      LEFT JOIN
        (select user_id, sessionidx, min(sess_pv_seq_num) as seq_num 
         FROM ${tracks_sessions_map.SQL_TABLE_NAME}
        where event = 'added_item'
        group by 1,2) as step2
      ON step1.user_id = step2.user_id and step1.sessionidx = step2.sessionidx
      LEFT JOIN  
        (select user_id, sessionidx, min(sess_pv_seq_num) as seq_num 
        FROM ${tracks_sessions_map.SQL_TABLE_NAME}
        where event = 'tapped_shipit'
        group by 1,2) as step3
      ON step2.user_id = step3.user_id and step2.sessionidx = step3.sessionidx
      LEFT JOIN  
        (select user_id, sessionidx, min(sess_pv_seq_num) as seq_num 
        FROM ${tracks_sessions_map.SQL_TABLE_NAME}
        where event = 'made_purchase'
        group by 1,2) as step4
      ON step3.user_id = step4.user_id and step3.sessionidx = step4.sessionidx
      

  fields:

  - dimension: user_id
    sql: ${TABLE}.user_id

  - dimension: sessionidx
    type: number
    hidden: true
    sql: ${TABLE}.sessionidx

  - dimension: step1
    type: yesno
    sql: ${TABLE}.step1 is not null

  - dimension: step2
    type: yesno
    sql: ${TABLE}.step2 is not null


  - dimension: step3
    type: yesno
    sql: ${TABLE}.step3 is not null


  - dimension: step4
    type: yesno
    sql: ${TABLE}.step4 is not null
  
  - dimension: session_id
    sql: ${user_id}||${sessionidx}
    
  - measure: session_count
    type: count_distinct
    sql: ${session_id}
    
  - measure: step1_count
    label: 'View Buy Page'
    type: count_distinct
    sql: ${session_id}
    filter:
      step1: yes
  
  - measure: step2_count
    label: 'Add Item'
    type: count_distinct
    sql: ${session_id}
    filter:
      step2: yes
  
  - measure: step3_count
    label: 'Tap ShipIt'
    type: count_distinct
    sql: ${session_id}
    filter:
      step3: yes
  
  - measure: step4_count
    label: 'Made Purchase'
    type: count_distinct
    sql: ${session_id}
    filter:
      step4: yes