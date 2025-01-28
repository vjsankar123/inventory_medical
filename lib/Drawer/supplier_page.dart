import 'package:flutter/material.dart';
import 'package:flutter_application_1/dashboard/persistent_bottom_nav_bar.dart';
import 'supplier_form.dart';

class SupplierPage extends StatefulWidget {
  @override
  _SupplierPageState createState() => _SupplierPageState();
}

class _SupplierPageState extends State<SupplierPage> {
  final List<Map<String, String>> data = [
    {
      "Name": "ABC Supplies",
      "Phone No": "9876543210",
      "Email": "abc@supplies.com",
      "Address": "1234, Street Name, City",
      "GST No": "27ABCDE1234F1Z5",
      "Status": "Active"
    },
    {
      "Name": "XYZ Traders",
      "Phone No": "9123456789",
      "Email": "xyz@traders.com",
      "Address": "5678, Road Avenue, Town",
      "GST No": "29XYZABCD5671K1",
      "Status": "Inactive"
    },
  ];

  List<Map<String, String>> filteredData = [];
  bool isSearching = false;

  @override
  void initState() {
    super.initState();
    filteredData = data;
  }

  void searchSuppliers(String query) {
    final results = data.where((item) {
      final name = item['Name']?.toLowerCase() ?? '';
      final phone = item['Phone No']?.toLowerCase() ?? '';
      final email = item['Email']?.toLowerCase() ?? '';
      final input = query.toLowerCase();
      return name.contains(input) ||
          phone.contains(input) ||
          email.contains(input);
    }).toList();

    setState(() {
      filteredData = results;
    });
  }

  void addNewSupplier() {
    showModalBottomSheet(
          backgroundColor: Colors.white,
      context: context,
      builder: (context) {
        return SupplierForm(
          onAddSupplier: (newSupplier) {
            setState(() {
              data.add(newSupplier);
              filteredData = data;
            });
          },
        );
      },
    );
  }

  void editSupplier(Map<String, String> supplier) {
    showModalBottomSheet(
          backgroundColor: Colors.white,
      context: context,
      builder: (context) {
        return SupplierForm(
          initialSupplier: supplier,
          onAddSupplier: (editedSupplier) {
            setState(() {
              int index = data.indexOf(supplier);
              if (index != -1) {
                data[index] = editedSupplier;
                filteredData = data;
              }
            });
          },
        );
      },
    );
  }

  void deleteSupplier(Map<String, String> supplier) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Text('Confirm Deletion'),
          content: const Text('Are you sure you want to delete this supplier?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog without deleting
              },
              child: const Text('Cancel',
                  style: TextStyle(color: Colors.grey)),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  data.remove(supplier); // Remove supplier from the list
                  filteredData = data; // Update the filtered list
                });
                Navigator.pop(context); // Close the dialog after deletion
              },
              child: const Text(
                'Delete',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  void viewSupplierDetails(Map<String, String> supplier) {
    
    showDialog(
      
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text(
            supplier['Name'] ?? 'Supplier Details',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xFF028090), // Match the theme color
            ),
          ),
          content: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDetailText('Phone: ${supplier['Phone No']}'),
                _buildDetailText('Email: ${supplier['Email']}'),
                _buildDetailText('Address: ${supplier['Address']}'),
                _buildDetailText('GST No: ${supplier['GST No']}'),
                _buildDetailText('Status: ${supplier['Status']}'),
              ],
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF028090),
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text(
                  'Close',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildDetailText(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16,
          color: Colors.black87,
          fontWeight: FontWeight.w500,
        ),
      ),
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
          title: const Text(
            'Supplier List',
            style: TextStyle(
                color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Color(0xFF028090),
          centerTitle: true,
        ),
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search suppliers...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide(
                    color: Color(0xFF028090),
                    width: 2.0,
                  ),
                ),
                ),
                cursorColor: Color(0xFF028090),
                onChanged: searchSuppliers,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: filteredData.length,
                itemBuilder: (context, index) {
                  final item = filteredData[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: const BorderSide(
                        color: Colors.black,
                        width: 2,
                      ),
                    ),
                    margin: const EdgeInsets.all(10),
                    // elevation: 5,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border(
                          top: BorderSide(color: Colors.black, width: 2.0),
                          left: BorderSide(color: Colors.black, width: 2.0),
                          right: BorderSide(color: Colors.black, width: 2.0),
                          bottom: BorderSide(color: Colors.black, width: 5.0),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 6.0,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Icon(Icons.store,
                                        size: 24, color: Color(0xFF028090)),
                                    const SizedBox(width: 10),
                                    Text(
                                      item['Name'] ?? '',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    const Icon(Icons.phone,
                                        size: 20, color: Color(0xFF028090)),
                                    const SizedBox(width: 10),
                                    Text(" ${item['Phone No']}"),
                                  ],
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  children: [
                                    const Icon(Icons.email,
                                        size: 20, color: Color(0xFF028090)),
                                    const SizedBox(width: 10),
                                    Text(" ${item['Email']}"),
                                  ],
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  children: [
                                    const Icon(Icons.location_on,
                                        size: 20, color: Color(0xFF028090)),
                                    const SizedBox(width: 10),
                                    Text(" ${item['Address']}"),
                                  ],
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  children: [
                                    const Icon(Icons.receipt,
                                        size: 20, color: Color(0xFF028090)),
                                    const SizedBox(width: 10),
                                    Text(" ${item['GST No']}"),
                                  ],
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  "Status: ${item['Status']}",
                                  style: TextStyle(
                                    color: item['Status'] == "Active"
                                        ? Colors.green
                                        : Colors.red,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          PopupMenuButton<String>(
                            icon: const Icon(Icons.more_vert),
                            onSelected: (value) {
                              if (value == 'Edit') {
                                editSupplier(item);
                              } else if (value == 'See All') {
                                viewSupplierDetails(item);
                              } else if (value == 'Delete') {
                                deleteSupplier(item);
                              }
                            },
                            itemBuilder: (context) => [
                                 PopupMenuItem(
                                value: 'See All',
                                child: ListTile(
                                  leading: const Icon(Icons.visibility,
                                      color: Color(0xFF028090)),
                                  title: const Text('See All'),
                                ),
                              ),
                              PopupMenuItem(
                                value: 'Edit',
                                child: ListTile(
                                  leading: const Icon(Icons.edit_square,
                                      color: Colors.orange),
                                  title: const Text('Edit'),
                                ),
                              ),
                           
                              PopupMenuItem(
                                value: 'Delete',
                                child: ListTile(
                                  leading: const Icon(Icons.auto_delete,
                                      color: Colors.red),
                                  title: const Text('Delete'),
                                ),
                              ),
                            ],
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: addNewSupplier,
          child: const Icon(Icons.add, color: Colors.white, size: 30),
          elevation: 30.0,
          backgroundColor: Color(0xFF028090),
          tooltip: 'Add Supplier',
        ),
      ),
    );
  }
}
