// code written by Beatrice Saviozzi - 16/03/2023 

class ControlPanel {
  // x = 0-400; y = 0-900
  int dx = 0;
  int dy = 0;
  int maxdx = 400;
  int maxdy = 900;
  
  void draw(){
    PFont stdFont;
    stdFont=loadFont("Corbel-30.vlw");
    
    noStroke();
    fill(160, 195, 255);
    rect(dx, dy, maxdx, maxdy);
    textFont(stdFont);
    textAlign(CENTER);
    fill(0, 16, 77);
    text("Make your choice", (maxdx/2), 50);
    textSize(15);
    text("Sort by", (maxdx/2), 90);
    text("View only", (maxdx/2), 155);
  }
}
