- view: session_pg_trk_facts
  derived_table:
    
    # Rebuilds after track_facts rebuilds
    sql_trigger_value: select max(event_id) from ${event_facts.SQL_TABLE_NAME}
    sortkeys: [session_id]
    distkey: session_id
  
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
              
      select s.session_id
        , first_referrer
        , least(max(t.sent_at) + interval '30 minutes', min(s.next_session_start_at)) as end_at
        , count(case when t.event_source = 'tracks' then 1 else null end) as tracks_count
      from ${sessions_pg_trk.SQL_TABLE_NAME} as s
        inner join ${event_facts.SQL_TABLE_NAME} as t2s
          using(session_id)
        inner join events as t
          using(event_id)
      group by 1,2


  fields:

  
  # ----- Dimensions -----

  - dimension: session_id
    primary_key: true
    sql: ${TABLE}.session_id
  
  - dimension: first_referrer
    sql: ${TABLE}.first_referrer
    
  - dimension: first_referrer_domain
    sql: split_part(${first_referrer},'/',3)
  
  - dimension: first_referrer_domain_mapped
    sql: CASE WHEN ${first_referrer_domain} like '%facebook%' THEN 'facebook'
              WHEN ${first_referrer_domain} like '%google%' THEN 'google'
              ELSE ${first_referrer_domain} END
    
  - dimension_group: end
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.end_at

  - dimension: tracks_count
    type: number
    sql: ${TABLE}.tracks_count
  
  - dimension: referrer
    type: number
    sql: ${TABLE}.referrer
  
  - dimension: tracks_count_tier
    type: tier
    sql: ${tracks_count}
    tiers: [1,5,10,20,30,60]

  - dimension: is_bounced_session
    sql:  |
      CASE WHEN ${tracks_count} = 1 THEN 'Bounced Session'
      ELSE 'Not Bounced Session' END
  
  - dimension: session_duration_minutes
    type: number
    sql: datediff(minutes, ${sessions_pg_trk.start_time}::timestamp, ${end_time}::timestamp)
    
  - dimension: session_duration_minutes_tiered
    type: tier
    sql: ${session_duration_minutes}
    tiers: [1,5,10,20,30,60]
  
  
  # ----- Measures -----
  
  - measure: avg_session_duration_minutes
    type: average
    decimals: 1
    sql: ${session_duration_minutes}::float
    filter:
      session_duration_minutes: '> 0' 
  
  - measure: avg_tracks_per_session
    type: average
    decimals: 1
    sql: ${tracks_count}::float
  
  - measure: count_sessions_with_donation
    type: count
    filter: 
      made_donation: yes
  
  - measure: percent_sessions_with_donation
    type: number
    format: '%.2f%'
    sql: (${count_sessions_with_donation}::float/NULLIF(${sessions.count},0))*100
    
    