- view: leads
  sql_table_name: salesforce.leads
  fields:

  - dimension: id
    primary_key: true
    type: string
    sql: ${TABLE}.id

  - dimension: converted_account_id
    type: string
    sql: ${TABLE}.converted_account_id

  - dimension: converted_contact_id
    type: string
    sql: ${TABLE}.converted_contact_id

  - dimension_group: converted
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.converted_date

  - dimension: converted_opportunity_id
    type: string
    sql: ${TABLE}.converted_opportunity_id

  - dimension: country
    type: string
    sql: ${TABLE}.country

  - dimension_group: created
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.created_date

  - dimension: external_id_c
    type: string
    sql: ${TABLE}.external_id_c

  - dimension: is_converted
    type: yesno
    sql: ${TABLE}.is_converted

  - dimension: is_deleted
    type: yesno
    sql: ${TABLE}.is_deleted

  - dimension_group: last_activity
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.last_activity_date

  - dimension: last_modified_by_id
    type: string
    sql: ${TABLE}.last_modified_by_id

  - dimension_group: last_modified
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.last_modified_date

  - dimension_group: last_referenced
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.last_referenced_date

  - dimension_group: last_viewed
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.last_viewed_date

  - dimension: lead_source
    type: string
    sql: ${TABLE}.lead_source

  - dimension: owner_id
    type: string
    sql: ${TABLE}.owner_id

  - dimension_group: received
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.received_at

  - dimension: status
    type: string
    sql: ${TABLE}.status

  - measure: count
    type: count
    drill_fields: [id, campaign_members.count]

