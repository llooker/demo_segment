- view: aliases_mapping
  derived_table:
    sql_trigger_value: SELECT CURRENT_DATE
    distkey: previous_id
    sortkeys: [previous_id]
    sql: |
      WITH aliases_no_dupes AS 
      
      (SELECT distinct previous_id
          , user_id 
      FROM hoodie.aliases as a1
      WHERE a1.previous_id <> a1.user_id UNION
      SELECT distinct anonymous_id as previous_id
          , user_id 
      FROM hoodie.aliases UNION
      SELECT distinct a.anonymous_id, a.user_id 
      FROM hoodie.tracks as a
      LEFT JOIN hoodie.aliases as b
      ON a.user_id = b.user_id
      WHERE b.user_id is null
      AND a.user_id is not null
      AND a.anonymous_id is not null 
      UNION
      SELECT DISTINCT a.anonymous_id as previous_id
                    , a.user_id as user_id
      FROM hoodie.tracks AS a
      LEFT JOIN hoodie.aliases AS b
      ON a.user_id = b.user_id
      WHERE b.user_id IS NULL
      AND a.anonymous_id IS NOT NULL
      AND a.user_id IS NOT NULL
      )
      
      SELECT distinct a1.previous_id
            , coalesce (a6.user_id, a5.user_id, a4.user_id, a3.user_id, a2.user_id, a1.user_id) as mapped_user_id
      FROM aliases_no_dupes AS a1
      LEFT JOIN aliases_no_dupes AS a2
      ON a1.user_id = a2.previous_id
      LEFT JOIN aliases_no_dupes AS a3
      ON a2.user_id = a3.previous_id
      LEFT JOIN aliases_no_dupes AS a4
      ON a3.user_id = a4.previous_id
      LEFT JOIN aliases_no_dupes AS a5
      ON a4.user_id = a5.previous_id
      LEFT JOIN aliases_no_dupes AS a6
      ON a5.user_id = a6.previous_id
      

  fields:

  - dimension: previous_id
    primary_key: true
    hidden: true
    sql: ${TABLE}.previous_id

  - dimension: mapped_user_id
    hidden: true
    sql: ${TABLE}.mapped_user_id
  
  sets:
    detail:
      - previous_id
      - mapped_user_id

