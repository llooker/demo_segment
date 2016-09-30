- view: dropped
  sql_table_name: sendgrid.dropped
  fields:

  - dimension: email
    type: string
    sql: ${TABLE}.email

  - measure: count
    type: count
    drill_fields: []

