## NEEDS WORK -- should be based off of session pg facts and mapped_event ###

- view: page_facts
  derived_table:
    sortkeys: [event_id]
    distkey: looker_visitor_id  
    sql_trigger_value: select count(*) from ${mapped_events.SQL_TABLE_NAME}
    sql: |
      SELECT e.event_id AS event_id
            , e.looker_visitor_id
            , CASE 
                WHEN DATEDIFF(seconds, e.sent_at, LEAD(e.sent_at) OVER(PARTITION BY e.looker_visitor_id ORDER BY e.sent_at)) > 30*60 THEN NULL 
                ELSE DATEDIFF(seconds, e.sent_at, LEAD(e.sent_at) OVER(PARTITION BY e.looker_visitor_id ORDER BY e.sent_at)) END AS lead_idle_time_condition
      FROM ${mapped_events.SQL_TABLE_NAME} AS e
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
  
  - dimension: looker_visitor_id

  sets:
    detail:
      - event_id
      - lead_idle_time_condition

