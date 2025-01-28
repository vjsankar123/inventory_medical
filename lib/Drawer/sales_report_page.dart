import 'package:flutter/material.dart';
import 'package:flutter_application_1/dashboard/persistent_bottom_nav_bar.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(SalesReportPage());
}

class SalesReportPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SalesReportScreen(),
    );
  }
}

class SalesReportScreen extends StatefulWidget {
  @override
  _SalesReportScreenState createState() => _SalesReportScreenState();
}

class _SalesReportScreenState extends State<SalesReportScreen> {
  String dropdownValue = "Last 30 Days";
  DateTime startDate = DateTime(2025, 1, 30);
  DateTime endDate = DateTime(2025, 2, 1);

  final Map<String, List<Map<String, dynamic>>> progressData = {
    "Last 7 Days": [
      {"name": "Paracetamol", "units": 70, "color": Colors.blue, "value": 0.7},
      {"name": "Amoxicillin", "units": 40, "color": Colors.green, "value": 0.4},
      {"name": "Cough Syrup", "units": 20, "color": Colors.yellow, "value": 0.2},
    ],
    "Last 15 Days": [
      {"name": "Paracetamol", "units": 100, "color": Colors.blue, "value": 0.8},
      {"name": "Amoxicillin", "units": 60, "color": Colors.green, "value": 0.6},
      {"name": "Cough Syrup", "units": 40, "color": Colors.yellow, "value": 0.4},
    ],
    "Last 30 Days": [
      {"name": "Paracetamol", "units": 150, "color": Colors.blue, "value": 1.0},
      {"name": "Amoxicillin", "units": 90, "color": Colors.green, "value": 0.6},
      {"name": "Cough Syrup", "units": 60, "color": Colors.yellow, "value": 0.4},
    ],
  };

  Future<void> _selectSingleDate(BuildContext context, bool isStartDate) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isStartDate ? startDate : endDate,
      firstDate: DateTime(2024, 1, 1),
      lastDate: DateTime(2026, 12, 31),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: Color(0xFF028090), // Calendar selection color
              onPrimary: Colors.white,   // Text color on selected date
              onSurface: Colors.black,   // Default text color
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        if (isStartDate) {
          startDate = picked;
        } else {
          endDate = picked;
        }
      });
    }
  }

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
            'Sales Report',
            style: TextStyle(
                color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: Color(0xFF028090),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => PersistentBottomNavBar(),
              ));
            },
          ),
        ),
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Dropdown with aligned label
              Row(
                children: [
                  Expanded(
                    child: Text("Most Sold Medicines",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                  DropdownButton<String>(
                    value: dropdownValue,
                    items: <String>["Last 7 Days", "Last 15 Days", "Last 30 Days"]
                        .map((String value) => DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            ))
                        .toList(),
                    onChanged: (newValue) {
                      setState(() {
                        dropdownValue = newValue!;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 10),

              // Dynamic Progress Bars
              for (var data in progressData[dropdownValue]!)
                _buildProgressBar(
                    data["name"], data["units"], data["color"], data["value"]),

              SizedBox(height: 20),

              // Date range picker with aligned label
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Sales Details",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          readOnly: true,
                          decoration: InputDecoration(
                            labelText: "From Date",
                            labelStyle: const TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold),
                           border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(
                    color: Color(0xFF028090),
                    width: 2.0,
                  ),
                ),
                            suffixIcon: Icon(Icons.calendar_today),
                          ),
                          controller: TextEditingController(
                            text: DateFormat('yyyy-MM-dd').format(startDate),
                          ),
                          onTap: () {
                            _selectSingleDate(context, true);
                          },
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          readOnly: true,
                          decoration: InputDecoration(
                            labelText: "To Date",
                             labelStyle: const TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold),
                            border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(
                    color: Color(0xFF028090),
                    width: 2.0,
                  ),
                ),
                            suffixIcon: Icon(Icons.calendar_today),
                          ),
                          controller: TextEditingController(
                            text: DateFormat('yyyy-MM-dd').format(endDate),
                          ),
                          onTap: () {
                            _selectSingleDate(context, false);
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              SizedBox(height: 20),

              // Sales Details Table
              _buildSalesTable(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProgressBar(String name, int units, Color color, double value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("$name ($units units)", style: TextStyle(fontSize: 16)),
        SizedBox(height: 5),
        LinearProgressIndicator(
          value: value,
          backgroundColor: Colors.grey[300],
          color: color,
          minHeight: 10,
        ),
        SizedBox(height: 10),
      ],
    );
  }

  Widget _buildSalesTable() {
    return Table(
      border: TableBorder.all(color: Colors.grey),
      columnWidths: {
        0: FlexColumnWidth(3),
        1: FlexColumnWidth(3),
        2: FlexColumnWidth(3),
        3: FlexColumnWidth(3),
      },
      children: [
        _buildTableRow("Medicine Name", "Sale Amount", "Category", "Sale Qty",
            isHeader: true),
        _buildTableRow("Paracetamol", "\$500", "Painkiller", "50"),
        _buildTableRow("Amoxicillin", "\$300", "Antibiotic", "30"),
        _buildTableRow("Cough Syrup", "\$200", "Syrup", "20"),
      ],
    );
  }

  TableRow _buildTableRow(String col1, String col2, String col3, String col4,
      {bool isHeader = false}) {
    return TableRow(
      children: [
        _buildTableCell(col1, isHeader),
        _buildTableCell(col2, isHeader),
        _buildTableCell(col3, isHeader),
        _buildTableCell(col4, isHeader),
      ],
    );
  }

  Widget _buildTableCell(String text, bool isHeader) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        text,
        style: TextStyle(
            fontWeight: isHeader ? FontWeight.bold : FontWeight.normal),
        textAlign: TextAlign.center,
      ),
    );
  }
}
