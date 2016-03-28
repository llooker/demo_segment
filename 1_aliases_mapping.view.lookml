- view: aliases_mapping
  derived_table:
    sql_trigger_value: select current_date
    sortkeys: [looker_visitor_id, alias]
    distkey: alias
    sql: |
      with
            
            -- Establish all child-to-parent edges from tables (tracks, pages, aliases) 
      all_mappings as (
        select anonymous_id
        , user_id
        , sent_at as sent_at
        from hoodie.tracks
            
        union
            
        select user_id
          , null
          , sent_at
        from hoodie.tracks
              
              
            -- INCLUDE THESE UNIONS IF PAGE VIEWS WILL BE TRACKED 
        union
               
        select anonymous_id
          , user_id
          , sent_at
        from hoodie.pages
               
        union
               
        select user_id
        , null
        , sent_at
        from hoodie.pages
      )
            
      select 
                  distinct anonymous_id as alias
                , first_value(user_id ignore nulls) 
                  over(
                      partition by anonymous_id 
                      order by sent_at 
                      rows between unbounded preceding and unbounded following) as looker_visitor_id
                     
      from all_mappings

    



  fields:
  
  # Anonymous ID
  - dimension: alias
    primary_key: true
    sql: ${TABLE}.alias

  # User ID
  - dimension: looker_visitor_id
    sql: ${TABLE}.looker_visitor_id
    
    
    
### More Complex Aliasing Using Alias Table ###

#     sql: |
#        with
#             
#             -- Establish all child-to-parent edges from tables (tracks, pages, aliases) 
#             all_mappings as (
#               select anonymous_id 
#                 , user_id 
#                 , sent_at 
#               from hoodie.tracks
#             
#               union
#             
#               select user_id
#                 , null
#                 , sent_at
#               from hoodie.tracks
#             
#                union
#             
#                select previous_id
#                 , user_id
#                 , sent_at
#                from hoodie.aliases
#               
#                union
#               
#                select user_id
#                  , null
#                  , sent_at
#                from hoodie.aliases
#                
#                union
#                
#                select anonymous_id
#                   , user_id
#                   , sent_at
#                from hoodie.pages
#                
#                union
#                
#                select user_id
#                   , null
#                   , sent_at
#                from hoodie.pages
#             ),
#             
#             -- Only keep the oldest non-null parent for each child
#             realiases as (
#               select distinct alias
#                 , first_value(next_alias ignore nulls) over(partition by alias order by realiased_at rows between unbounded preceding and unbounded following) as next_alias
#               from all_mappings
#             )
#             
#             -- Traverse the tree upwards and point every node at its root
#             select distinct r0.alias
#               , coalesce(r9.next_alias
#                   , r9.alias
#                   , r8.alias
#                   , r7.alias
#                   , r6.alias
#                   , r5.alias
#                   , r4.alias
#                   , r3.alias
#                   , r2.alias
#                   , r1.alias
#                   , r0.alias
#                 ) as looker_visitor_id
#             from realiases r0
#               left join realiases r1 on r0.next_alias = r1.alias
#               left join realiases r2 on r1.next_alias = r2.alias
#               left join realiases r3 on r2.next_alias = r3.alias
#               left join realiases r4 on r3.next_alias = r4.alias
#               left join realiases r5 on r4.next_alias = r5.alias
#               left join realiases r6 on r5.next_alias = r6.alias
#               left join realiases r7 on r6.next_alias = r7.alias
#               left join realiases r8 on r7.next_alias = r8.alias
#               left join realiases r9 on r8.next_alias = r9.alias
# 
