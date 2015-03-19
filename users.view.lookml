- view: users
  derived_table:
    sql_trigger_value: SELECT COUNT(1) FROM hoodie.identifies
    sortkeys: [looker_visitor_id]
    distkey: looker_visitor_id
    sql: |
      SELECT distinct a.*, b.looker_visitor_id 
      FROM
        (SELECT distinct user_id
              , last_value(jeans ignore nulls) over (partition by user_id order by sent_at rows between unbounded preceding and unbounded following) as jeans
              , last_value(shoe ignore nulls) over (partition by user_id order by sent_at rows between unbounded preceding and unbounded following) as shoe
              , last_value(last_seen ignore nulls) over (partition by user_id order by sent_at rows between unbounded preceding and unbounded following) as last_seen
              , last_value(shipping_address_city ignore nulls) over (partition by user_id order by sent_at rows between unbounded preceding and unbounded following) as city
              , last_value(shipping_address_state ignore nulls) over (partition by user_id order by sent_at rows between unbounded preceding and unbounded following) as state
              , last_value(shipping_address_zip ignore nulls) over (partition by user_id order by sent_at rows between unbounded preceding and unbounded following) as zip
        FROM hoodie.identifies) as a
      INNER JOIN ${aliases_mapping.SQL_TABLE_NAME} as b
      ON b.alias = a.user_id 
      
  fields:

  - dimension: looker_visitor_id
    primary_key: true
    sql: ${TABLE}.looker_visitor_id
    
#   - dimension: user_id
#     primary_key: true
#     sql: ${TABLE}.user_id

  - dimension: jeans
    sql: ${TABLE}.jeans
  
  - dimension: waist
    sql: SPLIT_PART(${jeans},' ', 1)
  
  - dimension: length
    sql: SPLIT_PART(${jeans},' ', 3)

  - dimension: shoe
    type: number
    decimals: 1
    sql: ${TABLE}.shoe

  - dimension: last_seen
    sql: ${TABLE}.last_seen

  - dimension: city
    sql: ${TABLE}.city

  - dimension: state
    sql: ${TABLE}.state

  - dimension: zip
    sql: ${TABLE}.zip

  sets:
    detail:
      - user_id
      - jeans
      - shoe
      - last_seen
      - city
      - state
      - zip

