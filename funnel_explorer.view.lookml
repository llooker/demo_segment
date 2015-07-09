- view: funnel_explorer

# Or, you could make this view a derived table, like this:
  derived_table:
    sql: |
      SELECT sessions.session_id as session_id
        , MIN(
            CASE WHEN
              {% condition event1 %} tracks.event {% endcondition %} 
              THEN tracks.sent_at
              ELSE NULL END
            ) as event1_time
        , MIN(
            CASE WHEN
              {% condition event2 %} tracks.event {% endcondition %} 
              THEN tracks.sent_at
              ELSE NULL END
            ) as event2_time
        , MIN(
            CASE WHEN
              {% condition event3 %} tracks.event {% endcondition %} 
              THEN tracks.sent_at
              ELSE NULL END
            ) as event3_time
      FROM hoodie.tracks as tracks
      LEFT JOIN ${aliases_mapping.SQL_TABLE_NAME} as aliases_mapping
        ON aliases_mapping.alias = coalesce(tracks.user_id, tracks.anonymous_id)
      LEFT JOIN ${track_facts.SQL_TABLE_NAME} as tracks_sessions_map
        ON tracks.event_id = tracks_sessions_map.event_id      
      LEFT JOIN ${sessions_trk.SQL_TABLE_NAME} as sessions
        ON tracks_sessions_map.session_id = sessions.session_id
      GROUP BY 1

  fields:
    - filter: event1
      suggestions: [added_item, app_became_active, app_entered_background, 
                app_entered_foreground, app_launched, app_resigned_active,
                asked_for_sizes, completed_order, failed_auth_validation, logged_in,
                made_purchase, payment_available, payment_failed, payment_form_shown,
                payment_form_submitted, removed_item, saved_sizes, shipping_available,
                shipping_form_failed, shipping_form_shown, shipping_form_submitted,
                signed_up, submitted_order, switched_auth_forms, tapped_shipit,
                view_buy_page, viewed_auth_page]

    - filter: event2
      suggestions: [added_item, app_became_active, app_entered_background, 
                app_entered_foreground, app_launched, app_resigned_active,
                asked_for_sizes, completed_order, failed_auth_validation, logged_in,
                made_purchase, payment_available, payment_failed, payment_form_shown,
                payment_form_submitted, removed_item, saved_sizes, shipping_available,
                shipping_form_failed, shipping_form_shown, shipping_form_submitted,
                signed_up, submitted_order, switched_auth_forms, tapped_shipit,
                view_buy_page, viewed_auth_page]

    - filter: event3
      suggestions: [added_item, app_became_active, app_entered_background, 
                app_entered_foreground, app_launched, app_resigned_active,
                asked_for_sizes, completed_order, failed_auth_validation, logged_in,
                made_purchase, payment_available, payment_failed, payment_form_shown,
                payment_form_submitted, removed_item, saved_sizes, shipping_available,
                shipping_form_failed, shipping_form_shown, shipping_form_submitted,
                signed_up, submitted_order, switched_auth_forms, tapped_shipit,
                view_buy_page, viewed_auth_page]

    - dimension: session_id
      type: string
      primary_key: TRUE
      sql: ${TABLE}.session_id

    - dimension: event1
      type: time
      timeframes: [time]
      sql: ${TABLE}.event1_time

    - dimension: event2
      type: time
      timeframes: [time]
      sql: ${TABLE}.event2_time

    - dimension: event3
      type: time
      timeframes: [time]
      sql: ${TABLE}.event3_time
    
    - dimension: event1_before_event2
      type: yesno
      sql: ${event1_time} < ${event2_time}

    - dimension: event2_before_event3
      type: yesno
      sql: ${event2_time} < ${event3_time}

    - measure: count_sessions
      type: count
      sql: ${session_id}

    - measure: count_sessions_event1
      type: count
      sql: ${session_id}
      filters: 
        event1_time: NOT NULL
    
    - measure: count_sessions_event12
      type: count
      sql: ${session_id}
      filters: 
        event1_time: NOT NULL
        event2_time: NOT NULL
        event1_before_event2: TRUE

    - measure: count_sessions_event123  
      type: count
      sql: ${session_id}
      filters: 
        event1_time: NOT NULL
        event2_time: NOT NULL
        event3_time: NOT NULL
        event1_before_event2: TRUE
        event2_before_event3: TRUE
