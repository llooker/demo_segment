- view: campaign_members
  sql_table_name: salesforce.campaign_members
  fields:

  - dimension: id
    primary_key: true
    type: string
    sql: ${TABLE}.id

  - dimension: campaign_id
    type: string
    # hidden: true
    sql: ${TABLE}.campaign_id

  - dimension: contact_id
    type: string
    sql: ${TABLE}.contact_id

  - dimension: created_by_id
    type: string
    sql: ${TABLE}.created_by_id

  - dimension_group: created
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.created_date

  - dimension: deleted
    type: yesno
    sql: ${TABLE}.deleted

  - dimension_group: first_responded
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.first_responded_date

  - dimension: has_responded
    type: yesno
    sql: ${TABLE}.has_responded

  - dimension: last_modified_by_id
    type: string
    sql: ${TABLE}.last_modified_by_id

  - dimension_group: last_modified
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.last_modified_date

  - dimension: lead_id
    type: string
    # hidden: true
    sql: ${TABLE}.lead_id

  - dimension_group: received
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.received_at

  - dimension: status
    type: string
    sql: ${TABLE}.status

  - measure: count
    type: count
    drill_fields: [id, campaigns.id, leads.id]

