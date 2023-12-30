# Database Interaction Documentation

Written by Timofejs Cvetkovs

### Connecting to the database

```Java
DataBaseInteraction db = new DataBaseInteraction();
```

### Public instance methods

```Java
// pass in name of target table

void createFlightDataTable(String tableName);
```

```Java
// pass in name of target table

void deleteFlightDataTable(String tableName);
```

```Java
// pass in name of target table
// pass in path to source CSV file

boolean loadFlightDataTable(String tableName, String filePath);

// returns true if CSV file loaded successfully
// returns false if table already has data in it
```

```Java
// pass in name of target table

int getFlightDataRowCount(String tableName);

// returns the number of rows in a table
```

```Java
// NOTE: These are helper methods for the getFilteredFlightData method

// pass in name of field to query by
// pass in regular expression for the search term

GrepQuery gQ(String field, String regexp);

// pass in name of field to sort by
// pass in true to sort in ascending order
// pass in false to sort in descending order

OrderQuery oQ(String field, boolean ascending);
```

```Java
// pass in name of target table
// pass in limit for the number of rows to return
// pass in list of GrepQueries (see gQ)
// pass in list of OrderQueries (see oQ)
// (for the last 2, it may be best to use asList(db.gQ(...), db.gQ(...)) etc.

ResultSet getFilteredFlightData(String tableName, int limit, List<GrepQuery> grepQueries, List<OrderQuery> orderQueries);

// returns a ResultSet of data from the database according to the specified query

// EXAMPLE USAGE:
db.getFilteredFlightData("flight_data", 10, 
                         asList(db.gQ("FL_DATE", "1/[1-2]/2022"), db.gQ("MKT_CARRIER", "HA")),
                         asList(db.oQ("FL_DATE", true)));
```

```Java
// pass in name of target table

ResultSet getFlightData(String tableName);

// returns a ResultSet of all the data from the target table
```

```Java
// pass in name of target table

ResultSet getFlightData(String tableName, int limit);

// returns a ResultSet of a specified number of rows of data from the target table
```

```Java
// pass in name of target table
// pass in name of target field

int maxInt(String tableName, String field);

// returns the maximum integer value of that field
```

```Java
// pass in name of target table
// pass in name of target field

int minInt(String tableName, String field);

// returns the minimum integer value of that field
```

```Java
// pass in name of target table
// pass in name of target field
// pass in true to sort in ascending order
// pass in false to sort in descending order

ResultSet distinctValues(String tableName, String field);

// returns a ResultSet of all the distinct vaues of that field
```
