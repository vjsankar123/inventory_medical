import 'package:flutter/material.dart';
import 'package:flutter_application_1/dashboard/persistent_bottom_nav_bar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Deleted Products Table',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BinPage(),
    );
  }
}

class BinPage extends StatefulWidget {
  @override
  _BinPageState createState() => _BinPageState();
}

class _BinPageState extends State<BinPage> {
  // Sample list of deleted products
  List<Map<String, String>> deletedProducts = [
    {
      'productId': '1',
      'medicineName': 'Cough Syrup',
      'supplierName': 'DEF Pharma',
      'categoryName': 'Cold & Flu',
      'brandName': 'ZYX',
      'createdDate': '2023-11-15',
      'deleteDate': '2023-11-20',
    },
    {
      'productId': '2',
      'medicineName': 'Pain Reliever',
      'supplierName': 'ABC Pharma',
      'categoryName': 'Pain Relief',
      'brandName': 'XYZ',
      'createdDate': '2023-10-10',
      'deleteDate': '2023-10-15',
    },
    // Add more sample data here...
  ];

  // Function to handle restore action
  void restoreProduct(int index) {
    setState(() {
      // Logic to restore the product (you can handle actual restoration here)
      deletedProducts.removeAt(index);
    });
  }

  // Function to handle delete action (permanent deletion)
void deleteProduct(int index) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        title: Text('Confirm Deletion'),
        content: Text('Are you sure you want to permanently delete this product?'),
        actions: <Widget>[
          TextButton(
            child: Text('Cancel',style: TextStyle(color: Colors.grey),),
            onPressed: () {
              Navigator.of(context).pop();  // Close the dialog
            },
          ),
          TextButton(
            child: Text('Delete',style: TextStyle(color: Colors.red)),
            onPressed: () {
              setState(() {
                // Logic to permanently delete the product (handle as needed)
                deletedProducts.removeAt(index);
              });
              Navigator.of(context).pop();  // Close the dialog
            },
          ),
        ],
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
          title: Text(
            'Deleted Products',
            style: TextStyle(
                color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: Color(0xFF028090),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => PersistentBottomNavBar(),
              ));
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
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
                columns: const <DataColumn>[
                  DataColumn(
                    label: Text(
                      'Product ID',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Medicine Name',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Supplier Name',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Category Name',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Brand Name',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Created Date',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Delete Date',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Actions',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                ],
                rows: List<DataRow>.generate(
                  deletedProducts.length,
                  (index) {
                    var product = deletedProducts[index];
                    return DataRow(
                      cells: [
                        DataCell(Text(product['productId']!)),
                        DataCell(Text(product['medicineName']!)),
                        DataCell(Text(product['supplierName']!)),
                        DataCell(Text(product['categoryName']!)),
                        DataCell(Text(product['brandName']!)),
                        DataCell(Text(product['createdDate']!)),
                        DataCell(Text(product['deleteDate']!)),
                        DataCell(
                          Row(
                            children: [
                              IconButton(
                                icon: Icon(
                                  Icons.restore,
                                  color: Colors.blue,
                                ),
                                onPressed: () {
                                  restoreProduct(index);
                                },
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  deleteProduct(index);
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
