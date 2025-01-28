import 'package:flutter/material.dart';

// Modified ProductDetailsPage with Close button at the bottom
class ProductDetailsPage extends StatelessWidget {
  final Map<String, String> product;

  ProductDetailsPage({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Product Details',
         style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF028090),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
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
          child: Card(
            elevation: 5,
            color: Colors.white, // Set the card background color to white
            child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDetailRow('Name', product['name']),
                _buildDetailRow('Brand Name', product['brand']),
                _buildDetailRow('Category', product['category']),
                _buildDetailRow('Generic Name', product['generic']),
                _buildDetailRow('Batch No', product['batch']),
                _buildDetailRow('MRP Price', product['MRP Price']),
                _buildDetailRow('Supplier Price', product['supplier']),
                _buildDetailRow('Description', product['description']),
                _buildDetailRow('Discount Percentage', product['discount']),
                _buildDetailRow('Supplier Name', product['supplier']),
                _buildDetailRow('Expiry Date', product['expiryDate']),
                _buildDetailRow('GST %', product['GST']),
                _buildDetailRow('Availability Status', product['availability']),
                _buildDetailRow('Quantity', product['qty']),
                SizedBox(height: 20), // Space before the button
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context)
                          .pop(); // Close the page and return to the previous screen
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF028090),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text(
                      'Close',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )),
      ),
    )
    );
  }

  // Helper method to build each detail row
  Widget _buildDetailRow(String title, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            '$title:',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              value ?? 'N/A',
              style: TextStyle(
                fontSize: 18,
                color: Colors.black54,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
