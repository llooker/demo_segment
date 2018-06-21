## Session Creation Overview


Two separate design patterns exist for session creation: Track Analysis and Page and Track Analysis. For both of these design patterns, we create intermediate persistent derived tables (PDTs) to process tracks and page views into enriched events and sessions.

Choose Track Analysis for sessions only to be built from the `tracks` table [Session Tracks Analysis](_7a_session_tracks_analysis.md). Choose Page and Track Analysis for sessions that are built from both `tracks` and `pages` tables [Session Tracks and Pages Analysis](_7b_session_tracks_pages_analysis.md).

[:point_right:](_7a_session_tracks_analysis.md) Continue to [Session Tracks Analysis](_7a_session_tracks_analysis.md)

[:point_right:](_7b_session_tracks_pages_analysis.md) Continue to [Session Tracks and Pages Analysis](_7b_session_tracks_pages_analysis.md)

[:point_left:](_6_user_id_consolidation.md) Back to [User ID Consolidation](_6_user_id_consolidation.md)

[:house:](README.md) README [Table of Contents](README.md)
