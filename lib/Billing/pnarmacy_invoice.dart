import 'package:flutter/material.dart';
import 'package:flutter_application_1/dashboard/persistent_bottom_nav_bar.dart';
import 'package:intl/intl.dart';

class PharmacyInvoiceScreen extends StatefulWidget {
  @override
  _PharmacyInvoiceScreenState createState() => _PharmacyInvoiceScreenState();
}

class _PharmacyInvoiceScreenState extends State<PharmacyInvoiceScreen> {
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _customerNameController = TextEditingController();

  String _selectedCategory = "";
  String _selectedProduct = "";

  final List<String> _categories = ["Pharmacy", "Cosmetics"];
  final Map<String, List<String>> _products = {
    "Pharmacy": ["Paracetamol", "Ibuprofen", "Antibiotics"],
    "Cosmetics": ["Lipstick", "Foundation", "Eyeliner"]
  };

  List<Map<String, dynamic>> _billingItems = [];

  String _getCurrentDateTime() {
    final now = DateTime.now();
    return DateFormat('yyyy-MM-dd HH:mm').format(now);
  }

  void _addBillingItem(String productName) {
    setState(() {
      _billingItems.add({
        'productName': productName,
        'batchNo': 'B1234', // Placeholder batch number
        'expiryDate': '2025-12-01', // Placeholder expiry date
        'mrp': 50.0, // Placeholder MRP
        'gst': 5.0, // Placeholder GST
        'selling price': 45.0, // Placeholder selling price
        'qty': 1, // Default quantity
        'amount': 45.0, // Initial amount based on selling price
      });
    });
  }

  void _updateAmount(int index, double qty) {
    setState(() {
      final item = _billingItems[index];
      final mrp = item['mrp'] as double;
      _billingItems[index]['qty'] = qty;
      _billingItems[index]['amount'] = qty * mrp;
    });
  }

  void _removeBillingItem(int index) {
    setState(() {
      _billingItems.removeAt(index);
    });
  }

  void _showPreviewBottomSheet() {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title for the preview
              Text(
                'Invoice Preview',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 16), // Space between title and content
              // Customer Details
              Text('Customer Name: ${_customerNameController.text}'),
              SizedBox(height: 5),
              Text('Phone Number: ${_phoneNumberController.text}'),
              SizedBox(height: 5),
              Text('Date and Time: ${_getCurrentDateTime()}'),
              SizedBox(height: 20), // Space between customer details and table

              // Display the billing table with border
              if (_billingItems.isNotEmpty)
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1.0),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: DataTable(
                      border: TableBorder.all(
                        color: Colors.black, // Table cell borders
                        width: 1.0,
                      ),
                      columns: const [
                        DataColumn(
                            label: Text('Product Name',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18))),
                        DataColumn(
                            label: Text('Batch No',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18))),
                        DataColumn(
                            label: Text('Expiry Date',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18))),
                        DataColumn(
                            label: Text('MRP',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18))),
                        DataColumn(
                            label: Text('GST',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18))),
                        DataColumn(
                            label: Text('Selling Price',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize:
                                        18))), // Added selling price column
                        DataColumn(
                            label: Text('Qty',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18))),
                        DataColumn(
                            label: Text('Amount',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18))),
                      ],
                      rows: _billingItems.map((item) {
                        return DataRow(cells: [
                          DataCell(Text(item['productName'])),
                          DataCell(Text(item['batchNo'])),
                          DataCell(Text(item['expiryDate'])),
                          DataCell(Text(item['mrp'] != null
                              ? item['mrp'].toStringAsFixed(2)
                              : '0.00')),
                          DataCell(Text(item['gst'] != null
                              ? item['gst'].toStringAsFixed(2)
                              : '0.00')),
                          DataCell(Text(item['selling price'] != null
                              ? item['selling price'].toStringAsFixed(2)
                              : '0.00')),
                          DataCell(Text(item['qty'].toString())),
                          DataCell(Text(item['amount'].toStringAsFixed(2))),
                        ]);
                      }).toList(),
                    ),
                  ),
                ),
              SizedBox(height: 20), // Space between table and buttons

              // Buttons for Edit and Confirm actions
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(
                          context); // Close bottom sheet and go back to editing
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.red, // Text color
                      padding: EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: 24.0), // Button padding
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(8), // Rounded corners
                      ),
                      textStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold), // Text style
                    ),
                    child: Text('Edit'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Handle confirm action (e.g., save the invoice)
                      Navigator.pop(context);
                      // Clear data after confirmation
                      setState(() {
                        _phoneNumberController.clear();
                        _customerNameController.clear();
                        _categories.clear();
                        _billingItems.clear();
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Invoice Confirmed!')),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor:
                          Color.fromRGBO(2, 116, 131, 1), // Text color
                      padding: EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: 24.0), // Button padding
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(8), // Rounded corners
                      ),
                      textStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold), // Text style
                    ),
                    child: Text('Confirm'),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Navigate back to the PersistentBottomNavBar with the Home tab selected
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => PersistentBottomNavBar(),
        ));
        return false; // Prevent the default back button behavior
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Pharmacy Invoice',
            style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
                color: Colors.black),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Date and Time with Icon
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Icon(Icons.calendar_today, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      _getCurrentDateTime(),
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // Phone Number Field
                Text('Phone Number',
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                const SizedBox(height: 5),
                TextField(
                  controller: _phoneNumberController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    hintText: 'Phone Number',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: const BorderSide(
                          color: Color.fromRGBO(2, 116, 131, 1),
                          width: 2.0), // Focused border color
                    ),
                  ),
                  cursorColor: Color.fromRGBO(2, 116, 131, 1),
                ),
                const SizedBox(height: 16),

                // Customer Name Field
                Text('Customer Name',
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                const SizedBox(height: 5),
                TextField(
                  controller: _customerNameController,
                  decoration: InputDecoration(
                    hintText: 'Customer Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: const BorderSide(
                          color: Color.fromRGBO(2, 116, 131, 1),
                          width: 2.0), // Focused border color
                    ),
                  ),
                  cursorColor: Color.fromRGBO(2, 116, 131, 1),
                ),
                const SizedBox(height: 16),

                // Dropdown List for Category
                Text(
                  'Select Category',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                DropdownButtonFormField<String>(
                  value: _selectedCategory.isEmpty ? null : _selectedCategory,
                  hint: const Text('Select Category'),
                  items: _categories.map((String category) {
                    return DropdownMenuItem<String>(
                        value: category, child: Text(category));
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedCategory = newValue ?? "";
                      _selectedProduct =
                          ""; // Reset product when category changes
                    });
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: const BorderSide(
                          color: Color.fromRGBO(2, 116, 131, 1),
                          width: 2.0), // Focused border color
                    ),
                  ),
                  dropdownColor: Colors.white,
                ),
                const SizedBox(height: 16),

                // Dropdown for Products
                if (_selectedCategory.isNotEmpty) ...[
                  Text(
                    'Select Product',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  DropdownButtonFormField<String>(
                    value: _selectedProduct.isEmpty ? null : _selectedProduct,
                    hint: const Text('Select Product'),
                    items: _products[_selectedCategory]?.map((String product) {
                      return DropdownMenuItem<String>(
                          value: product, child: Text(product));
                    }).toList(),
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        setState(() {
                          _selectedProduct = newValue;
                          _addBillingItem(newValue);
                        });
                      }
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: const BorderSide(
                            color: Color.fromRGBO(2, 116, 131, 1),
                            width: 2.0), // Focused border color
                      ),
                    ),
                    dropdownColor: Colors.white,
                  ),
                ],

                const SizedBox(height: 20),

                // Billing Table
                if (_billingItems.isNotEmpty)
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: DataTable(
                        columns: const [
                          DataColumn(label: Text('Product Name')),
                          DataColumn(label: Text('Batch No')),
                          DataColumn(label: Text('Expiry Date')),
                          DataColumn(label: Text('MRP')),
                          DataColumn(label: Text('GST')),
                          DataColumn(label: Text('Qty')),
                          DataColumn(label: Text('Amount')),
                          DataColumn(label: Text('Action')),
                        ],
                        rows: _billingItems.asMap().entries.map((entry) {
                          final index = entry.key;
                          final item = entry.value;
                          return DataRow(cells: [
                            DataCell(Text(item['productName'])),
                            DataCell(Text(item['batchNo'])),
                            DataCell(Text(item['expiryDate'])),
                            DataCell(Text(item['mrp'] != null
                                ? item['mrp'].toStringAsFixed(2)
                                : '0.00')),
                            DataCell(Text(item['gst'] != null
                                ? item['gst'].toStringAsFixed(2)
                                : '0.00')),
                            DataCell(TextFormField(
                              initialValue: item['qty'].toString(),
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                _updateAmount(
                                    index, double.tryParse(value) ?? 0);
                              },
                              cursorColor: Color.fromRGBO(2, 116, 131, 1),
                            )),
                            DataCell(Text(item['amount'].toStringAsFixed(2))),
                            DataCell(
                              IconButton(
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  // Show a confirmation dialog before deleting
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        backgroundColor: Colors.white,
                                        title: Text('Delete Item'),
                                        content: Text(
                                            'Are you sure you want to delete this item?'),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context)
                                                  .pop(); // Close the dialog
                                            },
                                            child: Text('Cancel',style: TextStyle(color: Colors.grey),),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              // Proceed with the deletion
                                              _removeBillingItem(index);
                                              Navigator.of(context)
                                                  .pop(); // Close the dialog
                                            },
                                            child: Text('Delete',
                                                style: TextStyle(
                                                    color: Colors.red)),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                          ]);
                        }).toList(),
                      ),
                    ),
                  ),

                // Preview Button (bottom right corner)
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: ElevatedButton(
                      onPressed:
                          _showPreviewBottomSheet, // Show the bottom sheet
                      child: Text(
                        'Preview',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(2, 116, 131, 1),
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
