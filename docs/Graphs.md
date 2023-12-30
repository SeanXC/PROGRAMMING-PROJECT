As it stands there are **four** available graphs:

# Bar Chart
This allows you to create bar chart of the **number of occurences** of each entry in a specified query. For example, with the query `ORIGIN`, the chart will display how many flights departed from each airport.

To use a bar chart, you must make a new instance of type **Bar** and pass it two parameters:
- A String containing your **query**. This must be a valid heading from the SQL table, e.g. `DISTANCE` or `DEST_CITY`.
- An integer containing a value from 0-3 to **filter** the data. A value of 0 will apply no filtering, 1 will only show cancelled flights, 2 only diverted, 3 only on time, 4 only late.

Before you can draw the bar chart, you must first set up the page by calling the **makePage(int page)** method, which takes a page number (starting from 1) as a parameter. To check how many pages there are, you can check the value of the integer **pageCount**.
Finally, there is a **draw()** method of each instance of Bar that you must call for the chart to actually appear on screen.

# Scatter plot
This allows you to create a scatter plot of the **number of occurences** of each entry in a specified query that pertains to **numerical** data, **binned into a specified size**.

As both axes are numerical, there is no need for a range.

To use a Scatterplot, you must make a new instance of type **Scatter** and pass it three parameters:
- A String containing your **query**. This must be a valid heading from the SQL table **containing numerical data**, e.g. `ARR_TIME` or `DISTANCE`.
- An integer containing the size of each **group**, or bin. For example, a value of 100 will bin the data into groups of 100. If you do not want binning, set this to 1.
- An integer containing a value from 0-3 to **filter** the data. A value of 0 will apply no filtering, 1 will only show cancelled flights, 2 only diverted, 3 only on time, 4 only late.

Finally, there is a **draw()** method of each instance of Scatter that you must call for the chart to actually appear on screen.

# Pie chart
Creates a pie chart of the **number of occurences** of each entry in a specified query.

To use a pie chart, you must make a new instance of type **Pie** and pass it two parameters:
- A String containing your **query**. This must be a valid heading from the SQL table, e.g. `DISTANCE` or `DEST_CITY`.
- An integer containing a value from 0-3 to **filter** the data. A value of 0 will apply no filtering, 1 will only show cancelled flights, 2 only diverted, 3 only on time, 4 only late.

Before you can draw the pie chart, you must first set up the page by calling the **makePage(int page)** method, which takes a page number (starting from 1) as a parameter. To check how many pages there are, you can check the value of the integer **pageCount**.
Finally, there is a **draw()** method of each instance of Pie that you must call for the chart to actually appear on screen.

# Heat map
This will display a heatmap of states with the most flights. It takes a single parameter:
- An integer containing a value from 0-3 to **filter** the data. A value of 0 will apply no filtering, 1 will only show cancelled flights, 2 only diverted, 3 only on time, 4 only late.

There is a **draw()** method of each instance of Heat that you must call for the chart to actually appear on screen.
