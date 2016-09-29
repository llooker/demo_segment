## Initial Validation

An important part of the initial data validation is making sure the event data has been configured as expected in the Segment implementation, especially user identifiers contained in the subset of Tracks, Pages, and Aliases tables available. Here is a suggested list:

1. Verify that all events in Pages and Tracks have an Anonymous Id.
1. Determine if User Id is part of the dataset, if so proceed. If not, discuss with the customer how they’d like to identify users (IP Address? Only consider discrete visits?). 
1. Verify that any schemas that will be tied together have User Ids in Pages and Tracks that will map. 
1. Verify that User Ids are as expected for the customer. Occasionally customers will change what value is populated for User Id, make sure you are only analyzing data that is correct (occasionally this is after a certain date). This generally is evident in the formatting (a 6 digit number vs a 10 character string, for example).
1. Verify that events populated with a User Id also have an Anonymous Id, or the Aliases table contains this mapping.
1. Verify the events in Tracks (`tracks.event`) are as expected.

If you see any deviations from expected behavior, there may be some things that should be configured on the Segment end.

[:point_right:](_5_applying_the_segment_block.md) Continue to [Applying the Segment Block](_5_applying_the_segment_block.md)

[:point_left:](_3_table_structure.md) Back to [Table Structure](_3_table_structure.md)

[:house:](README.md) README [Table of Contents](README.md)
