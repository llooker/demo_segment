- view: customers
  sql_table_name: stripe.customers
  fields:

  - dimension: id
    primary_key: true
    type: string
    sql: ${TABLE}.id

  - dimension_group: created
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.created

  - dimension: currency
    type: string
    sql: ${TABLE}.currency

  - dimension: delinquent
    type: yesno
    sql: ${TABLE}.delinquent

  - dimension: discount_id
    type: string
    # hidden: true
    sql: ${TABLE}.discount_id

  - dimension: email
    type: string
    sql: ${TABLE}.email

  - dimension_group: received
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.received_at

  - measure: count
    type: count
    drill_fields: detail*


  # ----- Sets of fields for drilling ------
  sets:
    detail:
    - id
    - discounts.id
    - charges.count
    - discounts.count
    - invoice_items.count
    - invoices.count
    - subscriptions.count

