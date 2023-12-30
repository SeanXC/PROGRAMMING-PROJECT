import java.sql.*; // SQLite driver library //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>//
import java.util.regex.Pattern; // dependency for SQLite REGEXP functionality
import java.util.List;
import java.util.Objects;
import java.util.Arrays;
import java.util.Collections;
import static java.util.Arrays.asList;
import controlP5.*; // GUI library
import org.gicentre.utils.stat.*; // Stats classes

PApplet thisSketch = this; // necessary for the Bar and Scatter classses;

ArrayList buttonList; // list to have buttons - beatrice - 26/03
ArrayList buttonMapList; // list to have buttons - beatrice - 26/03
ArrayList statesList; // list to have us states buttons - beatrice - 26/03
PImage mapImage;
int option;
color buttonColor = color(42, 48, 175);
boolean[] isSelectedState = new boolean[100];
boolean[] isSelected = new boolean[13];
String inputST = "";  //search bar input string
int input = 0;
String airports = "";
ControlPanel panel;      // control panel - beatrice
ControlP5 cp5; //bottons of spreadsheet- Shengxin Chen 30/03/2023
PImage airplane;
int xPlane = 400;

void settings() {
  size(1600, 900);
}

boolean loading = false;

Bar bar;
Spreadsheet sst;// call class Spreadsheet - shengxin Chen 30/03/2023
Pie pie;
DataBaseInteraction db;
Descriptive de;
Scatter scatter;

void setup() {
  surface.setTitle("Flight Data Analysis Software (Group 12)");
  cp5 = new ControlP5(this);// creat new object cp5 (bottons for speadsheet) - Shengxin Chen 30/03/2023

  de = new Descriptive();

  db = new DataBaseInteraction();
  db.createFlightDataTable("flight_data");
  if (db.getFlightDataRowCount("flight_data") == 0)
    selectInput("Select a file to process:", "tableFileSelected");

  panel = new ControlPanel();
  panel.setup();

  thread("displayLoading");
}

void draw() {
  background(230);

  if (loading) {
    fill(160, 195, 255);
    rect(400, 0, 1200, 1600);
    textSize(40);
    fill(color(255));
    textAlign(CENTER, CENTER);
    text("Loading...", 1000, height / 2);    
    airplane = loadImage("airplane.png");        // draws airplane during the loading - beatrice 13/04
    image(airplane, xPlane, 400, 180, 100);
    xPlane = xPlane+12;
  }

  fill(0);
  textSize(24);
  textAlign(LEFT, TOP);

  panel.draw();
  for (int i = 0; i<buttonList.size(); i++) {            // drawing the buttons for user interaction - beatrice 26/03
    Button singleButton = (Button)buttonList.get(i);
    singleButton.draw();
  }

  if (sst != null) sst.draw();

  if (sst != null || bar != null || pie != null) loading = false;

  if (isSelected[EVENT_MAP])
  {                                                            // draws map if button "map" is selected - beatrice 30/03
    mapImage = loadImage("Map_of_USA.png");
    image(mapImage, 400, 0, 1200, 900);
    for (int i = 0; i<statesList.size(); i++) {
      States singleState = (States)statesList.get(i);
      singleState.draw();
    }
    for (int i = 0; i<buttonMapList.size(); i++) {            // drawing the buttons for user interaction - beatrice 26/03
      Button singleButton = (Button)buttonMapList.get(i);
      singleButton.draw();
    }
    bar = null;
  }
    
  if (!isSelected[EVENT_MAP] && !isSelected[EVENT_SEND]) //draws rectangle when no graphs / spreadsheet is called - beatrice 13/04
  {
    xPlane = 400;
    fill(160, 195, 255);
    rect(400, 0, 1200, 1600);
  }

  if (bar != null) bar.draw();
  if (pie != null) pie.draw();
}

// callback for file selection method
// (Timofejs Cvetkovs 16/03/2023)
void tableFileSelected(File selection) {
  if (selection != null) {
    db.createFlightDataTable("flight_data");
    db.loadFlightDataTable("flight_data", selection.getAbsolutePath());
  }
}

void mousePressed() {
  // when the button is pressed, the program will perfom different actions - beatrice 26/03
  int event;
  for (int i = 0; i<buttonList.size(); i++) {
    Button singleButton = (Button) buttonList.get(i);
    event = singleButton.getEvent(mouseX, mouseY);
    singleButton.pressed(event);
  }

  for (int i = 0; i<buttonMapList.size(); i++) {
    Button singleButton = (Button) buttonMapList.get(i);
    event = singleButton.getEvent(mouseX, mouseY);
    singleButton.pressed(event);
  }

  // draws buttons on the map and when the button is pressed, the program will perfom different actions - beatrice 26/03
  int eventState;
  for (int i = 0; i<statesList.size(); i++) {
    States singleState = (States)statesList.get(i);
    eventState = singleState.getEvent(mouseX, mouseY);
    singleState.clicked(eventState);
  }
  if (sst != null) sst.spreedsheetMP();//call spreedsheetMousePressed function in spreadsheet calss - Shengxin Chen 30/03/2023

  if (bar != null) {
    if (mouseX >= 90 && mouseX <= 190 && mouseY >= 850 && mouseY <= 890 && bar.currentPage != 1) bar.makePage(bar.currentPage - 1);
    if (mouseX >= 210 && mouseX <= 310 && mouseY >= 850 && mouseY <= 890 && bar.currentPage != bar.pageCount) bar.makePage(bar.currentPage + 1);
  }

  if (pie != null) {
    if (mouseX >= 90 && mouseX <= 190 && mouseY >= 850 && mouseY <= 890 && pie.currentPage != 1) pie.makePage(pie.currentPage - 1);
    if (mouseX >= 210 && mouseX <= 310 && mouseY >= 850 && mouseY <= 890 && pie.currentPage != pie.pageCount) pie.makePage(pie.currentPage + 1);
  }
}

// change color if hover on buttons - beatrice 26/03
void mouseMoved() {
  int event;

  for (int i = 0; i<buttonList.size(); i++) {
    Button singleButton = (Button) buttonList.get(i);
    event = singleButton.getEvent(mouseX, mouseY);
    singleButton.hover(event);
  }
  for (int i = 0; i<buttonMapList.size(); i++) {
    Button singleButton = (Button) buttonMapList.get(i);
    event = singleButton.getEvent(mouseX, mouseY);
    singleButton.hover(event);
  }
}

//search bar key pressed function (spreadsheet)
//Shengxin Chen - 08/04/2023
void keyPressed() {
  if (sst != null)
  {
    if (key == ENTER) {
      inputST = "";
      input = 0;
    } else if (key <= '9' && key >='0')
    {
      inputST += key;
      input = int(inputST);
    } else if (key == BACKSPACE)
    {
      input = input / 10;
      inputST = input + "";
    }
  }
}

// returns the user-selected string from the dropdown list - beatrice 30/03 & liam 2023-04-13
void controlEvent(ControlEvent event) {
  switch(event.getController().getName())
  {
  case "Departure airport":
    DataPipe.depAirport = (String)((HashMap) panel.depAir.getItems().get((int) event.getValue())).get("name");
    break;
  case "Arrival airport":
    DataPipe.arrAirport = (String)((HashMap) panel.arrAir.getItems().get((int) event.getValue())).get("name");
    break;
  case "From (date)":
    DataPipe.depDate = (String)((HashMap) panel.depD.getItems().get((int) event.getValue())).get("name");
    break;
  case "To (date)":
    DataPipe.arrDate = (String)((HashMap) panel.depD.getItems().get((int) event.getValue())).get("name");
    break;
  case "Bar Chart":
    DataPipe.graphToUse = (String)((HashMap) panel.graphType.getItems().get((int) event.getValue())).get("name");
    if (event.getValue() == 0 ) DataPipe.graphToUse = "Bar Chart";
    else if (event.getValue() == 1) DataPipe.graphToUse = "Pie Chart";
    else print ("ERROR: INVALID OPTION");
    print("Testing2");
    break;
  }
}
