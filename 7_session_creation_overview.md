## Session Creation Overview


Two separate design patterns exist for session creation: Track Analysis and Page and Track Analysis. For both of these design patterns, we create intermediate persistent derived tables (PDTs) to process tracks and page views into enriched events and sessions.

Choose Track Analysis for sessions only to be built from the `tracks` table (7a). Choose Page and Track Analysis for sessions that are built from both `tracks` and `pages` tables (7b).
