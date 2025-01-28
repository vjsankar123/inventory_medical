import 'package:flutter/material.dart';
import 'package:flutter_application_1/products/create_product.dart';
import 'DropdownComponent.dart';
import 'DateFieldComponent.dart';

class MedicineForm extends StatefulWidget {
  final Function(Map<String, String>) onAddProduct;

  MedicineForm({required this.onAddProduct, required Map<String, String> product});

  @override
  _MedicineFormState createState() => _MedicineFormState();
}

class _MedicineFormState extends State<MedicineForm> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedCategory;
  String? _availabilityStatus;
  final TextEditingController _expiryDateController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _brandController = TextEditingController();
  final TextEditingController _genericNameController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _mrpPriceController = TextEditingController();
  final TextEditingController _supplierPriceController =
      TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _discountPercentageController =
      TextEditingController();
  final TextEditingController _supplierNameController = TextEditingController();
  final TextEditingController _batchnoNameController = TextEditingController();
  final TextEditingController _gstController = TextEditingController();
  final List<Map<String, String>> products = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF028090),
        title: Text(
          'Add Product',
          style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFieldComponent(
                label: 'Name',
                controller: _nameController,
                validator: (value) => value == null || value.isEmpty
                    ? 'Please enter a name'
                    : null,
              ),
              TextFieldComponent(
                label: 'Brand Name',
                controller: _brandController,
                validator: (value) => value == null || value.isEmpty
                    ? 'Please enter a brand name'
                    : null,
              ),
              TextFieldComponent(
                label: 'Generic Name',
                controller: _genericNameController,
                validator: (value) => value == null || value.isEmpty
                    ? 'Please enter a generic name'
                    : null,
              ),
               TextFieldComponent(
                label: 'Batch No',
                controller: _batchnoNameController,
                validator: (value) => value == null || value.isEmpty
                    ? 'Please enter a batch No'
                    : null,
              ),
              TextFieldComponent(
                label: 'Quantity',
                controller: _quantityController,
                keyboardType: TextInputType.number,
                validator: (value) => value == null || value.isEmpty
                    ? 'Please enter a quantity'
                    : null,
              ),
              Text('Select Category',style: TextStyle(fontSize: 18,
            fontWeight: FontWeight.bold,),),
              SizedBox(height: 10,),
              DropdownComponent(
                label: 'Category',
                items: ['Medicine', 'Antibiotics', 'Tablet', 'Syrup'],
                selectedValue: _selectedCategory,
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value;
                  });
                },
                validator: (value) =>
                    value == null ? 'Please select a category' : null,
              ),
              SizedBox(height: 10,),
              TextFieldComponent(
                label: 'MRP Price',
                controller: _mrpPriceController,
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value == null || value.isEmpty ? 'Please enter MRP price' : null,
              ),
              TextFieldComponent(
                label: 'Supplier Price',
                controller: _supplierPriceController,
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value == null || value.isEmpty ? 'Please enter supplier price' : null,
              ),
              TextFieldComponent(
                label: 'Description',
                controller: _descriptionController,
                keyboardType: TextInputType.text,
                validator: (value) =>
                    value == null || value.isEmpty ? 'Please enter a description' : null,
              ),
              TextFieldComponent(
                label: 'Discount Percentage',
                controller: _discountPercentageController,
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value == null || value.isEmpty ? 'Please enter discount percentage' : null,
              ),
              DateFieldComponent(
                controller: _expiryDateController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select an expiry date';
                  }
                  final regex = RegExp(r'^\d{2}\/\d{2}\/\d{2}$');
                  if (!regex.hasMatch(value)) {
                    return 'Invalid expiry date format';
                  }
                  return null;
                },
              ),
              TextFieldComponent(
                label: 'Supplier Name',
                controller: _supplierNameController,
                validator: (value) =>
                    value == null || value.isEmpty ? 'Please enter supplier name' : null,
              ),
              TextFieldComponent(
                label: 'GST %',
                controller: _gstController,
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value == null || value.isEmpty ? 'Please enter GST percentage' : null,
              ),
               SizedBox(height: 10,),
                Text('Availability Status',style: TextStyle(fontSize: 18,
            fontWeight: FontWeight.bold,),),
              SizedBox(height: 10,),
              DropdownComponent(
                label: 'Availability Status',
                items: ['Available', 'Unavailable'],
                selectedValue: _availabilityStatus,
                onChanged: (value) {
                  setState(() {
                    _availabilityStatus = value;
                  });
                },
                validator: (value) => value == null
                    ? 'Please select an availability status'
                    : null,
              ),
              SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _formKey.currentState!.reset();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                    ),
                    child:
                        Text('Cancel', style: TextStyle(color: Colors.white)),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Map<String, String> newProduct = {
                          'sno': (products.length + 1).toString(),
                          'name': _nameController.text,
                          'brand': _brandController.text,
                          'category': _selectedCategory!,
                          'expiryDate': _expiryDateController.text,
                          'qty': _quantityController.text,
                        };
                        widget.onAddProduct(newProduct); // Adds the product
                        Navigator.pop(context); // Close the form
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF028090),
                    ),
                    child:
                        Text('Submit', style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
