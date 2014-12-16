- view: mapped_pages  # Tracks mapped to user id
  derived_table:
    sql_trigger_value: SELECT CURRENT_DATE
    distkey: event_id
    sortkeys: [event_id]  
    sql:  |
          SELECT event_id 
                 , coalesce(e2.mapped_user_id, e1.user_id, e1.anonymous_id) as user_id
                 , url
                 , sent_at
          FROM hoodie.pages AS e1
          LEFT JOIN ${aliases_mapping.SQL_TABLE_NAME} AS e2
          ON coalesce(e1.user_id, e1.anonymous_id) = e2.previous_id  


- view: user_page_facts
  derived_table:
    sql_trigger_value: SELECT CURRENT_DATE
    distkey: user_id
    sortkeys: [user_id]  
    sql: |
      SELECT user_id, as user_id
              , count(distinct url) count_distinct_page_views
              , count(*) count_page_views
      FROM ${SQL_TABLE_NAME.mapped_pages}
      WHERE user_id IS NOT NULL
      GROUP BY 1 

  fields:

  - dimension: user_id
    primary_key: true
    sql: ${TABLE}.user_id

  - dimension: count_distinct_page_views
    type: number
    sql: ${TABLE}.count_distinct_page_views

  - dimension: count_page_views
    type: number
    sql: ${TABLE}.count_page_views

  sets:
    detail:
      - user_id
      - count_distinct_page_views
      - count_page_views

