- connection: partners_segment

- scoping: true                  # for backward compatibility
- include: "*.view.lookml"       # include all the views
- include: "*.dashboard.lookml"  # include all the dashboards

- explore: aliases

- explore: identifies

- explore: pages
  always_join: [aliases_mapping]
  joins: 
    - join: aliases_mapping
      sql_on: aliases_mapping.previous_id = coalesce(pages.user_id, pages.anonymous_id)
    
    - join: user_page_facts
      sql_on: user_page_facts.user_id = coalesce(aliases_mapping.mapped_user_id,pages.user_id,pages.anonymous_id)
    
    - join: page_facts
      foreign_key: event_id

- explore: tracks
  always_join: [aliases_mapping]
  joins:
    - join: aliases_mapping
      sql_on: aliases_mapping.previous_id = coalesce(tracks.user_id, tracks.anonymous_id)
    
    - join: user_track_facts
      sql_on: user_track_facts.user_id = coalesce(aliases_mapping.mapped_user_id,tracks.user_id,tracks.anonymous_id)
    
    - join: users
      sql_on: coalesce(users.mapped_user_id, users.user_id) = coalesce(aliases_mapping.mapped_user_id,tracks.user_id,tracks.anonymous_id)

- explore: sessions
  joins: 
    - join: user_track_facts
      foreign_key: user_id
    
    - join: user_session_facts
      foreign_key: user_id
    
    - join: session_facts
      sql_on: |
        sessions.user_id = session_facts.user_id
        AND
        sessions.sessionidx = session_facts.sessionidx
      join_type: one_to_one
    
    - join: users
      sql_on: coalesce(users.mapped_user_id, users.user_id) = sessions.user_id


