## Track Analysis: 

Track Analysis looks at “events” or “actions” such as a ≠≠button clicks. Track analysis uses events from the Tracks table only to define sessions. This is good for implementations where page views from the Pages table are not important for the customer , for instance  mobile apps where page view data is not very relevant.

For Track Analysis, refer to the tracks model and the numbered View Files (ex. 1_, 2_, 3_...) in the Segment Block. 


1. [**Alias Mapping**](1_aliases_mapping.view.lookml) - User ID Consolidation from Tracks Table 
1. [**Mapped Tracks**](2_mapped_tracks.view.lookml) - Serves to map events to universal user id as first step in sessionization. Ranks events by User and get the time difference between one event to the next. 
1. [**Session Tracks**](3_session_tracks.view.lookml) - Creates sessions from Mapped Events by identifying a period of inactivity greater than 30 minutes, ending the current session and creating a new one.
1. [**Track Facts**](4_track_facts.view.lookml) - Maps events to session ids. This table will the starting point for exploration as it contains all the necessary keys (Session ID, Universal User ID) for all relevant joins. Session or User fact tables can be created from Track facts to speed up query results. 

**Looker Model** - These individual files can be integrated in the model file [tracks](tracks.model.lookml) as shown. Note that event_id is NOT the primary key for Tracks, so joins must use multiple identifiers on required fields, like anonymous_id, received_at, and event_id.  **Also event_id may be called id, just swap the name**

**Event Metadata Tables** - Segment provides Event Metadata tables that contain additional attributes about a particular events. For example, a “submit” event table might contain information from the form attributes that collected when the submit action occurred. Join in these metadata tables back to the model as appropriate. 

[:point_right:](_8_sample_advanced_design_patterns.md) Continue to [Sample Advanced Design Patterns](_8_sample_advanced_design_patterns.md)

[:point_left:](_7_session_creation_overview.md) Back to [Session Creation Overview](_7_session_creation_overview.md)

[:house:](README.md) README [Table of Contents](README.md)
