## Page and Track Analysis: 

Use this pattern when customers would like to include both pages and tracks events when defining their sessions. For instance, this pattern will enable a first referrer analysis (beneficial for webpages where URL/page hits are important).

![page track analysis](http://gdurl.com/46Cz)

A. [**Alias Mapping**] (_A_alias_mapping.view.lookml) - User ID Consolidation from Tracks and Pages Table 

B. [**Mapped Events**](_B_mapped_events.view.lookml) - Serves to map all events (Tracks and Pages) to universal user id as first step in sessionization. Ranks events by User and get the time difference between one event to the next. 

C. [**Session Track Pages**](_C_session_pg_tracks.view.lookml) - Creates sessions from Mapped Events by identifying a period of inactivity greater than 30 minutes, ending the current session and creating a new one.

D. [**Event Facts**](_D_event_facts.view.lookml) - Maps events to session ids. This table will the starting point for exploration as it contains all the necessary keys (Session ID, Universal User ID) for all relevant joins. Session or User fact tables can be created from Event facts to speed up query results. 

Looker Model - These individual files can be integrated in the [Pages Model File](pages.model.lookml). Event_id is NOT the primary key for Events, so joins must use multiple identifiers on required fields, like anonymous_id, received_at, and event_id. Also event_id may be called id, just swap the name.

[:point_right:](_8_sample_advanced_design_patterns.md) Continue to [Sample Advanced Design Patterns](_8_sample_advanced_design_patterns.md)

[:point_left:](_7_session_creation_overview.md) Back to [Session Creation Overview](_7_session_creation_overview.md)

[:house:](README.md) README [Table of Contents](README.md)
