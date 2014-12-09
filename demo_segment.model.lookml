- connection: partners_segment

- scoping: true                  # for backward compatibility
- include: "*.view.lookml"       # include all the views
- include: "*.dashboard.lookml"  # include all the dashboards

- explore: aliases

- explore: identifies

- explore: pages
  joins: 
    - join: user_page_facts
      foreign_key: user_id
    
    - join: page_facts
      foreign_key: event_id

- explore: tracks
  joins:
    - join: aliases
      foreign_key: user_id
    
    - join: user_track_facts
      foreign_key: user_id

- explore: sessions
  joins: 
    - join: user_track_facts
      foreign_key: user_id
    
    - join: session_facts
      sql_on: |
        sessions.user_id = session_facts.user_id
        AND
        sessions.sessionidx = session_facts.sessionidx
      join_type: one_to_one
