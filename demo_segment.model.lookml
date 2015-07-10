- connection: partners_segment

- scoping: true                  # for backward compatibility
- include: "*.view.lookml"       # include all the views
- include: "*.dashboard.lookml"  # include all the dashboards

- explore: sessions_trk
  view_label: sessions
  joins: 
    - join: session_trk_facts
      view_label: sessions
      foreign_key: session_id
      relationship: one_to_one
    
    - join: user_session_facts
      view_label: users
      foreign_key: looker_visitor_id

- explore: tracks
  view_label: events
  joins:
    - join: track_facts
      view_label: events
      relationship: many_to_one
      sql_on: |
        tracks.event_id = track_facts.event_id and 
        tracks.sent_at = track_facts.sent_at and
        tracks.anonymous_id = track_facts.anonymous_id
      
    - join: sessions_trk
      view_label: sessions
      foreign_key: track_facts.session_id
    
    - join: session_trk_facts
      view_label: sessions
      foreign_key: sessions_trk.session_id
      relationship: one_to_one
    
    - join: tracks_flow
      view_label: events_flow
      foreign_key: event_id
    
    - join: user_session_facts
      view_label: users
      foreign_key: track_facts.looker_visitor_id

- explore: pages
  joins:
  - join: aliases_mapping
    relationship: many_to_one
    sql_on: aliases_mapping.alias = coalesce(pages.user_id, pages.anonymous_id)
  
  - join: page_facts
    foreign_key: event_id

- explore: funnel_explorer
  joins:
    - join: sessions_trk
      view_label: sessions
      foreign_key: session_id
    
    - join: user_session_facts
      view_label: users
      foreign_key: sessions_trk.looker_visitor_id
    
    - join: session_trk_facts
      view_label: sessions
      relationship: one_to_one
      foreign_key: session_id
    
    - join: users
      relationship: many_to_one
      sql_on: coalesce(users.mapped_user_id, users.user_id) = sessions.user_id
