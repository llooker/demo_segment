- connection: partners_segment

- include: "*.view.lookml"       # include all views in this project
- include: "*.dashboard.lookml"  # include all dashboards in this project



# - explore: pages
#   joins:
#   - join: aliases_mapping
#     relationship: many_to_one
#     sql_on: aliases_mapping.alias = coalesce(pages.user_id, pages.anonymous_id)
#   
#   - join: page_facts
#     foreign_key: event_id
