- connection: partners_segment

- scoping: true                  # for backward compatibility
- include: "*.view.lookml"       # include all the views
- include: "*.dashboard.lookml"  # include all the dashboards


## Could see performance improvements if we start off with Track Facts (reduces one level of joins for most common cases). 

- explore: tracks
  view_label: Events
  label: Events
  joins:
    - join: track_facts
      view_label: Events
      type: left_outer
      relationship: many_to_one
      sql_on: |
        tracks.event_id = track_facts.event_id and 
        tracks.received_at = track_facts.received_at and
        tracks.anonymous_id = track_facts.anonymous_id
      
    - join: sessions_trk
      view_label: Sessions
      type: left_outer
      sql_on: ${track_facts.session_id} = ${sessions_trk.session_id}
      relationship: many_to_one

    - join: session_trk_facts
      view_label: Sessions
      type: left_outer
      sql_on: ${track_facts.session_id} = ${session_trk_facts.session_id}
      relationship: many_to_one
    
    - join: user_session_facts
      view_label: Users
      type: left_outer
      sql_on: ${track_facts.looker_visitor_id} = ${user_session_facts.looker_visitor_id}
      relationship: many_to_one
    
    - join: tracks_flow
      view_label: Events Flow
      sql_on: ${track_facts.event_id} = ${tracks_flow.event_id}
      relationship: one_to_one



- explore: sessions_trk
  view_label: sessions
  label: Sessions
  joins: 
    - join: session_trk_facts
      view_label: sessions
      foreign_key: session_id
      relationship: one_to_one
    
    - join: user_session_facts
      view_label: users
      foreign_key: looker_visitor_id

# - explore: pages
#   joins:
#   - join: page_aliases_mapping
#     relationship: many_to_one
#     sql_on: page_aliases_mapping.alias = coalesce(pages.user_id, pages.anonymous_id)
#   
#   - join: page_facts
#     sql_on: |
#       ${pages.event_id} = ${page_facts.event_id} and 
#       ${page_aliases_mapping.looker_visitor_id} = ${page_facts.looker_visitor_id} and 
#       pages.received_at = ${page_facts.received_at}
#     relationship: one_to_one
    
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
