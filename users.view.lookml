- view: users
  derived_table:
    sql: |
      SELECT distinct a.*, b.mapped_user_id 
      FROM
        (SELECT distinct user_id
              , last_value(jeans) over (partition by user_id order by sent_at rows between unbounded preceding and unbounded following) as jeans
              , last_value(shoe) over (partition by user_id order by sent_at rows between unbounded preceding and unbounded following) as shoe
              , last_value(last_seen) over (partition by user_id order by sent_at rows between unbounded preceding and unbounded following) as last_seen
              , last_value(shipping_address_city) over (partition by user_id order by sent_at rows between unbounded preceding and unbounded following) as city
              , last_value(shipping_address_state) over (partition by user_id order by sent_at rows between unbounded preceding and unbounded following) as state
              , last_value(shipping_address_zip) over (partition by user_id order by sent_at rows between unbounded preceding and unbounded following) as zip
        FROM hoodie.identifies) as a
      LEFT JOIN ${aliases_mapping.SQL_TABLE_NAME} as b
      ON a.user_id  = b.previous_id
      

  fields:

  - dimension: mapped_user_id
    sql: ${TABLE}.mapped_user_id
    
  - dimension: user_id
    primary_key: true
    sql: ${TABLE}.user_id

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

