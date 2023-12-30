class DataBaseInteraction {
  private Connection dataBaseConnection;

  // establish connection with local SQLite database in data/data.db
  // (Timofejs Cvetkovs 16/03/2023)
  public DataBaseInteraction() {
    try {
      this.dataBaseConnection = DriverManager.getConnection("jdbc:sqlite:" + sketchPath() + "/data/data.db");
      org.sqlite.Function.create(this.dataBaseConnection, "REGEXP", new org.sqlite.Function() {
        @Override
          protected void xFunc() throws SQLException {
          String expression = value_text(0);
          String value = value_text(1);
          if (value == null)
          value = "";
          Pattern pattern = Pattern.compile(expression);
          result(pattern.matcher(value).find() ? 1 : 0);
        }
      }
      );
    }
    catch(SQLException exception) {
      exception.printStackTrace();
      this.dataBaseConnection = null;
    }
  }

  // create table in SQLite database
  // (Timofejs Cvetkovs 16/03/2023)
  public void createFlightDataTable(String tableName) {
    try {
      this.dataBaseConnection.createStatement().executeUpdate(
        "CREATE TABLE IF NOT EXISTS " + tableName + " " +
        "(ID INTEGER PRIMARY KEY AUTOINCREMENT," +
        "FL_DATE TEXT NOT NULL," +
        "MKT_CARRIER TEXT NOT NULL," +
        "MKT_CARRIER_FL_NUM INT NOT NULL," +
        "ORIGIN TEXT NOT NULL," +
        "ORIGIN_CITY_NAME TEXT NOT NULL," +
        "ORIGIN_STATE_ABR TEXT NOT NULL," +
        "ORIGIN_WAC INT NOT NULL," +
        "DEST TEXT NOT NULL," +
        "DEST_CITY_NAME TEXT NOT NULL," +
        "DEST_STATE_ABR TEXT NOT NULL," +
        "DEST_WAC INT NOT NULL," +
        "CRS_DEP_TIME INT NOT NULL," +
        "DEP_TIME INT NOT NULL," +
        "CRS_ARR_TIME INT NOT NULL," +
        "ARR_TIME INT NOT NULL," +
        "CANCELLED INT NOT NULL," +
        "DIVERTED INT NOT NULL," +
        "DISTANCE INT NOT NULL," +
        "LATENESS INT NOT NULL);");
    }
    catch(SQLException exception) {
      exception.printStackTrace();
    }
  }

  // delete table from SQLite database
  // (Timofejs Cvetkovs 16/03/2023)
  public void deleteFlightDataTable(String tableName) {
    try {
      this.dataBaseConnection.createStatement().executeUpdate(
        "DROP TABLE IF EXISTS " + tableName + ";");
    }
    catch(SQLException exception) {
      exception.printStackTrace();
    }
  }

  // load CSV file at given path into SQLite database
  // (Timofejs Cvetkovs 16/03/2023)
  public boolean loadFlightDataTable(String tableName, String filePath) {
    Table table = loadTable(filePath, "header");

    try {
      Statement statement = this.dataBaseConnection.createStatement();
      if (this.getFlightDataRowCount(tableName) == 0) {
        println("Loading rows CSV file into table...");
        int rowsCount = table.getRowCount();
        int rowsLoaded = 0;
        for (TableRow row : table.rows()) {
          String dateString = row.getString(0).split(" ", 2)[0];
          String[] dateParts = dateString.split("/", 3);
          dateString = Integer.parseInt(dateParts[0]) + "/" + Integer.parseInt(dateParts[1]) + "/" + Integer.parseInt(dateParts[2]);
          int lateness = (row.getInt("CANCELLED") == 0) ? ((row.getInt("ARR_TIME") - row.getInt("CRS_ARR_TIME"))) : Integer.MAX_VALUE;
          if (lateness < -1000) lateness += 2400;
          statement.executeUpdate(
            "INSERT INTO " + tableName + " (FL_DATE,MKT_CARRIER,MKT_CARRIER_FL_NUM,ORIGIN," +
            "ORIGIN_CITY_NAME,ORIGIN_STATE_ABR,ORIGIN_WAC,DEST,DEST_CITY_NAME,DEST_STATE_ABR," +
            "DEST_WAC,CRS_DEP_TIME,DEP_TIME,CRS_ARR_TIME,ARR_TIME,CANCELLED,DIVERTED,DISTANCE,LATENESS) " +
            "VALUES ('" + dateString + "','" + row.getString(1) + "'," + row.getInt(2) + ",'" +
            row.getString(3) + "','" + row.getString(4) + "','" + row.getString(5) + "'," + row.getInt(6) +
            ",'" + row.getString(7) + "','" + row.getString(8) + "','" + row.getString(9) + "'," +
            row.getInt(10) + "," + row.getInt(11) + "," + row.getInt(12) + "," + row.getInt(13) +
            "," + row.getInt(14) + "," + row.getInt(15) + "," + row.getInt(16) + "," + row.getInt(17) + "," + lateness + ");");
          rowsLoaded++;
          println("Progress: " + rowsLoaded + " of " + rowsCount + " rows loaded");
        }
        return true;
      } else {
        println("Table is not empty!");
        return false;
      }
    }
    catch(SQLException exception) {
      exception.printStackTrace();
      return false;
    }
  }

  // get row count in a specified table
  // (Timofejs Cvetkovs 16/03/2023)
  public int getFlightDataRowCount(String tableName) {
    try {
      return this.dataBaseConnection.createStatement().executeQuery(
        "SELECT COUNT(*) FROM " + tableName + ";").getInt(1);
    }
    catch(SQLException exception) {
      exception.printStackTrace();
      return 0;
    }
  }

  // class for a query on a single field with a regexp
  // (Timofejs Cvetkovs 16/03/2023)
  public class GrepQuery {
    public String field;
    public String regexp;

    public GrepQuery(String field, String regexp) {
      this.field = field;
      this.regexp = regexp;
    }
  }

  public GrepQuery gQ(String field, String regexp) {
    return new GrepQuery(field, regexp);
  }

  // class for ordering by a single field in ascending/descending order
  public class OrderQuery {
    public String field;
    public boolean ascending;

    public OrderQuery(String field, boolean ascending) {
      this.field = field;
      this.ascending = ascending;
    }
  }

  public OrderQuery oQ(String field, boolean ascending) {
    return new OrderQuery(field, ascending);
  }

  // general query method
  // (Timofejs Cvetkovs 16/03/2023)
  public ResultSet getFilteredFlightData(String tableName, int limit, List<GrepQuery> grepQueries, List<OrderQuery> orderQueries) {
    try {
      String sql = "SELECT * FROM " + tableName + ((grepQueries != null) ? " WHERE " : " ");
      if (grepQueries != null)
        for (int gqIndex = 0; gqIndex < grepQueries.size(); gqIndex++)
          sql += grepQueries.get(gqIndex).field + " REGEXP '" +
            grepQueries.get(gqIndex).regexp + ((gqIndex + 1 == grepQueries.size()) ? "' " : "' AND ");
      sql += (orderQueries != null) ? "ORDER BY " : "";
      if (orderQueries != null)
        for (int oqIndex = 0; oqIndex < orderQueries.size(); oqIndex++)
          sql += orderQueries.get(oqIndex).field + " " +
            ((orderQueries.get(oqIndex).ascending) ? "ASC" : "DESC") + ((oqIndex + 1 == orderQueries.size()) ? " " : ", ");
      sql += "LIMIT " + limit + ";";
      // println(sql);
      ResultSet resultSet = this.dataBaseConnection.createStatement().executeQuery(sql);
      return resultSet;
    }
    catch(SQLException exception) {
      exception.printStackTrace();
      return null;
    }
  }

  // helper methods for general query method
  // (Timofejs Cvetkovs 16/03/2023)
  public ResultSet getFlightData(String tableName) {
    return this.getFilteredFlightData(tableName, this.getFlightDataRowCount(tableName), null, null);
  }

  public ResultSet getFlightData(String tableName, int limit) {
    return this.getFilteredFlightData(tableName, limit, null, null);
  }
  
  // get maximum integer in a certain field
  // (Timofejs Cvetkovs 23/03/2023)
  public int maxInt(String tableName, String field) {
    try {
      return this.dataBaseConnection.createStatement().executeQuery(
        "SELECT MAX(" + field + ") FROM " + tableName + ";"
      ).getInt(1);
    } catch(SQLException exception) {
      exception.printStackTrace();
      return 0;
    }
  }
  
  // get minimum integer in a certain field
  // (Timofejs Cvetkovs 23/03/2023)
  public int minInt(String tableName, String field) {
    try {
      return this.dataBaseConnection.createStatement().executeQuery(
        "SELECT MIN(" + field + ") FROM " + tableName + ";"
      ).getInt(1);
    } catch(SQLException exception) {
      exception.printStackTrace();
      return 0;
    }
  }
  
  // get all distinct values of a field
  // (Timofejs Cvetkovs 23/03/2023)
  public ResultSet distinctValues(String tableName, String field, boolean ascending) {
    try {
      return this.dataBaseConnection.createStatement().executeQuery(
        "SELECT DISTINCT " + field + " FROM " + tableName + " ORDER BY " + field + " " + (ascending ? "ASC" : "DESC") + ";"
      );
    } catch(SQLException exception) {
      exception.printStackTrace();
      return null;
    }
  }
}
