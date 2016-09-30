- view: accounts
  sql_table_name: salesforce.accounts
  fields:

  - dimension: id
    primary_key: true
    type: string
    sql: ${TABLE}.id

  - dimension: charges_enabled
    type: yesno
    sql: ${TABLE}.charges_enabled

  - dimension: country
    type: string
    sql: ${TABLE}.country

  - dimension_group: created
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.created_date

  - dimension: currencies_supported
    type: string
    sql: ${TABLE}.currencies_supported

  - dimension: default_currency
    type: string
    sql: ${TABLE}.default_currency

  - dimension: details_submitted
    type: yesno
    sql: ${TABLE}.details_submitted

  - dimension: external_id
    type: string
    sql: ${TABLE}.external_id_c

  - dimension: industry
    type: string
    sql: ${TABLE}.industry

  - dimension: is_deleted
    type: yesno
    sql: ${TABLE}.is_deleted

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

  - dimension: managed
    type: yesno
    sql: ${TABLE}.managed

  - dimension: owner_id
    type: string
    sql: ${TABLE}.owner_id

  - dimension: plan_c
    type: string
    sql: ${TABLE}.plan_c

  - dimension_group: received
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.received_at

  - dimension_group: system_modstamp
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.system_modstamp

  - dimension: transfers_enabled
    type: yesno
    sql: ${TABLE}.transfers_enabled

  - dimension: type
    type: string
    sql: ${TABLE}.type

  - measure: count
    type: count
    drill_fields: [id, opportunities.count]

