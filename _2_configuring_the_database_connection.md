## Getting Started

The database configuration process should follow the same logic as when [Configuring a Redshift Database](http://www.looker.com/docs/admin/database-config/amazon-redshift ) or [Configuring a Postgres Database](http://www.looker.com/docs/setup-and-management/database-config/postgresql). Customers can easily reference their warehouse credentials in the Connection tab of their Warehouse settings page:

Ensure that the **Looker** user has:

* SELECT privileges to all schemas to be explored (Segment implementations generally have a schema per tracked domain, plus any additional schemas added by the customer).
* Ownership of the Looker scratch schema. Note that the scratch schema is REQUIRED when using the Segment Block with Looker, because the model requires the creation of multiple PDTs for event processing.

Additionally, because we need to accommodate for scaling event data that may become much larger–a few additional things should be confirmed with Segment (**if Segment hosts**): 

* 30 minute time-out window has been removed from queries. By default, Segment terminates queries at 30 minutes, this needs to be removed for PDT creation to complete in many cases.
* Insure customer is on cluster scaling plan. Segment should resize the Redshift cluster when it reaches 50% utilization so that querying is performant.

[:point_right:](_3_table_structure.md) Continue to [Table Structure](_3_table_structure.md)

[:point_left:](_1_block_overview.md) Back to [Block Overview](_1_block_overview.md)

[:house:](README.md) README [Table of Contents](README.md)
