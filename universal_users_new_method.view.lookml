# - explore: universal_users
# - view: universal_users
#   derived_table:
#   
#     sql_trigger_value: select current_date
#     sortkeys: [identifier]
#     distkey: identifier
#   
#     sql: |
#       with
#       
#       -- Pass 0: Initialize trivial result table
#       p0 (node, min_network_node) as (
#         select n1
#           , n1
#         from ${uu_identity_graph.SQL_TABLE_NAME}
#       
#         union
#       
#         select n2
#           , n2
#         from ${uu_identity_graph.SQL_TABLE_NAME}
#       ),
#       
#       -- Pass 1.a: Compare min_network_nodes between neighbors
#       p1a as (
#         select n1
#           , n2
#           , least(n1_min.min_network_node, n2_min.min_network_node) as least
#         from ${uu_identity_graph.SQL_TABLE_NAME} as graph
#           inner join p0 as n1_min
#             on graph.n1 = n1_min.node
#           inner join p0 as n2_min
#             on graph.n2 = n2_min.node
#       ),
#       
#       -- Pass 1.b: Take globally known minimum for each node
#       p1b (node, min_network_node) as (
#         select node
#           , min(least)
#         from (
#           select n1 as node
#             , least
#           from p1a
#       
#           union all
#       
#           select n2
#             , least
#           from p1a
#           ) local_minima
#         group by 1
#       ),
#       
#       -- Pass 2.a: Compare min_network_nodes between neighbors
#       p2a as (
#         select n1
#           , n2
#           , least(n1_min.min_network_node, n2_min.min_network_node) as least
#         from ${uu_identity_graph.SQL_TABLE_NAME} as graph
#           inner join p1b as n1_min
#             on graph.n1 = n1_min.node
#           inner join p1b as n2_min
#             on graph.n2 = n2_min.node
#       ),
#       
#       -- Pass 2.b: Take globally known minimum for each node
#       p2b (node, min_network_node) as (
#         select node
#           , min(least)
#         from (
#           select n1 as node
#             , least
#           from p2a
#       
#           union all
#       
#           select n2
#             , least
#           from p2a
#           ) local_minima
#         group by 1
#       ),
#       
#       -- Pass 3.a: Compare min_network_nodes between neighbors
#       p3a as (
#         select n1
#           , n2
#           , least(n1_min.min_network_node, n2_min.min_network_node) as least
#         from ${uu_identity_graph.SQL_TABLE_NAME} as graph
#           inner join p2b as n1_min
#             on graph.n1 = n1_min.node
#           inner join p2b as n2_min
#             on graph.n2 = n2_min.node
#       ),
#       
#       -- Pass 3.b: Take globally known minimum for each node
#       p3b (node, min_network_node) as (
#         select node
#           , min(least)
#         from (
#           select n1 as node
#             , least
#           from p3a
#       
#           union all
#       
#           select n2
#             , least
#           from p3a
#           ) local_minima
#         group by 1
#       ),
#       
#       -- Pass 4.a: Compare min_network_nodes between neighbors
#       p4a as (
#         select n1
#           , n2
#           , least(n1_min.min_network_node, n2_min.min_network_node) as least
#         from ${uu_identity_graph.SQL_TABLE_NAME} as graph
#           inner join p3b as n1_min
#             on graph.n1 = n1_min.node
#           inner join p3b as n2_min
#             on graph.n2 = n2_min.node
#       ),
#       
#       -- Pass 4.b: Take globally known minimum for each node
#       p4b (node, min_network_node) as (
#         select node
#           , min(least)
#         from (
#           select n1 as node
#             , least
#           from p4a
#       
#           union all
#       
#           select n2
#             , least
#           from p4a
#           ) local_minima
#         group by 1
#       ),
#       
#       -- Pass 5.a: Compare min_network_nodes between neighbors
#       p5a as (
#         select n1
#           , n2
#           , least(n1_min.min_network_node, n2_min.min_network_node) as least
#         from ${uu_identity_graph.SQL_TABLE_NAME} as graph
#           inner join p4b as n1_min
#             on graph.n1 = n1_min.node
#           inner join p4b as n2_min
#             on graph.n2 = n2_min.node
#       ),
#       
#       -- Pass 5.b: Take globally known minimum for each node
#       p5b (node, min_network_node) as (
#         select node
#           , min(least)
#         from (
#           select n1 as node
#             , least
#           from p5a
#       
#           union all
#       
#           select n2
#             , least
#           from p5a
#           ) local_minima
#         group by 1
#       )
#       
#       select node as identifier
#         , strtol(left(md5(min_network_node),15),16) as universal_user_id
#       from p5b
# 
# 
#   fields:
#   
#     - dimension: identifier
#       type: string
#       primary_key: true
#       sql: ${TABLE}.identifier
# 
#     - dimension: universal_user_id
#       type: int
#       sql: ${TABLE}.universal_user_id
#       
#     - measure: count
#       type: count
#       
#     - measure: count_distinct_users
#       type: count_distinct
#       sql: ${universal_user_id}
# 
# 
# - explore: uu_identity_graph
# - view: uu_identity_graph
#   derived_table:
#   
#     persist_for: 4 hours
#     sortkeys: [n1, n2]
#     distkey: n1
#   
#     sql: |
#       with
#       
#       -- temp table
#       events_030 as (select * from atomic.events_030 limit 10000),
#       
#       -- Assemble complete graph, adding self-referential edges
#       complete_graph (n1, n2) as (
#         select user_id
#           , user_ipaddress || user_fingerprint
#         from events_030
#         
#         union all
#         
#         select user_id
#           , domain_userid
#         from events_030
#         
#         union all
#        
#         select user_id
#           , network_userid
#         from events_030
#         
#         union all
#        
#         select user_ipaddress || user_fingerprint
#           , domain_userid
#         from events_030
#         
#         union all
#        
#         select user_ipaddress || user_fingerprint
#           , network_userid
#         from events_030
#       
#         union all
#        
#         select domain_userid
#           , network_userid
#         from events_030
#       
#         union all
#       
#         select user_id
#           , user_id
#         from events_030
#       
#         union all
#       
#         select user_ipaddress || user_fingerprint
#           , user_ipaddress || user_fingerprint
#         from events_030
#       
#         union all
#       
#         select domain_userid
#           , domain_userid
#         from events_030
#       
#         -- De-duplicate in the last union (not union all)
#         union
#       
#         select network_userid
#           , network_userid
#         from events_030
#       )
#       
#       select *
#       from complete_graph
#       where n1 <> '-'
#         and n2 <> '-'
#         and n1 is not null
#         and n2 is not null
#         and n1 <> ''
#         and n2 <> ''
# 
#   fields: [dimension: n1]
# 
# 
