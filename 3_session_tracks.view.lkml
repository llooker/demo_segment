# Define Session Time Out Value
# Intermediate Tables

view: sessions_trk {
  derived_table: {
    sql_trigger_value: select count(*) from ${mapped_tracks.SQL_TABLE_NAME} ;;
    sortkeys: ["session_id"]
    distribution: "looker_visitor_id"
    sql: select row_number() over(partition by looker_visitor_id order by received_at) || ' - ' || looker_visitor_id as session_id
      , looker_visitor_id
      , received_at as session_start_at
      , row_number() over(partition by looker_visitor_id order by received_at) as session_sequence_number
      , lead(received_at) over(partition by looker_visitor_id order by received_at) as next_session_start_at
from ${mapped_tracks.SQL_TABLE_NAME}
where (idle_time_minutes > 30 or idle_time_minutes is null)
 ;;
  }

  dimension: session_id {
    primary_key: yes
    sql: ${TABLE}.session_id ;;
  }

  dimension: looker_visitor_id {
    type: string
    sql: ${TABLE}.looker_visitor_id ;;
  }

  dimension_group: start {
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.session_start_at ;;
  }

  dimension: sequence_number {
    type: number
    sql: ${TABLE}.session_sequence_number ;;
  }

  dimension: is_first_session {
    #     type: yesno
    sql: CASE WHEN ${sequence_number} = 1 THEN 'First Session'
           ELSE 'Repeat Session'
      END
       ;;
  }

  dimension_group: next_session_start_at {
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.next_session_start_at ;;
  }

  dimension: session_duration_minutes {
    type: number
    sql: DATEDIFF(minutes, ${start_time}::timestamp, ${session_trk_facts.ended_at_time}::timestamp) ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  measure: percent_of_total_count {
    type: percent_of_total
    sql: ${count} ;;
  }

  measure: count_visitors {
    type: count_distinct
    sql: ${looker_visitor_id} ;;
  }

  measure: avg_sessions_per_user {
    type: number
    value_format_name: decimal_2
    sql: ${count}::numeric / nullif(${count_visitors}, 0) ;;
  }

  measure: avg_session_duration_minutes {
    type: average
    sql: ${session_duration_minutes} ;;
    value_format_name: decimal_1
  }

  set: detail {
    fields: [session_id, looker_visitor_id, start_date, sequence_number, next_session_start_at_date]
  }
}
