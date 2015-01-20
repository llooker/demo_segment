- view: tracks
  sql_table_name: hoodie.tracks
  fields:

  - dimension: anonymous_id
    sql: ${TABLE}.anonymous_id

  - dimension: context_app_build
    sql: ${TABLE}.context_app_build

  - dimension: context_app_release_version
    sql: ${TABLE}.context_app_release_version

  - dimension: context_app_version
    sql: ${TABLE}.context_app_version

  - dimension: context_carrier
    sql: ${TABLE}.context_carrier

  - dimension: context_device_idfa
    sql: ${TABLE}.context_device_idfa

  - dimension: context_device_manufacturer
    sql: ${TABLE}.context_device_manufacturer

  - dimension: context_device_model
    sql: ${TABLE}.context_device_model

  - dimension: context_device_type
    sql: ${TABLE}.context_device_type

  - dimension: context_ip
    sql: ${TABLE}.context_ip

  - dimension: context_library_name
    sql: ${TABLE}.context_library_name

  - dimension: context_library_version
    sql: ${TABLE}.context_library_version

  - dimension: context_os
    sql: ${TABLE}.context_os

  - dimension: context_os_name
    sql: ${TABLE}.context_os_name

  - dimension: context_os_version
    sql: ${TABLE}.context_os_version

  - dimension: context_screen_height
    type: number
    sql: ${TABLE}.context_screen_height

  - dimension: context_screen_width
    type: number
    sql: ${TABLE}.context_screen_width

  - dimension: context_user_agent
    sql: ${TABLE}.context_user_agent

  - dimension: event
    sql: ${TABLE}.event

  - dimension: event_id
    primary_key: true
    sql: ${TABLE}.event_id

  - dimension: event_text
    sql: ${TABLE}.event_text

  - dimension_group: send
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.send_at

  - dimension_group: sent
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.sent_at
  
  - dimension_group: weeks_since_first_visit
    type: number
    sql: FLOOR(DATEDIFF(day,${user_track_facts.first_track_date}, ${sent_date})/7)
  
  - dimension: user_id
    hidden: true
    sql: ${TABLE}.user_id
  
  - dimension: mapped_user_id
    label: "TRACKS User Id"
    sql: coalesce(${aliases_mapping.mapped_user_id},${user_id},${anonymous_id})
  
  - measure: count_distinct_users
    label: "TRACKS User Count"
    type: count_distinct
    sql: ${mapped_user_id}


  - dimension: is_new_user
    suggest_base_view: event_list
    suggest_dimension: event_types
    sql:  |
        CASE 
        WHEN ${sent_date} = ${user_track_facts.first_track_date} THEN 'New User'
        ELSE 'Returning User' END

  - measure: count
    type: count
    drill_fields: [context_library_name, context_os_name]
  
  - measure: count_percent_of_total
    type: percent_of_total
    sql: ${count}
    decimals: 1
  
    

## Session count funnel meausures
  
  - filter: event1
    suggest_base_view: event_list
    suggest_dimension: event_types

  - measure: event1_session_count
    type: number
    sql: | 
      COUNT(
        DISTINCT(
          CASE 
            WHEN 
            {% condition event1 %} ${event} {% endcondition %} 
              THEN ${tracks_sessions_map.session_id}
            ELSE NULL END 
        )
      )

  - filter: event2
    suggest_base_view: event_list
    suggest_dimension: event_list.event_types

  - measure: event2_session_count
    type: number
    sql: | 
      COUNT(
        DISTINCT(
          CASE 
            WHEN 
            {% condition event2 %} ${event} {% endcondition %} 
              THEN ${tracks_sessions_map.session_id}
            ELSE NULL END 
        )
      )
      
  - filter: event3
    suggest_base_view: event_list
    suggest_dimension: event_list.event_types

  - measure: event3_session_count
    type: number
    sql: | 
      COUNT(
        DISTINCT(
          CASE 
            WHEN 
            {% condition event3 %} ${event} {% endcondition %} 
              THEN ${tracks_sessions_map.session_id}
            ELSE NULL END 
        )
      )
      
  - filter: event4
    suggest_base_view: event_list
    suggest_dimension: event_list.event_types

  - measure: event4_session_count
    type: number
    sql: | 
      COUNT(
        DISTINCT(
          CASE 
            WHEN 
            {% condition event4 %} ${event} {% endcondition %} 
              THEN ${tracks_sessions_map.session_id}
            ELSE NULL END 
        )
      )
