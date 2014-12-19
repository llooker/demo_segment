- view: user_track_facts
  derived_table:
    sql: |
      SELECT 
        user_id                        
        , MIN(DATE(sent_at)) as first_date              
        , MAX(DATE(sent_at)) as last_date                
        , COUNT(*) as number_of_events                          
        , COUNT(DISTINCT DATE(sent_at)) as days_on_site  
      FROM ${mapped_tracks.SQL_TABLE_NAME} AS tracks
      GROUP BY 1

  fields:

  - dimension: user_id
    primary_key: true
    hidden: true
    sql: ${TABLE}.user_id

  - dimension_group: first_track
    type: time
    timeframes: [date, week, month]
    sql: ${TABLE}.first_date

  - dimension_group: last_track
    type: time
    timeframes: [date, week, month]
    sql: ${TABLE}.last_date

  - dimension: days_tracked_on_site
    type: number
    sql: ${TABLE}.days_on_site
  
  - dimension: number_of_events
    type: number
    sql: ${TABLE}.number_of_events
  
  - dimension: bounce
    type: yesno
    sql: ${number_of_events} = 1
  
  - dimension: days_tracked_on_site_tiered
    type: tier
    sql: ${days_tracked_on_site}
    tiers: [1,2,3,4,5,6,7,8,9,10,15,20,40,60,100]
    
  - dimension: one_time_user
    sql:  | 
      CASE 
        WHEN ${first_track_date} = ${last_track_date} 
        THEN 'One Time User' 
        ELSE 'Repeat User' END  
 
  - measure: bounced_visitors_count
    type: count
    filters:                                                  
      bounce: yes                                             #Equivalent of COUNT(CASE WHEN bounce = 'yes' THEN 1 ELSE 0 END)
   
  
  

  sets:
    detail:
      - user_id
      - first_date
      - last_date
      - days_on_site

