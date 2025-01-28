import 'package:flutter/material.dart';
import 'package:flutter_application_1/dashboard/persistent_bottom_nav_bar.dart'; // Ensure you have this file available
import 'package:intl/intl.dart';

void main() {
  runApp(const ExpenseTrackerApp());
}

class ExpenseTrackerApp extends StatelessWidget {
  const ExpenseTrackerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ExpenseTrackerScreen(),
    );
  }
}

class ExpenseTrackerScreen extends StatefulWidget {
  const ExpenseTrackerScreen({Key? key}) : super(key: key);

  @override
  _ExpenseTrackerScreenState createState() => _ExpenseTrackerScreenState();
}

class _ExpenseTrackerScreenState extends State<ExpenseTrackerScreen> {
  final List<Map<String, dynamic>> expenses = [
    {
      'S.No': 1,
      'Category': 'Food',
      'Amount': 20,
      'Date': '2024-12-25',
      'Description': 'Lunch'
    },
    {
      'S.No': 2,
      'Category': 'Travel',
      'Amount': 50,
      'Date': '2024-12-26',
      'Description': 'Taxi fare'
    },
    {
      'S.No': 3,
      'Category': 'dfghj',
      'Amount': 123,
      'Date': '2025-01-24',
      'Description': 'sdfghxertyu'
    },
  ];

  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Color(0xFF028090), // Set calendar header color
            hintColor: Color(0xFF028090), // Set calendar selected date color
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
            scaffoldBackgroundColor:
                Colors.blue[50], // Set calendar background color
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _dateController.text = DateFormat('MM/dd/yyyy').format(picked);
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
            'Expense Tracker',
            style: TextStyle(
                color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: Color(0xFF028090),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) =>
                    PersistentBottomNavBar(), // Ensure this is defined
              ));
            },
          ),
        ),
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Expense',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              // Container for the table
              Container(
                decoration: BoxDecoration(
                  // color: Color(0xFF028090), // Background color for the table container
                  border:
                      Border.all(color: Colors.grey, width: 1), // Outer border
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
                            'S.No',
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
                            'Description',
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
                            '1',
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          )),
                          DataCell(Text(
                            'Food',
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          )),
                          DataCell(Text(
                            '20',
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          )),
                          DataCell(Text(
                            '₹2024-12-27',
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          )),
                          DataCell(Text(
                            'Lunch',
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          )),
                        ]),
                        DataRow(cells: [
                          DataCell(Text(
                            '2',
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          )),
                          DataCell(Text(
                            'Travel',
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          )),
                          DataCell(Text(
                            '50',
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          )),
                          DataCell(Text(
                            '2024-12-26',
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          )),
                          DataCell(Text(
                            'Taxi Fare',
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          )),
                        ]),
                        DataRow(cells: [
                          DataCell(Text(
                            '3',
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          )),
                          DataCell(Text(
                            'Sales',
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          )),
                          DataCell(Text(
                            '140',
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          )),
                          DataCell(Text(
                            '2024-12-25',
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
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Show the bottom sheet when the button is pressed
            showModalBottomSheet(
              backgroundColor: Colors.white,
              context: context,
              isScrollControlled: true, // Allow scrolling in bottom sheet
              builder: (context) {
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Add New Expense',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        SizedBox(height: 16),
                        TextField(
                          controller: _categoryController,
                          decoration: InputDecoration(
                            labelText: 'Category',
                            labelStyle: const TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
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
                          ),
                          cursorColor: Color(0xFF028090),
                        ),
                        SizedBox(height: 16),
                        TextField(
                          controller: _amountController,
                          decoration: InputDecoration(
                            labelText: 'Amount',
                            labelStyle: const TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
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
                          ),
                          cursorColor: Color(0xFF028090),
                          keyboardType: TextInputType.number,
                        ),
                        SizedBox(height: 16),
                        TextFormField(
                          readOnly: true,
                          controller:
                              _dateController, // Use the _dateController here
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: Icon(Icons.calendar_today),
                              onPressed: () async {
                                DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime(2100),
                                  builder: (context, child) {
                                    return Theme(
                                      data: Theme.of(context).copyWith(
                                        colorScheme: ColorScheme.light(
                                          primary: Color(0xFF028090),
                                          onPrimary: Colors.white,
                                          onSurface: Colors.black,
                                        ),
                                      ),
                                      child: child!,
                                    );
                                  },
                                );

                                if (pickedDate != null) {
                                  _dateController.text =
                                      DateFormat('MM/dd/yyyy').format(
                                          pickedDate); // Format the date here
                                }
                              },
                            ),
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
                            hintText: 'DD-MM-YYYY',
                          ),
                        ),
                        SizedBox(height: 16),
                        TextField(
                          controller: _descriptionController,
                          maxLines: 5,
                          decoration: InputDecoration(
                            labelText: 'Description',
                            labelStyle: const TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
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
                          ),
                          cursorColor: Color(0xFF028090),
                        ),
                        SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            // Collect data and add it to the expenses list
                            final newExpense = {
                              'S.No': expenses.length + 1,
                              'Category': _categoryController.text,
                              'Amount':
                                  double.tryParse(_amountController.text) ??
                                      0.0,
                              'Date': _dateController.text,
                              'Description': _descriptionController.text,
                            };

                            // Update the expenses list
                            setState(() {
                              expenses.add(newExpense); // Update the table
                            });

                            // Clear the text controllers after adding the expense
                            _categoryController.clear();
                            _amountController.clear();
                            _dateController.clear();
                            _descriptionController.clear();

                            // Close the bottom sheet
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF028090),
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                          ),
                          child: Text(
                            'Add Expense',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
          child: Icon(Icons.add, color: Colors.white, size: 30),
          elevation: 30.0,
          backgroundColor: Color(0xFF028090),
          tooltip: 'Add Expense',
        ),
      ),
    );
  }
}
