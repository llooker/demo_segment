- connection: partners_segment

- scoping: true                  # for backward compatibility
- include: "*.view.lookml"       # include all the views
- include: "*.dashboard.lookml"  # include all the dashboards

- explore: sessions_trk
  label: "Sessions"
  joins: 
    - join: session_trk_facts
      foreign_key: session_id
      relationship: one_to_one
    
    - join: user_session_facts
      foreign_key: looker_visitor_id

- explore: tracks
  joins:
    - join: track_facts
      foreign_key: event_id
    
    - join: sessions_trk
      foreign_key: track_facts.session_id
    
    - join: session_trk_facts
      foreign_key: sessions_trk.session_id
      relationship: one_to_one
    
    - join: tracks_flow
      foreign_key: event_id
    
    - join: user_session_facts
      foreign_key: track_facts.looker_visitor_id

- explore: pages
  joins:
  - join: aliases_mapping
    sql_on: aliases_mapping.alias = coalesce(pages.user_id, pages.anonymous_id)
  
  - join: page_facts
    foreign_key: event_id

- explore: funnel_explorer
  joins:
    - join: sessions_trk
      foreign_key: session_id
    
    - join: user_session_facts
      foreign_key: sessions_trk.looker_visitor_id
    
    - join: session_trk_facts
      join_type: one_to_one
      foreign_key: session_id
    
    - join: users
      sql_on: coalesce(users.mapped_user_id, users.user_id) = sessions.user_id
