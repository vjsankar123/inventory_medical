import 'package:flutter/material.dart';
import 'package:flutter_application_1/Drawer/income_cards.dart';
import 'package:flutter_application_1/dashboard/persistent_bottom_nav_bar.dart';
import 'package:syncfusion_flutter_charts/charts.dart'; // Import Syncfusion charts package

class IncomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => PersistentBottomNavBar(),
        ));
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Income Page',
            style: TextStyle(
                color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
          ), // Title of the AppBar
          centerTitle: true, // Center align the title
          backgroundColor: Color(0xFF028090), // AppBar background color
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ), // Back arrow icon
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => PersistentBottomNavBar(),
              ));
            },
          ),
          // actions: [
          //   IconButton(
          //     icon: Icon(Icons.search), // Add a search icon
          //     onPressed: () {
          //       // Action for the search button
          //     },
          //   ),
          // ],
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: buildStatusCards(context),
        ),
      ),
    );
  }
}

Widget buildStatusCards(BuildContext context) {
  return SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.only(top: 0.0), // Add padding at the top
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Remove the incorrect nested children array
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Income Overview',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  children: [
                    IncomeCards(
                      title: "Today",
                      data: "5,000",
                      color: Color(0xFF00bbf9),
                      icon: Icons.calendar_today,
                    ),
                    IncomeCards(
                      title: "This Month",
                      data: "10,000",
                      color: Color(0xFFf15bb5),
                      icon: Icons.pie_chart,
                    ),
                  ],
                ),
              ),
              SizedBox(width: 2),
              Expanded(
                child: Column(
                  children: [
                    IncomeCards(
                      title: "This Week",
                      data: "15,000",
                      color: Color(0xFFff9505),
                      icon: Icons.view_week,
                    ),
                    IncomeCards(
                      title: "This Year",
                      data: "10,0000",
                      color: Color(0xFF9b5de5),
                      icon: Icons.moving,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Income List',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 10),
          buildIncomeTable(),
        ],
      ),
    ),
  );
}

Widget buildIncomeTable() {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      decoration: BoxDecoration(
        // color: Color(0xFF028090), // Background color for the table container
        border: Border.all(color: Colors.grey, width: 1), // Outer border
        borderRadius: BorderRadius.circular(12), // Rounded corners
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal, // Horizontal scrolling
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical, // Vertical scrolling
          child: DataTable(
            border: TableBorder.all(
              color: Colors.black, // Table cell borders
              width: 1.0,
            ),
            columns: const [
              DataColumn(
                label: Text(
                  'Invoice ID',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black, // Header text color
                  ),
                ),
              ),
              DataColumn(
                label: Text(
                  'Category',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ),
              DataColumn(
                label: Text(
                  'Date',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ),
              DataColumn(
                label: Text(
                  'Amount',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ),
              DataColumn(
                label: Text(
                  'Detail',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
            rows: const [
              DataRow(cells: [
                DataCell(Text(
                  'INV001',
                  style: TextStyle(fontSize: 14, color: Colors.black),
                )),
                DataCell(Text(
                  'Sales',
                  style: TextStyle(fontSize: 14, color: Colors.black),
                )),
                DataCell(Text(
                  '2024-12-27',
                  style: TextStyle(fontSize: 14, color: Colors.black),
                )),
                DataCell(Text(
                  '₹2,500',
                  style: TextStyle(fontSize: 14, color: Colors.black),
                )),
                DataCell(Text(
                  'Medicine Sales',
                  style: TextStyle(fontSize: 14, color: Colors.black),
                )),
              ]),
              DataRow(cells: [
                DataCell(Text(
                  'INV002',
                  style: TextStyle(fontSize: 14, color: Colors.black),
                )),
                DataCell(Text(
                  'Rent',
                  style: TextStyle(fontSize: 14, color: Colors.black),
                )),
                DataCell(Text(
                  '2024-12-26',
                  style: TextStyle(fontSize: 14, color: Colors.black),
                )),
                DataCell(Text(
                  '₹1,500',
                  style: TextStyle(fontSize: 14, color: Colors.black),
                )),
                DataCell(Text(
                  'Shop Rent Income',
                  style: TextStyle(fontSize: 14, color: Colors.black),
                )),
              ]),
              DataRow(cells: [
                DataCell(Text(
                  'INV003',
                  style: TextStyle(fontSize: 14, color: Colors.black),
                )),
                DataCell(Text(
                  'Sales',
                  style: TextStyle(fontSize: 14, color: Colors.black),
                )),
                DataCell(Text(
                  '2024-12-25',
                  style: TextStyle(fontSize: 14, color: Colors.black),
                )),
                DataCell(Text(
                  '₹3,000',
                  style: TextStyle(fontSize: 14, color: Colors.black),
                )),
                DataCell(Text(
                  'Over-the-Counter Sales',
                  style: TextStyle(fontSize: 14, color: Colors.black),
                )),
              ]),
            ],
          ),
        ),
      ),
    ),
  );
}
