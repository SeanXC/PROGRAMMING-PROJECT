class Pie {
  float[] data;
  String[] labels;
  float percentage;
  int currentPage, pageCount;
  color[] colors;
  ArrayList<Float> dataList;
  ArrayList<String> labelsList;
  
  Controller a, b;

  // constructs new pie chart
  // Liam Coogan 2023-04-04
  Pie (String query, int filtering) {
    query(query, filtering);

    this.colors = new color[] {#000000, #FFFF00, #1CE6FF, #FF34FF, #FF4A46, #008941, #006FA6, #A30059,
      #FFDBE5, #7A4900, #0000A6, #63FFAC, #B79762, #004D43, #8FB0FF, #997D87,
      #5A0007, #809693, #FEFFE6, #1B4400, #4FC601, #3B5DFF, #4A3B53, #FF2F80,
      #61615A, #BA0900, #6B7900, #00C2A0, #FFAA92, #FF90C9, #B903AA, #D16100,
      #DDEFFF, #000035, #7B4F4B, #A1C299, #300018, #0AA6D8, #013349, #00846F,
      #372101, #FFB500, #C2FFED, #A079BF, #CC0744, #C0B9B2, #C2FF99, #001E09,
      #00489C, #6F0062, #0CBD66, #EEC3FF, #456D75, #B77B68, #7A87A1, #788D66,
      #885578, #FAD09F, #FF8A9A, #D157A0, #BEC459, #456648, #0086ED, #886F4C,
      #34362D, #B4A8BD, #00A6AA, #452C2C, #636375, #A3C8C9, #FF913F, #938A81,
      #575329, #00FECF, #B05B6F, #8CD0FF, #3B9700, #04F757, #C8A1A1, #1E6E00,
      #7900D7, #A77500, #6367A9, #A05837, #6B002C, #772600, #D790FF, #9B9700,
      #549E79, #FFF69F, #201625, #72418F, #BC23FF, #99ADC0, #3A2465, #922329,
      #5B4534, #FDE8DC, #404E55, #0089A3, #CB7E98, #A4E804, #324E72, #6A3A4C};
    // list of contrasting colors I found online

    currentPage = 1;
    pageCount = (dataList.size() / 64);
    if ((dataList.size() % 64) != 0) pageCount++;
    
    a = cp5.addButton("Last Page").setPosition(90, 850).setSize(100, 40).setValue(0).setColorBackground(color(42, 48, 175));
    a.getCaptionLabel().setFont(createFont("Corbel", 13));
    b = cp5.addButton("Next Page").setPosition(210, 850).setSize(100, 40).setValue(1).setColorBackground(color(42, 48, 175));
    b.getCaptionLabel().setFont(createFont("Corbel", 13));
  }

  // draws the pie chart
  // Liam Coogan 2023-04-02
  void draw() {
    float lastAngle = 0;
    int xRect = 416;
    int yRect = 10;
    for (int i = 0; i < data.length; i++) {
      if (i == 44) {
        xRect += 100;
        yRect = 10;
      }

      fill(colors[i]);
      arc(1000, 450, 600, 600, lastAngle, lastAngle+radians(data[i] * percentage));
      lastAngle += radians(data[i] * percentage);

      rect(xRect, yRect, 20, 15);
      fill(0);
      textAlign(LEFT);
      textFont(createFont("SansSerif", 13), 13);
      text(labels[i], xRect + 30, yRect + 12);
      yRect += 20;
    }
  }

  // takes data from database
  // Liam Coogan 2023-04-02
  void query (String query, int filtering) {
    ResultSet rs = de.makeRS(query, filtering);
    int col = de.chooseCol(query);
    dataList = new ArrayList<Float>();
    labelsList = new ArrayList<String>();

    try {
      labelsList.add(rs.getString(col));
      dataList.add(1.0);
      int index = 0;
      for (String label = "init"; label != null;) {
        label = rs.getString(col);
        if (!Objects.equals(label, labelsList.get(labelsList.size() - 1)) && label != null) {
          labelsList.add(label);
          dataList.add(1.0);
          index++;
        } else dataList.set(index, (dataList.get(index) + 1));
        rs.next();
      }
    }
    catch (SQLException e) {
      e.printStackTrace();
    }
  }

  void makePage(int page) {
    this.currentPage = page;
    int min, max;
    if (currentPage == pageCount) {
      min = dataList.size() - 64;
      max = dataList.size() - 1;
    }
    else {
      min = (currentPage-1)*64;
      max = (currentPage*64)-1;
    }
    
    try {
      this.data = new float [max - min + 1];
      float sum = 0;
      for (int i = min, j = 0; i <= max; i++, j++) {
        float datum = dataList.get(i);
        data[j] = datum;
        sum += datum;
      }
      percentage = 360.0 / sum;
      this.labels = new String [max - min + 1];
      for (int i = min, j = 0; i <= max; i++, j++) labels[j] = labelsList.get(i);
    }
    catch (IndexOutOfBoundsException e) {
      print("ERROR: RANGE TOO LARGE");
    }
  }
  
  void destroy() {
    a.remove();
    b.remove();
  }
}
