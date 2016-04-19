- connection: partners_segment

- include: "*.view.lookml"       # include all views in this project
# - include: ".dashboard.lookml"  # include all dashboards in this project

- explore: event_facts
  view_label: Events
  label: Events
  joins:
  - join: pages
    view_label: Events
    type: left_outer
    sql_on: |
      event_facts.event_id = pages.event_id and
      event_facts.received_at = pages.received_at and 
      event_facts.looker_visitor_id = pages.user_id
    relationship: one_to_one
  
  - join: page_facts
    view_label: Events
    type: left_outer
    sql_on: |
      event_facts.event_id = page_facts.event_id and
      event_facts.received_at = page_facts.received_at and 
      event_facts.looker_visitor_id = page_facts.looker_visitor_id
    relationship: one_to_one
    
  - join: page_aliases_mapping
    relationship: many_to_one
    sql_on: page_aliases_mapping.alias = coalesce(pages.user_id, pages.anonymous_id)
  
  - join: sessions_pg_trk
    view_label: Sessions
    type: left_outer
    sql_on: ${event_facts.session_id} = ${sessions_pg_trk.session_id}
    relationship: many_to_one

  - join: session_pg_trk_facts
    view_label: Sessions
    type: left_outer
    sql_on: ${event_facts.session_id} = ${session_pg_trk_facts.session_id}
    relationship: many_to_one