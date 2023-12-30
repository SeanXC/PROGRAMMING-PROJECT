//begin designing a spreadsheet in personal main code - Shengxin Chen 16/03/2023
//convert Spreadsheet into a separaet class - ShengxinChen 30/03/2023
//modify style of buttons and illustration to fit design style Shengxin Chen - 09/04/2023
public class Spreadsheet {
  String[][] data;
  String [][] fullData;
  String [][] newAr;
  int fullDataCols = 18;
  int rowsPerPage = 13;
  int totalRows = 0;
  int rows = 13;
  int cols = 8;
  int pageNum = 1;
  int rowNumber = 1;
  int cellRow = 0;
  int cellCol = 0;
  int boxWidth = 136;
  int boxHeight = 50;
  int addWidth = 66;
  int addHeight = 50;
  int posX = 400;

  // Timofejs Cvetkovs (3/4/2023)
  //private Controller prevButton, nextButton, resetButton, searchBar;
  private Controller prevButton, nextButton, resetButton;

  public Spreadsheet(DataBaseInteraction db, ResultSet rs) {
    try {
      // lodad database data into array
      data = new String[db.getFlightDataRowCount("flight_data")][fullDataCols];
      //asList(db.gQ("ORIGIN", originAP))
      try {
        int row = 0;
        int cells = 0;
        int fullCells = 0;
        //replace data array with full data - Shengxin Chen - 06/06/2023
        while (rs.next()) {
          data[row][0] = rs.getString("FL_DATE");
          data[row][1] = rs.getString("MKT_CARRIER");
          data[row][2] = rs.getString("MKT_CARRIER_FL_NUM");
          data[row][3] = rs.getString("ORIGIN");
          data[row][4] = rs.getString("ORIGIN_CITY_NAME");
          data[row][5] = rs.getString("ORIGIN_STATE_ABR");
          data[row][6] = rs.getString("ORIGIN_WAC");
          data[row][7] = rs.getString("DEST");
          data[row][8] = rs.getString("DEST_CITY_NAME");
          data[row][9] = rs.getString("DEST_STATE_ABR");
          data[row][10] = rs.getString("DEST_WAC");
          data[row][11] = rs.getString("CRS_DEP_TIME");
          data[row][12] = rs.getString("DEP_TIME");
          data[row][13] = rs.getString("CRS_ARR_TIME");
          data[row][14] = rs.getString("ARR_TIME");
          data[row][15] = rs.getString("CANCELLED");
          data[row][16] = rs.getString("DIVERTED");
          data[row][17] = rs.getString("DISTANCE");
          row++;
          cells += cols;
          fullCells += fullDataCols;
        }

        fullData = new String[fullCells/fullDataCols][fullDataCols];
        newAr = new String [(cells/cols)][cols];
        int tmpRow = 0;
        while (tmpRow<(cells/cols)) {
          //improved newData array to get selected data
          //improved newData array to 2D array - Shengxin Chen 11/04/2023
          newAr[tmpRow][0]=data[tmpRow][3];
          newAr[tmpRow][1]=data[tmpRow][7];
          newAr[tmpRow][2]=data[tmpRow][4];
          newAr[tmpRow][3]=data[tmpRow][8];
          newAr[tmpRow][4]=data[tmpRow][13];
          newAr[tmpRow][5]=data[tmpRow][14];
          newAr[tmpRow][6]=data[tmpRow][0];
          newAr[tmpRow][7]=data[tmpRow][17];
          tmpRow++;
          totalRows = tmpRow;
        }
        int rowNumberTmp = 0;
        while (rowNumberTmp<(fullCells/fullDataCols)) {
          //full data array - Shengxin Chen 11/04/2023
          fullData[rowNumberTmp][0]=data[rowNumberTmp][0];
          fullData[rowNumberTmp][1]=data[rowNumberTmp][1];
          fullData[rowNumberTmp][2]=data[rowNumberTmp][2];
          fullData[rowNumberTmp][3]=data[rowNumberTmp][3];
          fullData[rowNumberTmp][4]=data[rowNumberTmp][4];
          fullData[rowNumberTmp][5]=data[rowNumberTmp][5];
          fullData[rowNumberTmp][6]=data[rowNumberTmp][6];
          fullData[rowNumberTmp][7]=data[rowNumberTmp][7];
          fullData[rowNumberTmp][8]=data[rowNumberTmp][8];
          fullData[rowNumberTmp][9]=data[rowNumberTmp][9];
          fullData[rowNumberTmp][10]=data[rowNumberTmp][10];
          fullData[rowNumberTmp][11]=data[rowNumberTmp][11];
          fullData[rowNumberTmp][12]=data[rowNumberTmp][12];
          fullData[rowNumberTmp][13]=data[rowNumberTmp][13];
          fullData[rowNumberTmp][14]=data[rowNumberTmp][14];
          fullData[rowNumberTmp][15]=data[rowNumberTmp][15];
          fullData[rowNumberTmp][16]=data[rowNumberTmp][16];
          fullData[rowNumberTmp][17]=data[rowNumberTmp][17];
          rowNumberTmp++;
        }
      }
      catch(SQLException exception) {
        exception.printStackTrace();
      }

      //draw buttons   (Shengxin Chen  22/3/2023)
      //previousPage botton
      //modify background and text size of button - Shengxin Chen 06/04/2023
      fill(42, 48, 175);
      this.prevButton = cp5.addButton("Page-")
        .setPosition(500, 710)
        .setSize(100, 40)
        .setColorBackground(color(42, 48, 175))
        ;
      this.prevButton.getCaptionLabel()
        .setFont(createFont("Corbel", 14));
      //next page buttton
      // (Shengxin Chen  22/3/2023)
      this.nextButton = cp5.addButton("Page+")
        .setPosition(600, 710)
        .setSize(100, 40)
        .setColorBackground(color(42, 48, 175))
        ;
      this.nextButton.getCaptionLabel()
        .setFont(createFont("Corbel", 14));

      //reset page button
      this.resetButton = cp5.addButton("Reset Page")
        .setPosition(710, 710)
        .setSize(120, 40)
        .setColorBackground(color(42, 48, 175))
        ;
      this.resetButton.getCaptionLabel()
        .setFont(createFont("Corbel", 14));
    }
    catch(java.util.ConcurrentModificationException e) {
    }
  }

  void spreedsheetMP()
  {
    try {
      //reset page number to 1 - ShengxinChen 30/03/2023
      if (mouseX > 710 && mouseX < 810 && mouseY > 710 && mouseY < 750) {
        if (pageNum > 1 ) {
          pageNum=1;
        }
      }
      //set page number to previous page - ShengxinChen 22/03/2023
      if (mouseX > 500 && mouseX < 600 && mouseY > 710 && mouseY < 750) {
        if (pageNum >=2 ) {
          pageNum--;
        }
      }
      //set page number to next page - ShengxinChen 22/03/2023
      if (mouseX > 600 && mouseX < 700 && mouseY > 710 && mouseY < 750) {
        int pages = totalRows / rowsPerPage;
        if (totalRows % rowsPerPage != 0)
          pages++;
        if (pageNum < pages) {
          pageNum++;
        }
      }
    }
    catch(java.util.ConcurrentModificationException e) {
    }
  }


  void draw() {
    try {
      textFont(createFont("Corbel", 14));
      String[] headers = {"Row\nNumber", "Origin\nAirport", "Destination\nAirport", "Origin\nCity Name",
        "Destination\nCity Name", "Scheduled\narrival time", "Actual\narrival time", "FlightDate", "Distance\nmiles"};
      String[] fullHeaders = {"DATE", "MKT\nCARRIER", "MKT\nCARRIER\nFL_NUM", "ORIGIN", "ORIGIN\nCITY_NAME",
        "ORIGIN\nSTATE_ABR", "ORIGIN\nWAC", "DEST", "DEST\nCITY_NAME", "DEST\nSTATE_ABR", "DEST\nWAC", "CRS\nDEP_TIME",
        "DEP\nTIME", "CRS\nARR_TIME", "ARR\nTIME", "CANCELLED", "DIVERTED", "DISTANCE"};
      int baseRowNum = (pageNum - 1) * rowsPerPage;
      //illustrate page number - Shengxin Chen 22/03/2023
      fill(160, 195, 240);
      rect(710, 750, 120, 40);
      textSize(14);
      fill(0);
      text("Page: "+ pageNum, 770, 770);

      //get total filghts number
      //fix page calculation bug (Shengxin Chen 03/4/2023)
      int totalPages = totalRows / rowsPerPage;
      if (totalRows % rowsPerPage !=0)
      {
        totalPages++;
      }

      //illustrate the number of total pages - Shengxin Chen 22/03/2023
      fill(160, 195, 240);
      rect(600, 750, 100, 40);
      fill(0);
      textSize(14);
      text("Total\nPages: "+totalPages, 650, 765);

      //illustrate the number of left pages
      fill(160, 195, 240);
      rect(500, 750, 100, 40);
      fill(0);
      textSize(14);
      int leftPage = totalPages-pageNum;
      if (totalPages == 0)
        leftPage = 0;
      text("Pages\nLeft: "+ leftPage, 550, 765);

      //illustrate the number of total flights - Shengxin Chen 30/03/2023
      fill(160, 195, 240);
      rect(1220, 750, 170, 40);
      fill(0);
      textSize(16);
      text("Total Flights: "+ totalRows, 1300, 775);

      //illustrate row Number
      fill(160, 195, 240);
      rect(1090, 750, 120, 40);
      textSize(16);
      fill(0);
      text("\nRow: "+ rowNumber, 1150, 750);

      //illustrate row search bar - Shengxin Chen 07/04/2023
      fill(42, 48, 175);
      rect(1090, 710, 120, 40);
      textSize(16);
      fill(255);
      text("Input Row: " + input +"\n(Keyboard)", 1150, 725);
      if (input > 0 && input <= totalRows)
      {
        rowNumber = input;
      } else
      {
        rowNumber = 1;
      }

      //spreadsheet array[i][j]
      //index [i]
      textSize(20);
      for (int i = 0; i <= rows; i++) {
        //index[j]
        for (int j = 0; j <= cols; j++) {
          //draw boxes
          fill(160, 195, 240);
          stroke(0);
          rect(posX+j * boxWidth, i * boxHeight, boxWidth, boxHeight);

          // get row number
          if (j == 0 && i > 0) {
            fill(0);
            text(""+(baseRowNum + i), posX+boxWidth/2, i * boxHeight + boxHeight/2);
          }

          //fill data into each cell by using 1D array
          //using 2D array to fill data into each cell instead of 1D array
          textSize(15);
          if (i>0 && j>0) {
            int rowIndex = baseRowNum + (i - 1);
            if (rowIndex<newAr.length)
            {
              fill(0);
              text(newAr[rowIndex][(j-1)], posX + j * boxWidth + boxWidth/2, i * boxHeight + boxHeight/2);
            }
          }
        }

        //draw header names
        for (int j = 0; j<=headers.length; j++)
        {
          if ((j > 0)&&(i==0)) {
            fill(42, 48, 175);
            rect(posX+(j-1) * boxWidth, i * boxHeight, boxWidth, boxHeight);
            fill(0);
            textSize(16);
            text(headers[j-1], posX+(j-1) * boxWidth + boxWidth/2, boxHeight/2);
          }
        }
      }
      // draw specific flight data in a row - Shengxin Chen 07/04/2023
      for (int n = 0; n < fullDataCols; n++)
      {
        fill(160, 195, 240);
        stroke(0);
        rect(5 + posX+n * addWidth, 805, addWidth, addHeight);
        rect(5 + posX+n * addWidth, 845, addWidth, addHeight/4*3);
      }
      for (int j = 0; j<=fullHeaders.length; j++)
      {
        if (j > 0) {
          fill(42, 48, 175);
          rect(5 + posX+(j-1) * addWidth, 805, addWidth, addHeight);
          fill(0);
          textSize(12);
          text(fullHeaders[j-1], 40 + posX+(j-1) * addWidth, 820);
        }
      }
      for (int j = 0; j<=fullHeaders.length; j++)
      {
        if ((j > 0)&&(fullData.length>0)) {
          fill(0);
          textSize(12);
          text(fullData[rowNumber-1][j-1], 40 + posX+(j-1) * addWidth, 870);
        }
      }
    }
    catch(java.util.ConcurrentModificationException e) {
    }
  }
  void destroy() {
    this.prevButton.remove();
    this.nextButton.remove();
    this.resetButton.remove();
  }
}
