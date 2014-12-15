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
      WHERE a1.previous_id <> a1.user_id
      )
      
      SELECT a1.previous_id
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
  
  - dimension: user_id
    label: "TRACKS User Id"
    sql: coalesce(${mapped_user_id},${tracks.user_id},${tracks.anonymous_id})
  
  - measure: count_distinct_users
    label: "TRACKS User Count"
    type: count_distinct
    sql: ${user_id}

  sets:
    detail:
      - previous_id
      - mapped_user_id

