class Scatter {
  XYChart scatter;
  DataBaseInteraction db;
  Descriptive de;
  float[] xData, yData;
  int binSize;

  // constructs new scatter plot
  // Liam Coogan 2023-04-02
  Scatter(DataBaseInteraction db, String query, int binSize, int filtering) {
    scatter = new XYChart(thisSketch);
    this.db = db;
    this.de = new Descriptive();
    this.binSize = binSize;

    query(query, filtering);

    scatter.setData(xData, yData);
    scatter.showXAxis(true);
    scatter.showYAxis(true);

    scatter.setPointColour(color(42, 48, 175));
    scatter.setPointSize(5);

    textFont(createFont("SansSerif", 10), 10);
  }

  // draws a scatter plot
  // Liam Coogan 2023-04-02
  void draw() {
    scatter.draw(400, 5, 1200, 875);
  }

  // gathers data for scatter plot from database
  // Liam Coogan 2023-04-02
  boolean query(String query, int filtering) {

    ResultSet rs = de.makeRS(query, filtering);
    int col = de.chooseCol(query);

    ArrayList<Float> xDataList = new ArrayList<Float>();
    ArrayList<Float> yDataList = new ArrayList<Float>();

    try {
      xDataList.add((float) rs.getInt(col));
      yDataList.add(1.0);
      int index = 0;
      for (float value = 0; rs.next(); ) {
        value = rs.getInt(col);
        if (value > (index * binSize)) {
          index++;
          xDataList.add((float) (index * binSize));
          yDataList.add(1.0);
        } else yDataList.set(index, (yDataList.get(index) + 1));
      }
    }
    catch (Exception e) {
      e.printStackTrace();
      return false;
    }

    try {
      this.xData = new float [xDataList.size()];
      for (int j = 0; j < xData.length; j++) xData[j] = xDataList.get(j);

      this.yData = new float [yDataList.size()];
      for (int j = 0; j < yData.length; j++) yData[j] = yDataList.get(j);
      return true;
    }
    catch (Exception e) {
      e.printStackTrace();
      return false;
    }
  }
}
