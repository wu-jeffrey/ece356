## Task 1
N.C.

## Task 2
N.C.

## Task 3
I know it was mentioned in class that there might be an "invisible" primary key if the user doesn't specify one. However, I don't see the purpose of having an "ID" if it isn't used to uniquely identify / fetch a particular relation, so I explicitly added the PK.

The `playNumber` and `gameID` create a "composite ID" and it appears to be used as such in the "earlier" version of the database as `playID`. As such, I added a composite PK constraint on those two columns where relevant.

As for foreign keys, I added them wherever I thought update cascading would be beneficial. However, I assume playID
