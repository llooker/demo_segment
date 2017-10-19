view: contacts {
  sql_table_name: intercom.contacts ;;

  dimension: id {
    primary_key: yes
    type: string
    sql: ${TABLE}.id ;;
  }

  dimension: avatar_image_url {
    type: string
    sql: ${TABLE}.avatar_image_url ;;
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

  dimension: custom_job_title {
    type: string
    sql: ${TABLE}.custom_job_title ;;
  }

  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
  }

  dimension_group: last_request {
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
    sql: ${TABLE}.last_request_at ;;
  }

  dimension: last_seen_ip {
    type: string
    sql: ${TABLE}.last_seen_ip ;;
  }

  dimension: location_city_name {
    type: string
    sql: ${TABLE}.location_city_name ;;
  }

  dimension: location_continent_code {
    type: string
    sql: ${TABLE}.location_continent_code ;;
  }

  dimension: location_country_code {
    type: string
    sql: ${TABLE}.location_country_code ;;
  }

  dimension: location_country_name {
    type: string
    sql: ${TABLE}.location_country_name ;;
  }

  dimension: location_latitude {
    type: number
    sql: ${TABLE}.location_latitude ;;
  }

  dimension: location_longitude {
    type: number
    sql: ${TABLE}.location_longitude ;;
  }

  dimension: location_postal_code {
    type: string
    sql: ${TABLE}.location_postal_code ;;
  }

  dimension: location_region_name {
    type: string
    sql: ${TABLE}.location_region_name ;;
  }

  dimension: location_timezone {
    type: string
    sql: ${TABLE}.location_timezone ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
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

  dimension: session_count {
    type: number
    sql: ${TABLE}.session_count ;;
  }

  dimension: unsubscribed_from_emails {
    type: yesno
    sql: ${TABLE}.unsubscribed_from_emails ;;
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

  dimension: user_agent_data {
    type: string
    sql: ${TABLE}.user_agent_data ;;
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
      name,
      location_region_name,
      location_country_name,
      location_city_name,
      users.name,
      users.location_region_name,
      users.location_country_name,
      users.location_city_name,
      users.id,
      social_profiles.count
    ]
  }
}
