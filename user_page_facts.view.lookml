- view: user_page_facts
  derived_table:
    sql: |
      SELECT user_id
              , count(distinct url) count_distinct_page_views
              , count(*) count_page_views
      FROM hoodie.pages 
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

