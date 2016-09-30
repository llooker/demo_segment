- view: bounce
  sql_table_name: sendgrid.bounce
  fields:

  - dimension: email
    type: string
    sql: ${TABLE}.email

  - measure: count
    type: count
    drill_fields: []

