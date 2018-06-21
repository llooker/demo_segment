view: tracks_flow {
  derived_table: {
    sql: select a.event_id
      , a.session_id
      , a.track_sequence_number
      , a.event
      , a.looker_visitor_id
      , a.received_at
      , b.event as event_2
      , c.event as event_3
      , d.event as event_4
      , e.event as event_5
from ${track_facts.SQL_TABLE_NAME} a
left join ${track_facts.SQL_TABLE_NAME} b
on a.track_sequence_number + 1 = b.track_sequence_number
and a.session_id = b.session_id
left join ${track_facts.SQL_TABLE_NAME} c
on a.track_sequence_number + 2 = c.track_sequence_number
and a.session_id = c.session_id
left join ${track_facts.SQL_TABLE_NAME} d
on a.track_sequence_number + 3 = d.track_sequence_number
and a.session_id = d.session_id
left join ${track_facts.SQL_TABLE_NAME} e
on a.track_sequence_number + 4 = e.track_sequence_number
and a.session_id = e.session_id
order by a.session_id, a.track_sequence_number
 ;;
    sql_trigger_value: select count(*) from ${sessions_trk.SQL_TABLE_NAME} ;;
    sortkeys: ["event_id", "looker_visitor_id", "session_id"]
    distribution: "looker_visitor_id"
  }

  dimension: event_id {
    primary_key: yes
    sql: ${TABLE}.event_id ;;
    hidden: yes
  }

  dimension: session_id {
    hidden: yes
    sql: ${TABLE}.session_id ;;
  }

  dimension: track_sequence_number {
    type: number
    hidden: yes
    sql: ${TABLE}.track_sequence_number ;;
  }

  dimension: event {
    #     hidden: true
    sql: ${TABLE}.event ;;
  }

  dimension: user_id {
    hidden: yes
    sql: ${TABLE}.user_id ;;
  }

  dimension_group: received_at {
    type: time
    datatype: datetime
    timeframes: [date, week, month, year]
    sql: ${TABLE}.received_at ;;
  }

  dimension: event_2 {
    label: "2nd Event"
    sql: ${TABLE}.event_2 ;;
  }

  measure: event_1_count {
    type: count
  }

  measure: event_2_drop_off {
    label: "2nd Event Remaining Count"
    type: count

    filters: {
      field: event_2
      value: "-NULL"
    }
  }

  measure: event_2_3_dropoff_percent {
    value_format_name: percent_0
    type: number
    sql: cast(${event_3_drop_off} as float)/cast(${event_2_drop_off} as float) ;;
  }

  measure: event_3_4_dropoff_percent {
    value_format_name: percent_0
    type: number
    sql: ${event_4_drop_off}/${event_3_drop_off} ;;
  }

  dimension: event_3 {
    label: "3rd Event"
    sql: ${TABLE}.event_3 ;;
  }

  measure: event_3_drop_off {
    label: "3rd Event Remaining Count"
    type: count

    filters: {
      field: event_3
      value: "-NULL"
    }
  }

  dimension: event_4 {
    label: "4th Event"
    sql: ${TABLE}.event_4 ;;
  }

  measure: event_4_drop_off {
    label: "4th Event Remaining Count"
    type: count

    filters: {
      field: event_4
      value: "-NULL"
    }
  }

  dimension: event_5 {
    label: "5th Event"
    sql: ${TABLE}.event_5 ;;
  }

  measure: event_5_drop_off {
    label: "5th Event Remaining Count"
    type: count

    filters: {
      field: event_5
      value: "-NULL"
    }
  }

  set: detail {
    fields: [
      event_id,
      session_id,
      track_sequence_number,
      event,
      user_id,
      event_2,
      event_3,
      event_4,
      event_5
    ]
  }
}
