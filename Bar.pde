class Bar { //<>// //<>//
  BarChart bar;
  int currentPage, pageCount;
  float[] data;
  String[] labels;
  ArrayList<Float> dataList;
  ArrayList<String> labelsList;
  
  Controller a, b;

  // constructs new bar chart
  // Liam Coogan 2023-04-04
  Bar(String query, int filtering) {    
    query(query, filtering);
    currentPage = 1;
    pageCount = (dataList.size() / 20);
    if ((dataList.size() % 20) != 0) pageCount++;

    bar = new BarChart(thisSketch);
    bar.showCategoryAxis(true);
    bar.setBarColour(color(42, 48, 175));
    bar.setBarGap(4);    
    bar.showValueAxis(true);
    bar.setMinValue(0);
    bar.setMaxValue(Collections.max(dataList));

    
    a = cp5.addButton("Last Page").setPosition(90, 850).setSize(100, 40).setValue(0).setColorBackground(color(42, 48, 175));
    a.getCaptionLabel().setFont(createFont("Corbel", 13));
    b = cp5.addButton("Next Page").setPosition(210, 850).setSize(100, 40).setValue(1).setColorBackground(color(42, 48, 175));
    b.getCaptionLabel().setFont(createFont("Corbel", 13));
  }

  // gathers data for bar chart from database
  // Liam Coogan 2023-04-04
  void query (String query, int filtering) {
    ResultSet rs = de.makeRS(query, filtering);
    int col = de.chooseCol(query);
    dataList = new ArrayList<Float>();
    labelsList = new ArrayList<String>();

    try {
      labelsList.add(rs.getString(col));
      dataList.add(1.0);
      int index = 0;
      for (String label = "init"; label != null; ) {
        label = rs.getString(col);
        if (!Objects.equals(label, labelsList.get(labelsList.size() - 1)) && label != null) {
          labelsList.add(label);
          dataList.add(1.0);
          index++;
        } else dataList.set(index, (dataList.get(index) + 1));
        rs.next();
      }
    }
    catch (Exception e) {
      e.printStackTrace();
    }
  }

  // creates a new page
  // Liam Coogan 2023-04-04
  void makePage (int page) {
    this.currentPage = page;
    int min, max;
    if (currentPage == pageCount) {
      min = dataList.size() - 20;
      max = dataList.size() - 1;
    }
    else {
      min = (currentPage-1)*20;
      max = (currentPage*20)-1;
    }
    
    try {
      this.data = new float [max - min];
      for (int i = min, j = 0; i < max; i++, j++) data[j] = dataList.get(i);

      this.labels = new String [max - min];
      for (int i = min, j = 0; i < max; i++, j++) labels[j] = labelsList.get(i);
    }
    catch (Exception e) {
      e.printStackTrace();
    }
    
    bar.setData(data);
    bar.setBarLabels(labels);
  }
  
  void destroy() {
    this.a.remove();
    this.b.remove();
  }
  
  // draws bar chart
  // Liam Coogan 2023-04-02
  void draw() {
    textFont(createFont("SansSerif", 13), 13);
    bar.draw(430, 5, 1170, 885);
  }
}
