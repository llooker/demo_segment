view: event_facts {
  derived_table: {
    # Rebuilds after sessions rebuilds
    sql_trigger_value: select count(*) from ${sessions_pg_trk.SQL_TABLE_NAME} ;;
    sortkeys: ["event_id"]
    distribution: "event_id"
    sql: select t.received_at
        , t.anonymous_id
        , t.event_id
        , t.uuid as uuid
        , t.event_source
        , s.session_id
        , t.looker_visitor_id
        , t.referrer as referrer
        , row_number() over(partition by s.session_id order by t.received_at) as track_sequence_number
        , row_number() over(partition by s.session_id, t.event_source order by t.received_at) as source_sequence_number
        , first_value(t.referrer ignore nulls) over (partition by s.session_id order by t.received_at rows between unbounded preceding and unbounded following) as first_referrer
      from ${mapped_events.SQL_TABLE_NAME} as t
      left join ${sessions_pg_trk.SQL_TABLE_NAME} as s
      on t.looker_visitor_id = s.looker_visitor_id
        and t.received_at >= s.session_start_at
        and (t.received_at < s.next_session_start_at or s.next_session_start_at is null)
       ;;
  }

  dimension: event_id {
    primary_key: yes
    #     hidden: true
    sql: ${TABLE}.event_id ;;
  }

  dimension: uuid {
    type: string
    sql: ${TABLE}.uuid ;;
  }

  dimension: session_id {
    sql: ${TABLE}.session_id ;;
  }

  dimension: first_referrer {
    sql: ${TABLE}.first_referrer ;;
  }

  dimension: first_referrer_domain {
    sql: split_part(${first_referrer},'/',3) ;;
  }

  dimension: first_referrer_domain_mapped {
    sql: CASE WHEN ${first_referrer_domain} like '%facebook%' THEN 'facebook' WHEN ${first_referrer_domain} like '%google%' THEN 'google' ELSE ${first_referrer_domain} END ;;
  }

  dimension: looker_visitor_id {
    type: string
    sql: ${TABLE}.looker_visitor_id ;;
  }

  dimension: anonymous_id {
    type: string
    sql: ${TABLE}.anonymous_id ;;
  }

  dimension: sequence_number {
    type: number
    sql: ${TABLE}.track_sequence_number ;;
  }

  dimension: source_sequence_number {
    type: number
    sql: ${TABLE}.source_sequence_number ;;
  }

  measure: count_visitors {
    type: count_distinct
    sql: ${looker_visitor_id} ;;
  }
}
