- view: delivered
  sql_table_name: sendgrid.delivered
  fields:

  - dimension: email
    type: string
    sql: ${TABLE}.email

  - measure: count
    type: count
    drill_fields: []

