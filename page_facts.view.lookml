- view: page_facts
  derived_table:
    sql_trigger_value: SELECT CURRENT_DATE
    distkey: event_id
    sortkeys: [event_id]
    sql: |
      SELECT e.event_id AS event_id
            , CASE 
                WHEN DATEDIFF(seconds, e.sent_at, LEAD(e.sent_at) OVER(PARTITION BY e.user_id ORDER BY e.sent_at)) > 30*60 THEN NULL 
                ELSE DATEDIFF(seconds, e.sent_at, LEAD(e.sent_at) OVER(PARTITION BY e.user_id ORDER BY e.sent_at)) END AS lead_idle_time_condition
      FROM hoodie.pages AS e
      WHERE user_id is not null
      order by e.sent_at

  fields:

  - dimension: event_id
    hidden: true
    primary_key: true
    sql: ${TABLE}.event_id

  - dimension: duration_page_view_seconds
    type: number
    sql: ${TABLE}.lead_idle_time_condition
  
  - dimension: is_last_page
    type: yesno
    sql: 
      ${duration_page_view_seconds} is NULL

  sets:
    detail:
      - event_id
      - lead_idle_time_condition

