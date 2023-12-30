class Descriptive {

  // returns index of largest value in an array
  // Liam Coogan 2023-03-25
  float largest (float[] arr) {
    float max = 0.0;
    for (float item : arr) if (item > max) max = item;
    return max;
  }

  // returns index of smallest value in an array
  // Liam Coogan 2023-03-25
  float smallest (float[] arr) {
    float min = Float.MAX_VALUE;
    for (float item : arr) if (item < min) min = item;
    return min;
  }

  // returns mean of all values in an array
  // Liam Coogan 2023-03-25
  float mean (float[] arr) {
    float sum = 0.0;
    for (float item : arr) sum += item;
    return (sum / arr.length);
  }

  // returns median of all values in an array
  // Liam Coogan 2023-03-26
  float median (float[] arr) {
    Arrays.sort(arr);
    int mid = arr.length / 2;
    if ((arr.length % 2) != 0) return arr[mid];
    else return ((arr[mid] + arr[mid+1]) / 2);
  }

  // returns mode of all values in an array
  // Liam Coogan 2023-03-26
  float mode (float[] arr) {
    Arrays.sort(arr);
    float mode = 0;
    float modeCount = 0;
    float prevItem = 0;
    float count = 0;
    for (float item : arr) {
      if (prevItem == item) count++;
      else if (count > modeCount) {
        mode = prevItem;
        modeCount = count;
        prevItem = item;
        count = 1;
      } else {
        prevItem = item;
        count = 1;
      }
    }
    return mode;
  }

  // create a ResultSet using a passed query and filtering options
  // Liam Coogan 2023-04-04
  ResultSet makeRS (String query, int filtering) {
    switch (filtering) {
    case 0:
      return db.getFilteredFlightData("flight_data", db.getFlightDataRowCount("flight_data"),
        null, asList(db.oQ(query, true)));
    case 1:
      return db.getFilteredFlightData("flight_data", db.getFlightDataRowCount("flight_data"),
        asList(db.gQ("CANCELLED", "1")), asList(db.oQ(query, true)));
    case 2:
      return db.getFilteredFlightData("flight_data", db.getFlightDataRowCount("flight_data"),
        asList(db.gQ("DIVERTED", "1")), asList(db.oQ(query, true)));
    case 3:
      return db.getFilteredFlightData("flight_data", db.getFlightDataRowCount("flight_data"),
        asList(db.gQ("LATENESS", "0")), asList(db.oQ(query, true)));
    case 4:
      return db.getFilteredFlightData("flight_data", db.getFlightDataRowCount("flight_data"),
        asList(db.gQ("LATENESS", "-[1-9]+")), asList(db.oQ(query, true)));
    default:
      println("ERROR: INVALID FILTERING");
      return null;
    }
  }

  // select a column in a ResultSet based on a passed query
  // Liam Coogan 2023-04-04
  int chooseCol (String query) {
    switch (query) {
    case "FL_DATE":
      return 2;
    case "MKT_CARRIER":
      return 3;
    case "MKT_CARRIER_FL_NUM":
      return 4;
    case "ORIGIN":
      return 5;
    case "ORIGIN_CITY_NAME":
      return 6;
    case "ORIGIN_STATE_ABR":
      return 7;
    case "ORIGIN_WAC":
      return 8;
    case "DEST":
      return 9;
    case "DEST_CITY_NAME":
      return 10;
    case "DEST_STATE_ABR":
      return 11;
    case "DEST_WAC":
      return 12;
    case "CRS_DEP_TIME":
      return 13;
    case "DEP_TIME":
      return 14;
    case "CRS_ARR_TIME":
      return 15;
    case "ARR_TIME":
      return 16;
    case "CANCELLED":
      return 17;
    case "DIVERTED":
      return 18;
    case "DISTANCE":
      return 19;
    case "LATENESS":
      return 20;
    default:
      println("ERROR: INVALID QUERY");
      return -1;
    }
  }
}
