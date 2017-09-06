## Sample Advanced Design Patterns

Some advanced design patterns are included in the model as well. Feel free to implement others you think would apply to other use cases in the demo environment and document them here.

* **Funnel**
There are a number of of ways a funnel can be implemented, dependent on customer requirements. A few examples are documented below:

* 1. Hard Coded Funnel: If the customer has a hard coded funnel, you can always add specific event counts to the session facts view. An example is included in the [Session Track Facts](5_session_track_facts.view.lookml) view file for view_buy_page, added_item, tapped_shipit, and made_purchase. Counts for each step of the funnel can be defined, and then used to create a funnel. Alternatively, you can include each preceding step of the funnel as a requirement for session count in order to create a contingent funnel where the preceding events are required.

* 2. Custom Event Funnel (Non-contingent): One of the simpler ways to create a custom event funnel is actually directly in the base event data, that has been joined to sessions in the model file to give each event a session id. This design pattern has been implemented in [tracks](0_tracks.view.lookml). Using a parameter, a filter only field is defined for the maximum number of steps needed for the funnel. The user then can select which events they would like in their funnel, and explore measures that provide the distinct count of sessions containing the selected event types. Note: this does not require previous events to have occurred in the session or order of events.

* 3. Custom Event Funnel (Contingent and Ordered): For stricter requirements on Custom Event Funnels, the design pattern documented in the [funnel_explorer](funnel_explorer.view.lookml) view file can be used. This one requires the events selected to be ordered as well as the previous events to be required for the subsequent counts. This can be modified to accommodate whatever combinations of requirements are requested by the customer.

* **Event Flow**
For specifically analyzing the order of events in a session, the [tracks_flow](tracks_flow.view.lookml) design pattern can be implemented. Based on a selected event, you can then see what are the most common user paths following or preceding that event. This view file is joined to tracks in the model file and explored in the tracks explore. The functionality is best demonstrated in the Event Flow Dashboard

* **User Fact Tables**
[6_user_session_facts](6_user_session_facts.view.lookml) is an example fact table that uses mapped user ids and sessions to derive metrics like first date, last date, and total count of sessions to be used in things like retention and cohort analysis. It can be joined back to both event tables (pages, tracks) and session tables as needed on the mapped visitor id.

[:point_right:](_9_dashboards.md) Continue to [Dashboards](_9_dashboards.md)

[:point_left:](_7_session_creation_overview.md) Back to [Session Creation Overview](_7_session_creation_overview.md)

[:house:](README.md) README [Table of Contents](README.md)
