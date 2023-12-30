class Heat {
  PShape map;
  Descriptive de;
  PShape[] states;
  float[] data;
  float max;
  Heat (int filtering) {
    this.de = new Descriptive();
    map = loadShape("us.svg");
    states = new PShape[50];
    query(filtering);
    String[] stateCodes = new String[] {"ak", "al", "ar", "az", "ca", "co", "ct", "de", "fl", "ga", "hi", "ia", "id", "il", "in", "ks", "ky", "la", "ma",
      "md", "me", "mi", "mn", "mo", "ms", "mt", "nc", "nd", "ne", "nh", "nj", "nm", "nv", "ny", "oh", "ok", "or", "pa",
      "ri", "sc", "sd", "tn", "tx", "ut", "va", "vt", "wa", "wi", "wv", "wy"};
    for (int i = 0; i < states.length; i++) states[i] = map.getChild(stateCodes[i]);
  }

  void draw() {
    shape(map, 520, 130);
    fill(100);
    states[6].disableStyle();
    shape(states[6], 520, 130);

    for (int i = 0; i < states.length; i++) {
      states[i].disableStyle();
      fill((255 - ((data[i]/max) * 255)), 0, 0);
      shape(states[i], 520, 130);
    }
  }

  boolean query(int filtering) {
    ResultSet rs = de.makeRS("ORIGIN_STATE_ABR", filtering); // heat map *only* displays origin state

    ArrayList<Float> dataList = new ArrayList<Float>();
    ArrayList<String> labelsList = new ArrayList<String>();

    try {
      labelsList.add(rs.getString(7));
      dataList.add(1.0);
      int index = 0;
      for (String label = "init"; label != null; ) {
        label = rs.getString(7);
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
      return false;
    }

    print("Test");

    try {
      this.data = new float [50];
      for (int i = 0, j = 0; j < dataList.size(); i++, j++) {
        if (j == 38 || j == 43 || j == 47) j++;
        data[i] = dataList.get(j);
      }

      Descriptive de = new Descriptive();
      this.max = de.largest(data);

      return true;
    }
    catch (IndexOutOfBoundsException e) {
      print("ERROR: NOT ALL STATES INCLUDED");
      return false;
    }
  }
}
