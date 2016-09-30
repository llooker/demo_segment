- view: campaigns
  sql_table_name: salesforce.campaigns
  fields:

  - dimension: id
    primary_key: true
    type: string
    sql: ${TABLE}.id

  - dimension: amount_all_opportunities
    type: string
    sql: ${TABLE}.amount_all_opportunities

  - dimension: amount_won_opportunities
    type: string
    sql: ${TABLE}.amount_won_opportunities

  - dimension_group: created
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.created_date

  - dimension_group: end
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.end_date

  - dimension: is_active
    type: yesno
    sql: ${TABLE}.is_active

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

  - dimension: number_of_contacts
    type: number
    sql: ${TABLE}.number_of_contacts

  - dimension: number_of_converted_leads
    type: number
    sql: ${TABLE}.number_of_converted_leads

  - dimension: number_of_leads
    type: number
    sql: ${TABLE}.number_of_leads

  - dimension: number_of_opportunities
    type: number
    sql: ${TABLE}.number_of_opportunities

  - dimension: number_of_responses
    type: number
    sql: ${TABLE}.number_of_responses

  - dimension: number_of_won_opportunities
    type: number
    sql: ${TABLE}.number_of_won_opportunities

  - dimension: number_sent
    type: number
    sql: ${TABLE}.number_sent

  - dimension: owner_id
    type: string
    sql: ${TABLE}.owner_id

  - dimension: parent_id
    type: string
    sql: ${TABLE}.parent_id

  - dimension_group: received
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.received_at

  - dimension_group: start
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.start_date

  - dimension: status
    type: string
    sql: ${TABLE}.status

  - measure: count
    type: count
    drill_fields: [id, campaign_members.count]

