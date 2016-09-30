- view: tickets
  sql_table_name: zendesk.tickets
  fields:

  - dimension: id
    primary_key: true
    type: string
    sql: ${TABLE}.id

  - dimension: assignee_id
    type: number
    sql: ${TABLE}.assignee_id

  - dimension: collaborator_ids
    type: string
    sql: ${TABLE}.collaborator_ids

  - dimension_group: created
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.created_at

  - dimension: data_source
    type: string
    sql: ${TABLE}.data_source

  - dimension: external_id
    type: string
    sql: ${TABLE}.external_id

  - dimension: group_id
    type: number
    # hidden: true
    sql: ${TABLE}.group_id

  - dimension: organization_id
    type: number
    # hidden: true
    sql: ${TABLE}.organization_id

  - dimension: planning_topic
    type: string
    sql: ${TABLE}.planning_topic

  - dimension: priority
    type: string
    sql: ${TABLE}.priority

  - dimension: question
    type: string
    sql: ${TABLE}.question

  - dimension_group: received
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.received_at

  - dimension: requester_id
    type: number
    sql: ${TABLE}.requester_id

  - dimension: requester_type
    type: string
    sql: ${TABLE}.requester_type

  - dimension: sharing_agreement_ids
    type: string
    sql: ${TABLE}.sharing_agreement_ids

  - dimension: site
    type: string
    sql: ${TABLE}.site

  - dimension: status
    type: string
    sql: ${TABLE}.status

  - dimension: submitter_id
    type: number
    sql: ${TABLE}.submitter_id

  - dimension: tags
    type: string
    sql: ${TABLE}.tags

  - dimension: type
    type: string
    sql: ${TABLE}.type

  - dimension_group: updated
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.updated_at

  - measure: count
    type: count
    drill_fields: detail*


  # ----- Sets of fields for drilling ------
  sets:
    detail:
    - id
    - groups.group_id
    - organizations.id
    - satisfaction_ratings.count
    - ticket_events.count
    - ticket_metrics.count

