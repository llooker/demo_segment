## Table Structure

There is a set of base tables that can be included for each Segment schema (note that Segment refers to each schema as a project in its documentation, but referring to it as schema will alleviate confusion between a Segment Project and a Looker Project). Note that **not all of these tables are required**, and the subset included will be dependent on the Segment implementation. The documentation from the Segment website is [here](https://segment.com/docs/warehouses/), but below is a Looker-relevant summary (Screens and Groups are not currently part of the template but can be incorpoated as needed):


* **Tracks**: Event Data
* **Pages**: Page View Data
* **Aliases**: Helps with user identification by providing a list of previous and current user ids when user id changes
* **Identifies**: Provides information about users
* **Users**: A table with unique identify calls. identify calls are upserted on user_id into this table (updated if an existing entry exists, appended otherwise). This table holds the latest state of of a user. The id column in the users table is equivalent to the user_id column in the identifies table. Also note that this table won’t have an anonymous_id column since a user can have multiple anonymousIds. To get at a user’s anonymousIds, you’ll need to query the identifies table. If you observer any duplicates in the users table, email friends@segment.com.
* **Groups**: A table with all of your group method calls. This table will include all of the traits you record for groups as top-level columns, for example `<project>.groups.employee_count`.
* **Accounts**: A table with unique group method calls. Group calls are upserted into this table (updated if an existing entry exists, appended otherwise). This table holds the latest state of a group.
* **Screens**: Includes all of the properties recorded for screens

Additional tables will exist **for each event type** in the format `<schema>.<event>`.  Additional metadata may be of use in these tables specific to certain event types, and joins to these tables will require additional customizations based on the clients requests, but can be handled after the initial model build. Note that id or event id of these tables is NOT a primary key. Approximating a Primary Key is generally possible by  

[:point_right:](_4_initial_validation.md) Continue to [Initial Validation](_4_initial_validation.md)

[:point_left:](_2_configuring_the_database_connection.md) Back to [Configuring the Database Connection](_2_configuring_the_database_connection.md)

[:house:](README.md) README [Table of Contents](README.md)
