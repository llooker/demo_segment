# Derived Table of Event Names used for Filter Suggestions

- view: event_list
  derived_table:
    persist_for: 24 hours
    sortkeys: [event_types]
    distkey: event_types
    sql: |
      SELECT
        event as event_types
      FROM hoodie.tracks
      GROUP BY 1
      ORDER BY 1
    
  fields:
  
  - dimension: event_types
    type: string
    sql: ${TABLE}.event_types