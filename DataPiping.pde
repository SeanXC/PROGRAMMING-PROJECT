// (Timofejs Cvetkovs 2/4/2023)
States state;
public static class DataPipe {
  // graph types
  public static final int GRH_INVALID = -1;
  public static final int GRH_BAR = 0;
  public static final int GRH_SPREADSHEET = 1;
  
  // sort by
  public static final int SRT_NONE = 0;
  public static final int SRT_LATENESS = 1;
  public static final int SRT_DISTANCE = 2;
  
  // view only
  public static final int VIW_ALL = 0;
  public static final int VIW_CANCELLED = 1;
  public static final int VIW_ONTIME = 2;
  public static final int VIW_LATE = 3;
  
  // selections
  public static int sort = SRT_NONE;
  public static int view = VIW_ALL; 
  public static String depAirport = "ALL AIRPORTS";
  public static String arrAirport = "ALL AIRPORTS";
  public static String depDate = "ALL";
  public static String arrDate = "ALL";
  public static String graphToUse = "Bar Chart";
  
  public static boolean mapUsed = false;
    
  public static int graphType() {
    println(mapUsed);
    if(sort == SRT_NONE && depAirport == "ALL AIRPORTS" && arrAirport == "ALL AIRPORTS" && depDate == "ALL" && arrDate == "ALL" && !mapUsed)
      return GRH_BAR;
    else return GRH_SPREADSHEET;
  }
}

public String dateRangeRegexp(String startDate, String endDate) {
  int[] startDateTokens = int(split(startDate, '/'));
  int[] endDateTokens = int(split(endDate, '/'));
  String regexp = "";
  
  for(int i = 0; i < startDateTokens.length; i++) {
    regexp += "[" + startDateTokens[i] + "-" + endDateTokens[i] + "]" +
      ((i < (startDateTokens.length - 1)) ? "/" : "");
  }
  
  return regexp;
}

public void drawGraph(DataBaseInteraction db) {
  int graphType = DataPipe.graphType();
  if(graphType == DataPipe.GRH_BAR) {
    switch(DataPipe.graphToUse) {
      case "Bar Chart":
        if (pie != null) pie.destroy();
        pie = null;
        bar = new Bar("ORIGIN", DataPipe.view);
        bar.makePage(1);
        break;
      case "Pie Chart":
        if (bar != null) bar.destroy();
        bar = null;
        pie = new Pie("ORIGIN", DataPipe.view);
        pie.makePage(1);
        break;
    }
    if(sst != null) sst.destroy();
    sst = null;
  } else if(graphType == DataPipe.GRH_SPREADSHEET) {
    // Timofejs Cvetkovs (3/4/2023)
    if (bar != null) bar.destroy();
    bar = null;
    pie = null;
    scatter = null;
    if(sst != null) sst.destroy();
    if(sst != null) sst.destroy(); 
    String sortField = (DataPipe.sort == DataPipe.SRT_NONE) ? "FL_DATE" : ((DataPipe.sort == DataPipe.SRT_LATENESS) ? "LATENESS" : "DISTANCE");
    DataBaseInteraction.GrepQuery viewOnlyQuery;
    switch(DataPipe.view) {
      case DataPipe.VIW_ALL:
        viewOnlyQuery = null;
        break;
      case DataPipe.VIW_CANCELLED:
        viewOnlyQuery = db.gQ("CANCELLED", "1");
        break;
      case DataPipe.VIW_ONTIME:
        viewOnlyQuery = db.gQ("LATENESS", "0");
        break;
      case DataPipe.VIW_LATE:
        viewOnlyQuery = db.gQ("LATENESS", "-[1-9]+");
        break;
      default:
        viewOnlyQuery = null;
        break;
    }
    DataBaseInteraction.GrepQuery depAirportQuery = db.gQ("ORIGIN", ((DataPipe.depAirport.equals("ALL AIRPORTS")) ? ".*" : DataPipe.depAirport));
    DataBaseInteraction.GrepQuery arrAirportQuery = db.gQ("DEST", ((DataPipe.arrAirport.equals("ALL AIRPORTS")) ? ".*" : DataPipe.arrAirport));
    if(DataPipe.mapUsed) {
      if(isSelected[EVENT_DEP])  depAirportQuery = db.gQ("ORIGIN", airports);
      if(isSelected[EVENT_ARR])  arrAirportQuery = db.gQ("DEST", airports); 
      
    }
    DataBaseInteraction.GrepQuery dateRangeQuery = db.gQ("FL_DATE", ((DataPipe.depDate.equals("ALL")) ? ".*" : 
      dateRangeRegexp(DataPipe.depDate, DataPipe.arrDate)));
    sst = new Spreadsheet(db, 
      db.getFilteredFlightData(
        "flight_data",
        db.getFlightDataRowCount("flight_data"),
        (viewOnlyQuery != null) ? asList(dateRangeQuery, depAirportQuery, arrAirportQuery, viewOnlyQuery) :
          asList(dateRangeQuery, depAirportQuery, arrAirportQuery),
        asList(db.oQ(sortField, true))));
    DataPipe.mapUsed = false;
  }
}
