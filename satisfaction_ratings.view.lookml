- view: satisfaction_ratings
  sql_table_name: zendesk.satisfaction_ratings
  fields:

  - dimension: id
    primary_key: true
    type: string
    sql: ${TABLE}.id

  - dimension: assignee_id
    type: string
    sql: ${TABLE}.assignee_id

  - dimension_group: created
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.created_at

  - dimension: group_id
    type: string
    # hidden: true
    sql: ${TABLE}.group_id

  - dimension_group: received
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.received_at

  - dimension: requester_id
    type: string
    sql: ${TABLE}.requester_id

  - dimension: score
    type: string
    sql: ${TABLE}.score

  - dimension: ticket_id
    type: string
    # hidden: true
    sql: ${TABLE}.ticket_id

  - dimension_group: updated
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.updated_at

  - measure: count
    type: count
    drill_fields: [id, groups.group_id, tickets.id]

