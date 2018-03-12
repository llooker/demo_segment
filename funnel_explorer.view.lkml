view: funnel_explorer {
  derived_table: {
    sql: SELECT tracks_sessions_map.session_id as session_id
        , MIN(
            CASE WHEN
              {% condition event1 %} tracks_sessions_map.event {% endcondition %}
              THEN tracks_sessions_map.received_at
              ELSE NULL END
            ) as event1_time
        , MIN(
            CASE WHEN
              {% condition event2 %} tracks_sessions_map.event {% endcondition %}
              THEN tracks_sessions_map.received_at
              ELSE NULL END
            ) as event2_time
        , MIN(
            CASE WHEN
              {% condition event3 %} tracks_sessions_map.event {% endcondition %}
              THEN tracks_sessions_map.received_at
              ELSE NULL END
            ) as event3_time
      FROM ${track_facts.SQL_TABLE_NAME} as tracks_sessions_map
      GROUP BY 1
       ;;
  }

  filter: event1 {
    suggest_explore: event_list
    suggest_dimension: event_list.event_types
  }

  filter: event2 {
    suggest_explore: event_list
    suggest_dimension: event_list.event_types
  }

  filter: event3 {
    suggest_explore: event_list
    suggest_dimension: event_list.event_types
  }

  dimension: session_id {
    type: string
    primary_key: yes
    sql: ${TABLE}.session_id ;;
  }

  dimension_group: event1 {
    type: time
    timeframes: [raw, time]
    sql: ${TABLE}.event1_time ;;
  }

  dimension_group: event2 {
    type: time
    timeframes: [raw, time]
    sql: ${TABLE}.event2_time ;;
  }

  dimension_group: event3 {
    type: time
    timeframes: [raw, time]
    sql: ${TABLE}.event3_time ;;
  }

  dimension: event1_before_event2 {
    type: yesno
    sql: ${event1_time} < ${event2_time} ;;
  }

  dimension: event2_before_event3 {
    type: yesno
    sql: ${event2_time} < ${event3_time} ;;
  }

  dimension: minutes_in_funnel {
    type: number
    sql: datediff(min,${event1_raw},COALESCE(${event3_raw},${event2_raw})) ;;
  }

  measure: count_sessions {
    type: count_distinct
    sql: ${session_id} ;;
  }

  measure: count_sessions_event1 {
    type: count_distinct
    sql: ${session_id} ;;

    filters: {
      field: event1_time
      value: "NOT NULL"
    }
  }

  measure: count_sessions_event12 {
    type: count_distinct
    sql: ${session_id} ;;

    filters: {
      field: event1_time
      value: "NOT NULL"
    }

    filters: {
      field: event2_time
      value: "NOT NULL"
    }

    filters: {
      field: event1_before_event2
      value: "true"
    }
  }

  measure: count_sessions_event123 {
    type: count_distinct
    sql: ${session_id} ;;

    filters: {
      field: event1_time
      value: "NOT NULL"
    }

    filters: {
      field: event2_time
      value: "NOT NULL"
    }

    filters: {
      field: event3_time
      value: "NOT NULL"
    }

    filters: {
      field: event1_before_event2
      value: "true"
    }

    filters: {
      field: event2_before_event3
      value: "true"
    }
  }
}
