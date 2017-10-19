view: conversations {
  sql_table_name: intercom.conversations ;;

  dimension: id {
    primary_key: yes
    type: string
    sql: ${TABLE}.id ;;
  }

  dimension: _open {
    type: yesno
    sql: ${TABLE}._open ;;
  }

  dimension: assignee_id {
    type: string
    sql: ${TABLE}.assignee_id ;;
  }

  dimension: assignee_type {
    type: string
    sql: ${TABLE}.assignee_type ;;
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

  dimension: message_author_id {
    type: string
    sql: ${TABLE}.message_author_id ;;
  }

  dimension: message_author_type {
    type: string
    sql: ${TABLE}.message_author_type ;;
  }

  dimension: message_body {
    type: string
    sql: ${TABLE}.message_body ;;
  }

  dimension: message_subject {
    type: string
    sql: ${TABLE}.message_subject ;;
  }

  dimension: parts {
    type: string
    sql: ${TABLE}.parts ;;
  }

  dimension: read {
    type: yesno
    sql: ${TABLE}.read ;;
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

  dimension: tags {
    type: string
    sql: ${TABLE}.tags ;;
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

  dimension: user_id {
    type: string
    # hidden: yes
    sql: ${TABLE}.user_id ;;
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
    drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id,
      users.name,
      users.location_region_name,
      users.location_country_name,
      users.location_city_name,
      users.id,
      conversation_parts.count
    ]
  }
}
