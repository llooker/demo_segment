- view: processed
  sql_table_name: sendgrid.processed
  fields:

  - dimension: email
    type: string
    sql: ${TABLE}.email

  - measure: count
    type: count
    drill_fields: []

