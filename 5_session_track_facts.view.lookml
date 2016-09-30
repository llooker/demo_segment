
# Facts about a particular Session. 

- view: session_trk_facts 
  derived_table:
    sql_trigger_value: select count(*) from ${track_facts.SQL_TABLE_NAME}
    sortkeys: [session_id]
    distkey: session_id
    sql: |
      SELECT s.session_id
        , MAX(map.received_at) AS ended_at
        , count(distinct map.event_id) AS num_pvs
        , count(case when map.event = 'app_loaded' then event_id else null end) as cnt_app_loaded
        , count(case when map.event = 'login' then event_id else null end) as cnt_login
        , count(case when map.event = 'subscribed_to_blog' then event_id else null end) as cnt_subscribed_to_blog
        , count(case when map.event = 'signup' then event_id else null end) as cnt_signup
      FROM ${sessions_trk.SQL_TABLE_NAME} AS s
      LEFT JOIN ${track_facts.SQL_TABLE_NAME} as map on map.session_id = s.session_id
      GROUP BY 1
                  
                  
                  
  fields:

  - dimension: session_id
    hidden: true
    primary_key: true
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
  
  - dimension: app_loaded
    type: yesno
    sql: ${TABLE}.cnt_app_loaded > 0
  
  - dimension: login
    type: yesno
    sql: ${TABLE}.cnt_login > 0
  
  - dimension: subscribed_to_blog
    type: yesno
    sql: ${TABLE}.cnt_subscribed_to_blog > 0
    
  - dimension: signup
    type: yesno
    sql: ${TABLE}.cnt_signup > 0
  
  - measure: count_app_loaded
    type: count
    filter: 
      app_loaded: yes
      
  - measure: count_login
    type: count
    filter: 
      login: yes
  
  - measure: count_subscribed_to_blog
    type: count
    filter: 
      subscribed_to_blog: yes
  
  - measure: count_signup
    type: count
    filter: 
      signup: yes

  
  sets:
    detail:
      - user_id
      - sessionidx
      - ended_at
      - num_pvs

