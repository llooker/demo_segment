- view: recipients
  sql_table_name: sendgrid.recipients
  fields:

  - dimension: email
    type: string
    sql: ${TABLE}.email

  - measure: count
    type: count
    drill_fields: []

