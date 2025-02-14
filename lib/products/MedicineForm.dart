import 'package:flutter/material.dart';
import 'package:flutter_application_1/API_Service/api_service.dart';
import 'package:flutter_application_1/products/create_product.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'DropdownComponent.dart';
import 'DateFieldComponent.dart';

class MedicineForm extends StatefulWidget {
  final Function(Map<String, String>) onAddProduct;

  MedicineForm(
      {required this.onAddProduct, required Map<String, String> product});

  @override
  _MedicineFormState createState() => _MedicineFormState();
}

final ApiService _apiService = ApiService();

class _MedicineFormState extends State<MedicineForm> {
  final _formKey = GlobalKey<FormState>();
 List<String> _supplierList = [];
  String? _selectedSupplier;

  String? _selectedCategory;
  String? _availabilityStatus;
  final TextEditingController _expiryDateController = TextEditingController();
  final TextEditingController _mfdDateController = TextEditingController();
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
  final TextEditingController _sellingPriceController = TextEditingController();
  final List<Map<String, String>> products = [];

  Future<void> _submitForm() async {
    Map<String, dynamic> productData = {
      'product_name': _nameController.text,
      'brand_name': _brandController.text,
      'generic_name': _genericNameController.text,
      'product_batch_no': _batchnoNameController.text,
      'product_price': _mrpPriceController.text,
      'selling_price': _sellingPriceController.text,
      'product_description': _descriptionController.text,
      'product_quantity': _quantityController.text,
      'product_discount': _discountPercentageController.text,
      'supplier_price': _supplierPriceController.text,
      'GST': _gstController.text,
      'supplier': _supplierNameController.text,
      'expiry_date': _expiryDateController.text,
      'MFD': _mfdDateController.text,
      'product_category': _selectedCategory,
      'stock_status': _availabilityStatus,
    };

    bool success = await _apiService.createProduct(productData);

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('User created successfully!'),
            backgroundColor: Colors.green),
      );
      Navigator.pop(context); // Close modal
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Failed to create user.'),
            backgroundColor: Colors.red),
      );
    }
  }



@override
void initState() {
  super.initState();
  _loadSuppliers();
}

Future<void> _loadSuppliers() async {
  List<String> suppliers = await _apiService.fetchSupplierNames();
  setState(() {
    _supplierList = suppliers;
  });
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF028090),
        title: Text('Add Product',
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
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
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter a name' : null),
              TextFieldComponent(
                  label: 'Brand Name',
                  controller: _brandController,
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter a brand name' : null),
              TextFieldComponent(
                  label: 'Generic Name',
                  controller: _genericNameController,
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter a generic name' : null),
              TextFieldComponent(
                  label: 'Batch No',
                  controller: _batchnoNameController,
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter a batch No' : null),
              TextFieldComponent(
                  label: 'Quantity',
                  controller: _quantityController,
                  keyboardType: TextInputType.number,
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter a quantity' : null),
              DropdownComponent(
                  label: 'Category',
                  items: ['Medicine', 'Antibiotics', 'Tablet', 'Syrup'],
                  selectedValue: _selectedCategory,
                  onChanged: (value) =>
                      setState(() => _selectedCategory = value),
                  validator: (value) =>
                      value == null ? 'Please select a category' : null),
              SizedBox(height: 18),
              TextFieldComponent(
                  label: 'MRP Price',
                  controller: _mrpPriceController,
                  keyboardType: TextInputType.number,
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter MRP price' : null),
              GSTDropdownField(
                  label: 'GST Number',
                  items: ['5%', '12%', '18%', '28%'],
                  selectedValue: _gstController.text,
                  onChanged: (value) =>
                      setState(() => _gstController.text = value!),
                  validator: (value) =>
                      value == null ? 'Please select a GST Value' : null),
              SizedBox(height: 18),
              MFDDateFieldComponent(
                controller: _mfdDateController,
                validator: (value) =>
                    value!.isEmpty ? 'Please select an MFD date' : null,
                label: 'MFD Date',
              ),
              DateFieldComponent(
                controller: _expiryDateController,
                validator: (value) =>
                    value!.isEmpty ? 'Please select an expiry date' : null,
                label: 'Expiry Dater',
              ),
              SupplierDropdownField(
                items: _supplierList,
                selectedValue: _selectedSupplier,
                onChanged: (value) => setState(() => _selectedSupplier = value),
                label: 'Select Supplier Name',
                validator: (value) =>
                    value == null ? 'Please select a supplier' : null,
              ),
              SizedBox(height: 18),
              DropdownComponent(
                  label: 'Availability Status',
                  items: ['Available', 'Unavailable'],
                  selectedValue: _availabilityStatus,
                  onChanged: (value) =>
                      setState(() => _availabilityStatus = value),
                  validator: (value) => value == null
                      ? 'Please select an availability status'
                      : null),
              SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                      onPressed: () => _formKey.currentState!.reset(),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey),
                      child: Text('Cancel',
                          style: TextStyle(color: Colors.white))),
                  ElevatedButton(
                      onPressed: _submitForm,
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF028090)),
                      child: Text('Submit',
                          style: TextStyle(color: Colors.white))),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
