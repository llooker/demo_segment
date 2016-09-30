- view: ticket_events
  sql_table_name: zendesk.ticket_events
  fields:

  - dimension: organization_id
    type: string
    # hidden: true
    sql: ${TABLE}.organization_id

  - dimension: ticket_id
    type: string
    # hidden: true
    sql: ${TABLE}.ticket_id

  - dimension_group: timestamp
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.timestamp

  - dimension: type
    type: string
    sql: ${TABLE}.type

  - dimension: updater_id
    type: string
    sql: ${TABLE}.updater_id

  - measure: count
    type: count
    drill_fields: [organizations.id, tickets.id]

