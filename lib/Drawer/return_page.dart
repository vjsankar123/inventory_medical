import 'package:flutter/material.dart';
import 'package:flutter_application_1/dashboard/persistent_bottom_nav_bar.dart';

void main() {
  runApp(MaterialApp(
    home: ReturnPage(),
  ));
}

class ReturnPage extends StatefulWidget {
  @override
  _ReturnPageState createState() => _ReturnPageState();
}

class _ReturnPageState extends State<ReturnPage> {
  // Data for the return table
  final List<Map<String, dynamic>> returnData = [
    {
      "invoiceId": "PH123",
      "productName": "Paracetamol 500mg",
      "quantity": 2,
      "reason": "Expired medicine"
    },
    {
      "invoiceId": "PH124",
      "productName": "Ibuprofen 200mg",
      "quantity": 1,
      "reason": "Wrong prescription"
    },
  ];

  // Controllers for adding new return data
  final TextEditingController invoiceIdController = TextEditingController();
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController reasonController = TextEditingController();

  // Function to add a new return entry
  void addNewReturn() {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      isScrollControlled: true, // Ensures bottom sheet can scroll
      builder: (BuildContext context) {
        return SingleChildScrollView(
          // Scrollable content
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.max, // Allows bottom sheet to shrink
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Add New Return',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                // Invoice ID TextField
                TextField(
                  controller: invoiceIdController,
                  decoration: InputDecoration(
                    labelStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(
                        color: Colors.black, // Default border color
                        width: 1.0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(
                        color: Color(0xFF028090), // Focused border color
                        width: 2.0,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(
                        color: Color(0xFF028090), // Enabled border color
                        width: 1.0,
                      ),
                    ),
                    labelText: 'Invoice No',
                  ),
                  cursorColor: Color(0xFF028090),
                ),
                SizedBox(height: 10),

// Quantity TextField
                TextField(
                  controller: quantityController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(
                        color: Colors.black, // Default border color
                        width: 1.0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(
                        color: Color(0xFF028090), // Focused border color
                        width: 2.0,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(
                        color: Color(0xFF028090), // Enabled border color
                        width: 1.0,
                      ),
                    ),
                    labelText: 'Quantity',
                  ),
                  cursorColor: Color(0xFF028090),
                ),
                SizedBox(height: 10),

// Reason TextFormField
                TextField(
                  controller: reasonController,
                  maxLines: 5,
                  decoration: InputDecoration(
                    labelStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(
                        color: Colors.black, // Default border color
                        width: 1.0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(
                        color: Color(0xFF028090), // Focused border color
                        width: 2.0,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(
                        color: Color(0xFF028090), // Enabled border color
                        width: 1.0,
                      ),
                    ),
                    labelText: 'Reason for return',
                  ),
                  cursorColor: Color(0xFF028090),
                ),
                SizedBox(height: 10),

                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context); // Close the bottom sheet
                      },
                      child: Text('Cancel'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                    ),
                    SizedBox(width: 16),
                    ElevatedButton(
                      onPressed: () {
                        if (invoiceIdController.text.isNotEmpty &&
                            quantityController.text.isNotEmpty &&
                            reasonController.text.isNotEmpty) {
                          setState(() {
                            returnData.add({
                              "invoiceId": invoiceIdController.text,
                              "productName": productNameController.text,
                              "quantity": int.parse(quantityController.text),
                              "reason": reasonController.text,
                            });
                          });
                          // Clear the text fields after adding
                          invoiceIdController.clear();
                          productNameController.clear();
                          quantityController.clear();
                          reasonController.clear();
                          Navigator.pop(context); // Close the bottom sheet
                        }
                      },
                      child: Text('Add Return'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF028090),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
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
            title: Text('Return Page',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
            backgroundColor: Color(0xFF028090),
            centerTitle: true,
          ),
          backgroundColor: Colors.white,
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Button at the top-left
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: addNewReturn,
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF028090),
                          padding:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                          elevation: 10),
                      child: Text('Add New Return',
                          style: TextStyle(fontSize: 16,color: Colors.white)),
                    ),
                  ],
                ),
                SizedBox(height: 16), // Space between the button and table

                // Scrollable Table inside a bordered box
                Container(
                  padding: EdgeInsets.all(8),
                  // decoration: BoxDecoration(
                  //   border: Border.all(
                  //       color: Colors.black), // Outer border for the table
                  //   borderRadius: BorderRadius.circular(8),
                  // ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Table(
                      border: TableBorder.all(
                          color: Colors.black,
                          width: 2,
                          borderRadius:
                              BorderRadius.circular(8)), // Border for all cells

                      columnWidths: {
                        0: FixedColumnWidth(
                            100), // Adjust column widths as needed
                        1: FixedColumnWidth(150),
                        2: FixedColumnWidth(100),
                        3: FixedColumnWidth(200),
                      },
                      children: [
                        // Header row
                        TableRow(
                          // decoration: BoxDecoration(color: Color(0xFF028090)),
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                'Invoice ID',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                'Product Name',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                'Quantity',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                'Reason for Return',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                        // Data rows
                        ...returnData.map(
                          (returnItem) => TableRow(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(returnItem['invoiceId']),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(returnItem['productName']),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(returnItem['quantity'].toString()),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(returnItem['reason']),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
