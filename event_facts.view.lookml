- view: event_facts
  derived_table:
  
    # Rebuilds after sessions rebuilds
    sql_trigger_value: select count(1) from ${sessions_pg_trk.SQL_TABLE_NAME}
    sortkeys: [event_id]
    distkey: looker_visitor_id
  
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
              
        select t.event_id
          , t.event
          , t.event_source
          , s.session_id
          , t.looker_visitor_id
          , t.referrer as referrer
          , row_number() over(partition by s.session_id order by t.sent_at) as track_sequence_number
          , row_number() over(partition by s.session_id, t.event_source order by t.sent_at) as source_sequence_number
          , first_value(t.referrer ignore nulls) over (partition by s.session_id order by t.sent_at rows between unbounded preceding and unbounded following) as first_referrer
        from events as t
        inner join ${sessions_pg_trk.SQL_TABLE_NAME} as s
        on t.looker_visitor_id = s.looker_visitor_id
          and t.sent_at >= s.session_start_at
          and (t.sent_at < s.next_session_start_at or s.next_session_start_at is null)

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
  
  - dimension: first_referrer
    sql: ${TABLE}.first_referrer
  
  - dimension: first_referrer_domain
    sql: split_part(${first_referrer},'/',3)
  
  - dimension: first_referrer_domain_mapped
    sql: CASE WHEN ${first_referrer_domain} like '%facebook%' THEN 'facebook'
              WHEN ${first_referrer_domain} like '%google%' THEN 'google'
              ELSE ${first_referrer_domain} END
    
  - dimension: looker_visitor_id
    type: int
    sql: ${TABLE}.looker_visitor_id

  - dimension: sequence_number
    type: number
    sql: ${TABLE}.track_sequence_number
  
  - dimension: source_sequence_number
    type: number
    sql: ${TABLE}.source_sequence_number
  
  - measure: count_visitors
    type: count_distinct
    sql: ${looker_visitor_id}