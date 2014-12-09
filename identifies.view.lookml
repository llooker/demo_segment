- view: identifies
  sql_table_name: hoodie.identifies
  fields:

  - dimension: anonymous_id
    sql: ${TABLE}.anonymous_id

  - dimension: context_ip
    sql: ${TABLE}.context_ip

  - dimension: context_library_name
    sql: ${TABLE}.context_library_name

  - dimension: context_library_version
    sql: ${TABLE}.context_library_version

  - dimension: context_user_agent
    sql: ${TABLE}.context_user_agent

  - dimension: created
    sql: ${TABLE}.created

  - dimension: email
    sql: ${TABLE}.email

  - dimension: event_id
    primary_key: true
    sql: ${TABLE}.event_id

  - dimension: has_payment_info
    type: yesno
    sql: ${TABLE}.has_payment_info

  - dimension: jeans
    sql: ${TABLE}.jeans

  - dimension: last_seen
    sql: ${TABLE}.last_seen

  - dimension_group: send
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.send_at

  - dimension_group: sent
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.sent_at

  - dimension: shipping_address1
    sql: ${TABLE}.shipping_address1

  - dimension: shipping_address2
    sql: ${TABLE}.shipping_address2

  - dimension: shipping_address_city
    sql: ${TABLE}.shipping_address_city

  - dimension: shipping_address_state
    sql: ${TABLE}.shipping_address_state

  - dimension: shipping_address_zip
    sql: ${TABLE}.shipping_address_zip

  - dimension: shipping_name
    sql: ${TABLE}.shipping_name

  - dimension: shoe
    sql: ${TABLE}.shoe

  - dimension: stripe_customer_id
    sql: ${TABLE}.stripe_customer_id

  - dimension: user_id
    sql: ${TABLE}.user_id

  - measure: count
    type: count
    drill_fields: [context_library_name, shipping_name]

