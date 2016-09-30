- view: activities
  sql_table_name: sendgrid.activities
  fields:

  - dimension: email
    type: string
    sql: ${TABLE}.email

  - measure: count
    type: count
    drill_fields: []

