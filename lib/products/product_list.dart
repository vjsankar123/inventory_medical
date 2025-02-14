import 'package:flutter/material.dart';
import 'package:flutter_application_1/API_Service/api_service.dart';
import 'package:flutter_application_1/products/MedicineForm.dart';
import 'package:flutter_application_1/products/create_product.dart';
import 'package:flutter_application_1/products/medicine_edit.dart';
import 'package:flutter_application_1/products/view_product.dart';
import 'package:flutter_application_1/dashboard/persistent_bottom_nav_bar.dart'; // Import PersistentBottomNavBar
import 'package:file_picker/file_picker.dart';

void main() {
  runApp(MaterialApp(
    home: ProductList(),
  ));
}

class ProductList extends StatefulWidget {
  @override
  _ProductListState createState() => _ProductListState();
}
final ApiService apiService = ApiService();

class _ProductListState extends State<ProductList>

    with SingleTickerProviderStateMixin {
       final ApiService apiService = ApiService();
  List<Map<String, dynamic>> products = [];
  bool _isLoading = true;
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';


  
 
  

  void _bulkInsert() {
    setState(() {
      products.addAll(List.generate(
          5,
          (index) => {
                'sno': (products.length + 1).toString(),
                'name': 'Bulk Name ${products.length + 1}',
                'brand': 'Bulk Brand ${products.length + 1}',
                'category': 'Bulk Category ${products.length + 1}',
                'expiryDate':
                    '2025-02-${(index + 1).toString().padLeft(2, '0')}',
                'qty': '${(index + 1) * 10}',
              }));
    });
  }

  void _addProduct(Map<String, String> product) {
    setState(() {
      products.add(product);
    });
  }

  void _editProduct(Map<String, dynamic> product) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Medicineedit(
          onAddProduct: (updatedProduct) {
            setState(() {
              int index = products.indexOf(product);
              products[index] = updatedProduct;
            });
          },
          product: product,
        ),
      ),
    );
  }
 void initState() {
    super.initState();
    _fetchProducts();
    _controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );
    _opacityAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _controller.repeat(reverse: true);
  }

  Future<void> _fetchProducts() async {
    try {
      List<Map<String, dynamic>> fetchedProducts = await apiService.fetchProducts();
      setState(() {
        products = fetchedProducts;
        _isLoading = false;
      });
    } catch (e) {
      print("Error fetching products: $e");
      setState(() {
        _isLoading = false;
      });
    }
  }

  

  void _deleteProduct(Map<String, dynamic> product) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Delete'),
          content: Text('Are you sure you want to delete this product?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                // await apiService.deleteProduct(product['id']);
                _fetchProducts();
                Navigator.of(context).pop();
              },
              child: Text('OK', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }


void _viewProduct(Map<String, dynamic> product) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => ProductDetailsPage(product: product),
    ),
  );
}


  // @override
  // void initState() {
  // //   super.initState();

  // //   _controller = AnimationController(
  // //     duration: Duration(seconds: 1),
  // //     vsync: this,
  // //   );

  // //   _opacityAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
  // //     CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
  // //   );

  // //   _controller.repeat(reverse: true);
  // // }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _startSearch() {
    setState(() {
      _isSearching = true;
    });
  }

  void _stopSearch() {
    setState(() {
      _isSearching = false;
      _searchQuery = '';
      _searchController.clear();
    });
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
          backgroundColor: Colors.white,
          title: _isSearching
              ? Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 6,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: _searchController,
                    onChanged: (value) {
                      setState(() {
                        _searchQuery = value;
                      });
                    },
                    autofocus: true,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      hintText: 'Search...',
                      hintStyle: TextStyle(color: Colors.black),
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.search, color: Colors.black),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: 15.0),
              ),
              cursorColor: Color(0xFF028090),
            ),
          )
        : FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            'Product List', // Adjusted title for flexibility
            style: TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.bold, // Bold text for better visibility
            ),
          ),
        ),
          actions: [
            IconButton(
              icon: Icon(
                _isSearching ? Icons.close : Icons.search,
                color: Colors.black,
              ),
              onPressed: _isSearching ? _stopSearch : _startSearch,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: TextButton.icon(
                onPressed: () async {
                  // Open the file picker
                  FilePickerResult? result =
                      await FilePicker.platform.pickFiles();

                  // Check if the user picked any files
                  if (result != null) {
                    // Handle the selected files
                    String? filePath = result.files.single.path;
                    print('Picked file: $filePath');
                  } else {
                    // No files selected
                    print('No file selected');
                  }
                },
                icon: Icon(Icons.add_box, color: Colors.green),
                label: Text('Bulk Insert'),
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Color(0xFF028090),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  textStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          ],
        ),
        backgroundColor: Colors.white,
        body:_isLoading
            ? Center(child: CircularProgressIndicator())
            
         :Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView.builder(
            itemCount: products.length,
                itemBuilder: (context, index) {
              final product = products[index];
              return Container(
                margin: EdgeInsets.symmetric(vertical: 10.0),
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
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Name: ${product['product_name'] ?? 'N/A'}',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Brand: ${product['brand_name'] ?? 'N/A'}',
                        style: TextStyle(fontSize: 16, color: Colors.black54),
                      ),
                      Text(
                        'Category: ${product['product_category'] ?? 'N/A'}',
                        style: TextStyle(fontSize: 16, color: Colors.black54),
                      ),
                      Text(
                        'Expiry Date: ${product['expiry_date'] ?? 'N/A'}',
                        style: TextStyle(fontSize: 16, color: Colors.black54),
                      ),
                      Text(
                        'Quantity: ${product['product_quantity'] ?? '0'}',
                        style: TextStyle(fontSize: 16, color: Colors.black54),
                      ),
                      SizedBox(height: 10),
                      Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton.icon(
                            icon: Icon(Icons.visibility,size: 24.0,
                                color: Color(0xFF028090)),
                            label: Text(
                              'View',
                              style: TextStyle(color: Colors.black),
                            ),
                            onPressed: () => _viewProduct(product),
                          ),
                          TextButton.icon(
                            icon: Icon(Icons.edit_note, color: Colors.orange,size: 24.0,),
                            label: Text('Edit',
                                style: TextStyle(color: Colors.black)),
                            onPressed: () => _editProduct(product),
                          ),
                          TextButton.icon(
                            icon: Icon(Icons.delete_sweep, color: Colors.red,size: 24.0),
                            label: Text('Delete',
                                style: TextStyle(color: Colors.black)),
                            onPressed: () => _deleteProduct(product),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        floatingActionButton: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Opacity(
              opacity: _opacityAnimation.value,
              child: FloatingActionButton(
                 onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MedicineForm(
                  onAddProduct: (newProduct) {
                    _fetchProducts();
                  },
                  product: {},
                ),
              ),
            );
          },
                child: Icon(Icons.add, color: Colors.white, size: 30.0),
                backgroundColor: Color.fromRGBO(2, 116, 131, 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            );
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      ),
    );
  }
}
