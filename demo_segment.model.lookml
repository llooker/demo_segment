- connection: partners_segment

- scoping: true                  # for backward compatibility
- include: "*.view.lookml"       # include all the views
- include: "*.dashboard.lookml"  # include all the dashboards

- explore: sessions
  from: sessions_trk
  view_label: Sessions
  joins: 
    - join: session_trk_facts
      view_label: Sessions
      foreign_key: session_id
      relationship: one_to_one
    
    - join: users
      from: user_session_facts
      view_label: users
      foreign_key: looker_visitor_id

- explore: events
  from: tracks
  view_label: Events
  joins:
    - join: track_facts
      view_label: Events
      relationship: many_to_one
      sql_on: |
        events.event_id = track_facts.event_id and 
        events.sent_at = track_facts.sent_at and
        events.anonymous_id = track_facts.anonymous_id
      
    - join: sessions
      from: sessions_trk
      view_label: sessions
      foreign_key: track_facts.session_id
    
    - join: session_trk_facts
      view_label: Sessions
      foreign_key: sessions.session_id
      relationship: one_to_one
    
    - join: event_flow
      from: tracks_flow
      view_label: Events_flow
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
      view_label: Sessions
      foreign_key: session_id
    
    - join: user_session_facts
      view_label: users
      foreign_key: sessions_trk.looker_visitor_id
    
    - join: session_trk_facts
      view_label: Sessions
      relationship: one_to_one
      foreign_key: session_id
    
    - join: users
      relationship: many_to_one
      sql_on: coalesce(users.mapped_user_id, users.user_id) = sessions.user_id
