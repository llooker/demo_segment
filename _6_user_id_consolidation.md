## User ID Consolidation

The idea behind finding a universal user id is in this [Segment blog post](), but the actual implementation is a bit more complicated. The primary assumption is that a user can have multiple identifiers depending on the context of their visit:
 
1. Anonymous Id is localized to the visit, but will remain consistent across that visit
1. User Id is populated only after the user authenticates (i.e. signs into a site) but should remain consistent across distinct visits UNLESS the user id changes during a visit. In this case the anonymous id would remain consistent across the change, so we can still map the user to the same identity.


Anon ID | User ID | Event ID | Link ID
------- | ------- | -------- | ------- 
11111 | NULL | 1 | | First Visit
11111 | NULL | 2 | | First Visit
11111 | e@looker.com | 3 | User Authenticates | First Visit
11111 | e@looker.com | 4 | | First Visit
11111 | e@looker.com | 5 | | First Visit
11112 | NULL | 6 | | Second Visit
11112 | NULL | 7 | | Second Visit
11112 | NULL | 8 | |Second Visit
11112 | e@looker.com | 9 | User Authenticates | Second Visit
11112 | e@looker.com | 10 | | Second Visit
11113 | NULL | 11 | | Third Visit
11113 | NULL | 12 | | Third Visit

The following table walks through what the tracks table would look like for two different user visits (sessions) for a single user. When the user visits the site, they are automatically assigned an Anonymous ID, which remains with them through their visit on the site. Once that user authenticates (logs in), we can assign a user ID to all the events they have performed since that point. In our example below, the User authenticates at Event 2 and Event 9 in their first and second visit. 

The simplest version of this mapping table looks like the following:

* Select anonymous IDs and User IDs from the base tracks (or tracks and pages) table and take the first non-null user_id for each anonymous_id.
* Sample Looker View File: [1_aliases_mapping](1_aliases_mapping.view.lookml)

Anon ID | User ID
------- | -------
11111 | e@looker.com
11112 | e@looker.com
11113 | NULL

**Advanced User Mapping using the “Alias” base table.** 
For most Segment implementations, the alias mapping file specified above should suffice. But for advanced user mapping where you would like to track User ID to User ID changes, refer to the following implementation (commented at the bottom of the [1_aliases_mapping](1_aliases_mapping.view.lookml) view file).
 
Using the Aliases table (if exists) and the tables to used for event analysis and sessionization (Tracks and/or Pages), we can create an id mapping table using the following steps (which are commented in the view file):
 
1. Establish all child-to-parent edges from tables (tracks, pages and/or aliases)
1. Only keep the oldest non-null parent for each child
1. Traverse the tree upwards and point every node at its root
 
The first step unions all combinations of first id and second id, as well as the timestamp of the event that the combination occurred. First id in tracks and pages is anonymous id, the second is user_id.  Since we also want the edges of the map, we also capture the second id and null, so user_id and null, with corresponding timestamps.  So for pages for instance :

 ```
select anonymous_id
                 , user_id
                 , received_at
              from hoodie.pages
              
              union
              
              select user_id
                 , null
                 , received_at
              from hoodie.pages
 ```
 
The Aliases table can sometimes track these changes as well from anonymous_id to user_id, but can also track user_id to user_id changes. The logic to union in this dataset is the same, but the first id is previous_id and the second id is user_id

``` 
select previous_id
               , user_id
               , received_at
              from hoodie.aliases
             
              union
             
              select user_id
                , null
                , received_at
              from hoodie.aliases
```

Then the final result, dependent on the source tables used should look like the first step of the first design pattern.
 
The next step ensures we only have one parent to child relationship, but selecting the oldest non null parent for each child:

``` 
select distinct alias
               , first_value(next_alias ignore nulls) over(partition by alias order by realiased_at rows between unbounded preceding and unbounded following) as next_alias
             from all_realiases
```

Then we basically join the table onto itself as many times as we think is necessary to get the most accurate mapping, as shown in the final step. We then have 2 fields: alias and looker_visitor_id, that we can use to map events later in the model to a universal user id.

[:point_right:](_7_session_creation_overview.md) Continue to [Session Creation Overview](_7_session_creation_overview.md)

[:point_left:](_5_applying_the_segment_block.md) Back to [Applying the Segment Block](_5_applying_the_segment_block.md)

[:house:](README.md) README [Table of Contents](README.md)
