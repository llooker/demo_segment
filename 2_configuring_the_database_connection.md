## Getting Started

The database configuration process should follow the same logic as when [Configuring a Redshift Database](http://www.looker.com/docs/admin/database-config/amazon-redshift ) or [Configuring a Postgres Database](http://www.looker.com/docs/setup-and-management/database-config/postgresql). Customers can easily reference their warehouse credentials in the Connection tab of their Warehouse settings page:

![warehouse settings screenshot](https://photos-1.dropbox.com/t/2/AAAxtue8_Mnlf7jaY9Z65yXzN9O0voQA045MUyqLwpWZjw/12/542046685/png/32x32/3/1475197200/0/2/Screenshot%202016-06-16%2015.30.04.png/EObenKsEGMkEIAIoAg/hDzYgQUONWXMCz7k0sYb-FNcFKVly6_-XfaEHLORdFQ?size_mode=3&dl=0&size=320x240)

Ensure that the **Looker** user has:

* SELECT privileges to all schemas to be explored (Segment implementations generally have a schema per tracked domain, plus any additional schemas added by the customer).
* Ownership of the Looker scratch schema. Note that the scratch schema is REQUIRED when using the Segment Block with Looker, because the model requires the creation of multiple PDTs for event processing.

Additionally, because we need to accommodate for scaling event data that may become much larger–a few additional things should be confirmed with Segment (**if Segment hosts**): 

* 30 minute time-out window has been removed from queries. By default, Segment terminates queries at 30 minutes, this needs to be removed for PDT creation to complete in many cases.
* Insure customer is on cluster scaling plan. Segment should resize the Redshift cluster when it reaches 50% utilization so that querying is performant.

