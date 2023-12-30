// all of this code written by Beatrice Saviozzi
class Button {
  int x, y, width, height;
  String label;
  int event;
  color backColor, labelColor;
  PFont widgetFont;
  int[] numberClick = new int[13];
  Button(int x, int y, int width, int height, String label,
    color backColor, PFont widgetFont, int event) {
    this.x = x;
    this.y = y;
    this.width = width;
    this.height = height;
    this.label = label;
    this.event = event;
    this.backColor = backColor;
    this.widgetFont = widgetFont;
    labelColor= color(255);
    background(0);
  }

  void setup () {
    for (int i = 0; i < 13; i++) {
      isSelected[i] = false;
    }
    for (int i = 0; i < 13; i++) {
      numberClick[i] = 0;
    }
  }

  void draw() {
    if (!isSelected[1] && !isSelected[2])
      DataPipe.sort = DataPipe.SRT_NONE;
    if (!isSelected[3] && !isSelected[4] && !isSelected[5])
      DataPipe.view = DataPipe.VIW_ALL;

    if (isSelected[event] && !isSelected[EVENT_GOBACK]) {
      fill(color(150, 70, 240));
    } else {
      fill(backColor);
    }
    rect(x, y, width, height);
    fill(labelColor);
    text(label, x+(width/2), y+height-13);
    if (isSelected[EVENT_GOBACK])
    {
      for (int i = 0; i < 13; i++) {
        numberClick[i] = 0;
      }
    }
    if (isSelected[EVENT_MAP])
    {
      for (int i = 0; i < 13; i++) {
        numberClick[i] = 0;
      }
    }
  }

  // returns event when mouse clicked on button

  int getEvent(int mX, int mY) {
    if (mX > x && mX < x+width && mY > y && mY < y+height) {
      return event;
    }
    return EVENT_NULL;
  }

  void setColor(int index)
  {
    if (!isSelected[index])
    {
      numberClick[index] = 0;
    }
    isSelected[EVENT_SEND] = false;
    isSelected[EVENT_GOBACK] = false;
    isSelected[index] = true;
    if (mousePressed) {
      numberClick[index]++;
      if (numberClick[index] % 2 == 0) {        // if the button is clicked twice, it is deselected - beatrice 2/04
        isSelected[index] = false;
      }
    }
  }


  // different actions are performed beased on the event of a button - beatrice 26/03
  void pressed(int event) {
    switch(event) {
    case EVENT_LATENESS:
      println("lateness");
      setColor(EVENT_LATENESS);
      isSelected[EVENT_DISTANCE] = false;
      isSelected[EVENT_MAP] = false;
      DataPipe.sort = DataPipe.SRT_LATENESS;
      break;

    case EVENT_DISTANCE:
      println("distance");
      setColor(EVENT_DISTANCE);
      isSelected[EVENT_LATENESS] = false;
      isSelected[EVENT_MAP] = false;
      DataPipe.sort = DataPipe.SRT_DISTANCE;
      break;

    case EVENT_CANCELLED:
      println("cancelled");
      setColor(EVENT_CANCELLED);
      isSelected[EVENT_LATE] = false;
      isSelected[EVENT_ONTIME] = false;
      isSelected[EVENT_MAP] = false;
      DataPipe.view = DataPipe.VIW_CANCELLED;
      break;

    case EVENT_LATE:
      println("late");
      setColor(EVENT_LATE);
      isSelected[EVENT_CANCELLED] = false;
      isSelected[EVENT_ONTIME] = false;
      isSelected[EVENT_MAP] = false;
      DataPipe.view = DataPipe.VIW_LATE;
      break;

    case EVENT_ONTIME:
      println("on time");
      setColor(EVENT_ONTIME);
      isSelected[EVENT_CANCELLED] = false;
      isSelected[EVENT_LATE] = false;
      isSelected[EVENT_MAP] = false;
      DataPipe.view = DataPipe.VIW_ONTIME;
      break;

    case EVENT_MAP:
      DataPipe.mapUsed = true;

      println("map");
      setColor(EVENT_MAP);
      isSelected[EVENT_LATE] = false;
      isSelected[EVENT_LATENESS] = false;
      isSelected[EVENT_DISTANCE] = false;
      isSelected[EVENT_CANCELLED] = false;
      isSelected[EVENT_ONTIME] = false;
      break;

    case EVENT_DEP:
      println("dep");
      setColor(EVENT_DEP);
      isSelected[EVENT_ARR] = false;
      break;

    case EVENT_ARR:
      println("arr");
      setColor(EVENT_ARR);
      isSelected[EVENT_DEP] = false;
      break;

    case EVENT_SEND:
      println("send");
      loading = true;
      isSelected[EVENT_SEND] = true;
      if (DataPipe.graphType() != DataPipe.GRH_INVALID)
        //drawGraph(db);
        thread("drawGraphThread");
      isSelected[EVENT_MAP] = false;
      panel.depAir.close();
      panel.arrAir.close();
      panel.depD.close();
      panel.arrD.close();
      float fromVal = panel.depD.getValue();
      float toVal = panel.arrD.getValue();
      if (fromVal != 0 && toVal == 0)
      {
        panel.arrD.setValue(5.0);
      }
      break;

    case EVENT_GOBACK:
      println("go back");
      for (int i = 0; i < 13; i++)
      {
        if (i != EVENT_GOBACK && i != EVENT_SEND)
          isSelected[i] = false;
      }
      for (int i = 50; i < 100; i++)
      {
        isSelectedState[i] = false;
      }
      isSelected[EVENT_GOBACK] = true;

      // destroy graphs (Timofejs Cvetkovs 6/4/2023)
      if (sst != null) sst.destroy();
      sst = null;
      if (pie != null) pie.destroy();
      pie = null;
      if (bar != null) bar.destroy();
      bar = null;
      panel.depAir.setLabel("Departure airports");
      panel.arrAir.setLabel("Arrival airports");
      panel.depD.setLabel("From (date)");
      panel.arrD.setLabel("To (date)");
      panel.graphType.setLabel("Bar chart");
      panel.depAir.setValue(0.00);
      panel.arrAir.setValue(0.00);
      panel.depD.setValue(0.00);
      panel.arrD.setValue(0.00);
      panel.graphType.setValue(0.00);
      DataPipe.sort = DataPipe.SRT_NONE;
      DataPipe.view = DataPipe.VIW_ALL;
      DataPipe.depAirport = "ALL AIRPORTS";
      DataPipe.arrAirport = "ALL AIRPORTS";
      DataPipe.depDate = "ALL";
      DataPipe.arrDate = "ALL";
      airports = "";
      isSelected[EVENT_SEND] = false;
      break;
    }
  }

  // set different color if mouse hovers on buttons
  void hover(int event) {
    switch(event) {
    case EVENT_LATENESS:
      this.backColor = color(0, 114, 224);
      break;
    case EVENT_DISTANCE:
      this.backColor = color(0, 114, 224);
      break;
    case EVENT_CANCELLED:
      this.backColor = color(0, 114, 224);
      break;
    case EVENT_LATE:
      this.backColor = color(0, 114, 224);
      break;
    case EVENT_ONTIME:
      this.backColor = color(0, 114, 224);
      break;
    case EVENT_MAP:
      this.backColor = color(0, 114, 224);
      break;
    case EVENT_SEND:
      this.backColor = color(0, 114, 224);
      break;
    case EVENT_GOBACK:
      this.backColor = color(0, 114, 224);
      break;
    case EVENT_ARR:
      this.backColor = color(0, 114, 224);
      break;
    case EVENT_DEP:
      this.backColor = color(0, 114, 224);
      break;
    default:
      this.backColor = color(42, 48, 175);
    }
  }
}

void drawGraphThread() {
  drawGraph(db);
}
