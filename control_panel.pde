// code written by Beatrice Saviozzi
class ControlPanel {
  int dx = 0;
  int dy = 0;
  int maxdx = 400;
  int maxdy = 900;
  PFont font;

  // creating dropdown lists
  DropdownList depD;
  DropdownList arrD;
  DropdownList depAir;
  DropdownList arrAir;
  DropdownList graphType;

  void setup() {
    // buttons - 20/03
    Button lateness, distance, canceled, late, onTime, map, send, goBack, departure, arrival;
    font = loadFont("Corbel-30.vlw");
    textFont(font);

    lateness = new Button(10, 125, 190, 35, "Lateness", buttonColor, font, EVENT_LATENESS);
    distance = new Button(200, 125, 190, 35, "Distance", buttonColor, font, EVENT_DISTANCE);
    canceled = new Button(10, 210, 127, 35, "Canceled flights", buttonColor, font, EVENT_CANCELLED);
    late = new Button(137, 210, 127, 35, "Late flights", buttonColor, font, EVENT_LATE);
    onTime = new Button(263, 210, 127, 35, "On Time flights", buttonColor, font, EVENT_ONTIME);
    map = new Button((400/2)-100, 640, 200, 35, "Map", buttonColor, font, EVENT_MAP);
    send = new Button((400/2)-150, 730, 300, 35, "Send query", buttonColor, font, EVENT_SEND);
    goBack = new Button((400/2)-150, 780, 300, 35, "Make another selection", buttonColor, font, EVENT_GOBACK);
    departure = new Button(800, 20, 130, 35, "Departures", buttonColor, font, EVENT_DEP);
    arrival = new Button(935, 20, 130, 35, "Arrivals", buttonColor, font, EVENT_ARR);

    buttonList = new ArrayList();
    buttonList.add(lateness);
    buttonList.add(distance);
    buttonList.add(canceled);
    buttonList.add(late);
    buttonList.add(onTime);
    buttonList.add(map);
    buttonList.add(send);
    buttonList.add(goBack);

    buttonMapList = new ArrayList();
    buttonMapList.add(departure);
    buttonMapList.add(arrival);


    // states - 26/03
    States florida, texas, southCarolina, washington, oregon, california, alaska, hawaii, montana,
      idaho, nevada, utah, arizona, newMexico, colorado, wyoming, northDakota, southDakota, nebraska,
      kansas, oklahoma, arkansas, lousiana, mississipi, alabama, georgia, northCarolina, tennessee,
      kentucky, missouri, iowa, minnesota, wisconsin, illinois, indiana, michigan, virginia, westVirginia,
      ohio, newYork, newJersey, newHampshire, maine, rhodeIsland, connecticut, delaware, maryland, pennsylvania, vermont, massachusetts;

    washington = new States(545, 75, EVENT_WASH);
    oregon = new States(520, 180, EVENT_ORE);
    california = new States(495, 435, EVENT_CAL);
    alaska = new States(540, 710, EVENT_AL);
    hawaii = new States(735, 810, EVENT_HAW);
    montana = new States(735, 130, EVENT_MON);
    idaho = new States(630, 225, EVENT_IDA);
    nevada = new States(550, 337, EVENT_NEV);
    utah = new States(665, 410, EVENT_UTH);
    arizona = new States(645, 510, EVENT_ARIZ);
    newMexico = new States(755, 530, EVENT_NMEX);
    wyoming = new States(760, 260, EVENT_WYO);
    colorado = new States(780, 387, EVENT_COL);
    northDakota = new States(886, 128, EVENT_NDAK);
    southDakota = new States(886, 228, EVENT_SDAK);
    nebraska = new States(900, 370, EVENT_NEBR);
    kansas = new States(923, 467, EVENT_KAN);
    oklahoma = new States(938, 560, EVENT_OKL);
    arkansas = new States(1050, 572, EVENT_ARK);
    lousiana = new States(1050, 680, EVENT_LOUI);
    mississipi= new States(1115, 653, EVENT_MIPP);
    alabama = new States(1177, 635, EVENT_ALAB);
    georgia = new States(1255, 640, EVENT_GEO);
    tennessee = new States(1197, 506, EVENT_TEN);
    kentucky = new States(1215, 450, EVENT_KEN);
    northCarolina = new States(1350, 485, EVENT_NCAR);
    virginia = new States(1340, 430, EVENT_VIR);
    westVirginia = new States(1283, 420, EVENT_WVIR);
    missouri = new States(1050, 470, EVENT_MISS);
    iowa = new States(1033, 358, EVENT_IOWA);
    minnesota = new States(1000, 210, EVENT_MIN);
    wisconsin = new States(1100, 253, EVENT_WIS);
    michigan = new States(1190, 250, EVENT_MICH);
    illinois = new States(1115, 365, EVENT_ILL);
    indiana = new States(1170, 365, EVENT_IND);
    texas = new States(915, 697, EVENT_TEX);
    florida = new States(1315, 750, EVENT_FLO);
    southCarolina = new States(1320, 590, EVENT_SCAR);
    ohio = new States(1245, 390, EVENT_OHI);
    newYork = new States(1380, 235, EVENT_NY);
    newJersey = new States(1405, 350, EVENT_NJER);
    newHampshire = new States(1440, 215, EVENT_NHAM);
    rhodeIsland = new States(1550, 280, EVENT_RI);
    connecticut = new States(1550, 322, EVENT_CONN);
    delaware = new States(1550, 397, EVENT_DELA);
    maryland = new States(1550, 435, EVENT_MARY);
    pennsylvania = new States(1340, 350, EVENT_PENN);
    vermont = new States(1415, 200, EVENT_VER);
    maine = new States(1470, 160, EVENT_MAI);
    massachusetts = new States(1300, 160, EVENT_MASS);

    statesList = new ArrayList();
    statesList.add(florida);
    statesList.add(texas);
    statesList.add(southCarolina);
    statesList.add(washington);
    statesList.add(oregon);
    statesList.add(california);
    statesList.add(alaska);
    statesList.add(hawaii);
    statesList.add(montana);
    statesList.add(idaho);
    statesList.add(nevada);
    statesList.add(utah);
    statesList.add(newMexico);
    statesList.add(colorado);
    statesList.add(wyoming);
    statesList.add(northDakota);
    statesList.add(southDakota);
    statesList.add(nebraska);
    statesList.add(arizona);
    statesList.add(kansas);
    statesList.add(oklahoma);
    statesList.add(arkansas);
    statesList.add(lousiana);
    statesList.add(mississipi);
    statesList.add(alabama);
    statesList.add(georgia);
    statesList.add(northCarolina);
    statesList.add(tennessee);
    statesList.add(kentucky);
    statesList.add(missouri);
    statesList.add(iowa);
    statesList.add(minnesota);
    statesList.add(wisconsin);
    statesList.add(illinois);
    statesList.add(indiana);
    statesList.add(michigan);
    statesList.add(virginia);
    statesList.add(westVirginia);
    statesList.add(ohio);
    statesList.add(newYork);
    statesList.add(newJersey);
    statesList.add(newHampshire);
    statesList.add(maine);
    statesList.add(rhodeIsland);
    statesList.add(connecticut);
    statesList.add(delaware);
    statesList.add(maryland);
    statesList.add(pennsylvania);
    statesList.add(vermont);
    statesList.add(massachusetts);

    // dropdown list - 30/03
    ControlP5 depAirport;
    ControlP5 arrAirport;
    ControlP5 depDate;
    ControlP5 arrDate;

    depDate = new ControlP5(thisSketch);
    arrDate = new ControlP5(thisSketch);
    depAirport = new ControlP5(thisSketch);
    arrAirport = new ControlP5(thisSketch);

    depD = depDate.addDropdownList("From (date)");
    costumize(depD, getDatesArray(), 10, 345);
    arrD = arrDate.addDropdownList("To (date)");
    costumize(arrD, getDatesArray(), 210, 345);
    depAir = depAirport.addDropdownList("Departure airport");
    costumize(depAir, airports(), 10, 295);
    arrAir = arrAirport.addDropdownList("Arrival airport");
    costumize(arrAir, airports(), 210, 295);
    
    graphType = cp5.addDropdownList("Bar Chart");
    String[] graphTypes = {"Bar Chart", "Pie Chart"/*, "Scatter Plot"*/};
    costumize(graphType, graphTypes, 111, 535);
  }

  void draw() {
    PFont stdFont;
    stdFont = loadFont("Corbel-30.vlw");
    noStroke();
    fill(160, 195, 255);
    rect(dx, dy, maxdx, maxdy);
    textFont(stdFont);
    textAlign(CENTER);
    fill(0, 16, 77);
    textSize(25);
    text("Select how you want to filter the data", (maxdx/2), 50);
    textSize(18);
    text("click the send button to view your selection", (maxdx/2), 70);
    textSize(15);
    text("Sort by", (maxdx/2), 115);
    text("View only", (maxdx/2), 200);
    text("Select", (maxdx/2), 285);
    //text("Select this option if you want to view the data in a spreadsheet", (maxdx/2), 430);
    text("Select this option if you want to make your", (maxdx/2), 615);
    text("selection using a map", (maxdx/2), 630);
    text("Select the type of graph", (maxdx/2), 525);
  }

  // costumizes the dropdown list - 30/03
  void costumize(DropdownList myList, String[] list, int x, int y)
  {
    myList.setItemHeight(30);
    myList.setBarHeight(30);
    myList.addItems(list);
    myList.setSize(180, 200);
    myList.setPosition(x, y);
    myList.getCaptionLabel().setFont(createFont("Corbel", 13));
    myList.setColorBackground(color(42, 48, 175));
    myList.setType(ScrollableList.DROPDOWN);
    myList.setOpen(false);
  }
}

// creates an array of strings from data and airports in the database  - beatrice 30/03
String[] getDatesArray() {
  ResultSet d = db.distinctValues("flight_Data", "FL_DATE", true);
  ArrayList<String> datesArrayList = new ArrayList<String>();
  try {
    while (d.next())
    {
      datesArrayList.add(d.getString(1));
    }
  }
  catch(SQLException e) {
  }
  String[] dates = new String[datesArrayList.size()];
  dates = datesArrayList.toArray(dates);
  return dates;
}
String[] airports() {
  ResultSet d = db.distinctValues("flight_Data", "ORIGIN", true);
  ArrayList<String> airportsArrayList = new ArrayList<String>();
  try {
    while (d.next())
    {
      airportsArrayList.add(d.getString(1));
    }
  }
  catch(SQLException e) {
  }
  String[] airports = new String[airportsArrayList.size()];
  airports = airportsArrayList.toArray(airports);
  return airports;
}

//move the airplane
