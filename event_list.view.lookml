- view: event_list

  derived_table:
    persist_for: 24 hours
    sortkeys: [event_types]
    distkey: event_types
    sql: |
      SELECT
        DISTINCT(event) as event_types
      FROM hoodie.tracks
      GROUP BY 1
      ORDER BY 1
    
  fields:
  
  - dimension: event_types