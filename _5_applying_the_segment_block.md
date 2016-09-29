## Applying the Segment Template/Design Patterns

**Resources**

There are 2 design patterns to choose from in this repo, one involving sessions from Tracks only, the other from both Pages and Tracks.

**NOTE**: If you are not using Segment Warehouses, but a partner to ETL the data or custom ETL, the schema may look a bit different.

**Customization**

When applying the Segment template, it will need to be tailored to the underlying data, not a simple copy/paste. A few notes on that below:
  
* Schema names will be distinct to the Segment implementation, so the names in the template will need to be replaced. 
* Because not all Segment implementations include all of the stock tables, the view files will need to be customized accordingly, which we’ll go through in this doc
* You’ll also want to consider how you’d like to define your sessions, which could include:
1. Whether they come from only Tracks or both Pages and Tracks
1. Session timeout/Requirements for a new session 
1. Custom info from `<schema>.event` tables that is of importance

[:point_right:](_6_user_id_consolidation.md) Continue to [User ID Consolidation](_6_user_id_consolidation.md)

[:point_left:](_4_initial_validation.md) Back to [Initial Validation](_4_initial_validation.md)

[:house:](README.md) README [Table of Contents](README.md)
