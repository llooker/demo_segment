view: conversation_parts {
  sql_table_name: intercom.conversation_parts ;;

  dimension: id {
    primary_key: yes
    type: string
    sql: ${TABLE}.id ;;
  }

  dimension: assigned_to_id {
    type: string
    sql: ${TABLE}.assigned_to_id ;;
  }

  dimension: assigned_to_type {
    type: string
    sql: ${TABLE}.assigned_to_type ;;
  }

  dimension: author_id {
    type: string
    sql: ${TABLE}.author_id ;;
  }

  dimension: author_type {
    type: string
    sql: ${TABLE}.author_type ;;
  }

  dimension: body {
    type: string
    sql: ${TABLE}.body ;;
  }

  dimension: conversation_id {
    type: string
    # hidden: yes
    sql: ${TABLE}.conversation_id ;;
  }

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.created_at ;;
  }

  dimension_group: notified {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.notified_at ;;
  }

  dimension: part_type {
    type: string
    sql: ${TABLE}.part_type ;;
  }

  dimension_group: received {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.received_at ;;
  }

  dimension_group: updated {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.updated_at ;;
  }

  dimension: uuid {
    type: number
    value_format_name: id
    sql: ${TABLE}.uuid ;;
  }

  dimension_group: uuid_ts {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.uuid_ts ;;
  }

  measure: count {
    type: count
    drill_fields: [id, conversations.id]
  }
}
