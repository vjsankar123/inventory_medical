import 'package:flutter/material.dart';
import 'package:flutter_application_1/products/DateFieldComponent.dart';
import 'package:flutter_application_1/products/DropdownComponent.dart';
import 'package:flutter_application_1/products/create_product.dart';

class Medicineedit extends StatefulWidget {
  final Function(Map<String, String>) onAddProduct;
  final Map<String, String>
      product; // Adding product to initialize the form with existing values

  Medicineedit({required this.onAddProduct, required this.product});

  @override
  _MedicineeditState createState() => _MedicineeditState();
}

class _MedicineeditState extends State<Medicineedit> {
  late TextEditingController _nameController;
  late TextEditingController _brandController;
  late TextEditingController _categoryController;
  late TextEditingController _expiryDateController;
  late TextEditingController _batchnoNameController;
  late TextEditingController _qtyController;
  late TextEditingController _mrpPriceController;
  late TextEditingController _supplierPriceController;
  late TextEditingController _descriptionController;
  late TextEditingController _discountPercentageController;
  late TextEditingController _supplierNameController;
  late TextEditingController _gstController;

  final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(); // Added form key

  String? _selectedCategory;
  String? _availabilityStatus;

  late TextEditingController _genericNameController;

  @override
  void initState() {
    super.initState();

    // Initialize the controllers with existing product values (if any)
    _nameController = TextEditingController(text: widget.product['name']);
    _brandController = TextEditingController(text: widget.product['brand']);
    _categoryController =
        TextEditingController(text: widget.product['category']);
    _expiryDateController =
        TextEditingController(text: widget.product['expiryDate']);
    _batchnoNameController =
        TextEditingController(text: widget.product['batchnoName']);
    _qtyController = TextEditingController(text: widget.product['qty']);
    _genericNameController = TextEditingController(
        text: widget.product['genericName']); // Initialize here
    _mrpPriceController =
        TextEditingController(text: widget.product['mrpPrice']);
    _supplierPriceController =
        TextEditingController(text: widget.product['supplierPrice']);
    _descriptionController =
        TextEditingController(text: widget.product['description']);
    _discountPercentageController =
        TextEditingController(text: widget.product['discountPercentage']);
    _supplierNameController =
        TextEditingController(text: widget.product['supplierName']);
    _gstController = TextEditingController(text: widget.product['gst']);

    _selectedCategory = widget.product['category']; // Setting initial value
    _availabilityStatus =
        widget.product['availabilityStatus']; // Setting initial value
  }

  @override
  void dispose() {
    _nameController.dispose();
    _brandController.dispose();
    _categoryController.dispose();
    _expiryDateController.dispose();
    _batchnoNameController.dispose();
    _qtyController.dispose();
    _genericNameController.dispose();
    _mrpPriceController.dispose();
    _supplierPriceController.dispose();
    _descriptionController.dispose();
    _discountPercentageController.dispose();
    _supplierNameController.dispose();
    _gstController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      // Gather the updated values
      Map<String, String> updatedProduct = {
        'name': _nameController.text,
        'brand': _brandController.text,
        'category': _categoryController.text,
        'expiryDate': _expiryDateController.text,
        'batchnoName': _batchnoNameController.text,
        'qty': _qtyController.text,
        'genericName': _genericNameController.text,
        'mrpPrice': _mrpPriceController.text,
        'supplierPrice': _supplierPriceController.text,
        'description': _descriptionController.text,
        'discountPercentage': _discountPercentageController.text,
        'supplierName': _supplierNameController.text,
        'gst': _gstController.text,
        'availabilityStatus': _availabilityStatus ?? '',
      };
      widget.onAddProduct(
          updatedProduct); // Pass the updated product to the parent
      Navigator.pop(context); // Close the form after submitting
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF028090),
        title: Text(
          'Edit Product',
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
                    ? 'Please enter a Batch No'
                    : null,
              ),
              TextFieldComponent(
                label: 'Quantity',
                controller: _qtyController,
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
                validator: (value) => value == null || value.isEmpty
                    ? 'Please enter MRP price'
                    : null,
              ),
              TextFieldComponent(
                label: 'Supplier Price',
                controller: _supplierPriceController,
                keyboardType: TextInputType.number,
                validator: (value) => value == null || value.isEmpty
                    ? 'Please enter supplier price'
                    : null,
              ),
              TextFieldComponent(
                label: 'Description',
                controller: _descriptionController,
                keyboardType: TextInputType.text,
                validator: (value) => value == null || value.isEmpty
                    ? 'Please enter a description'
                    : null,
              ),
              TextFieldComponent(
                label: 'Discount Percentage',
                controller: _discountPercentageController,
                keyboardType: TextInputType.number,
                validator: (value) => value == null || value.isEmpty
                    ? 'Please enter discount percentage'
                    : null,
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
                validator: (value) => value == null || value.isEmpty
                    ? 'Please enter supplier name'
                    : null,
              ),
              TextFieldComponent(
                label: 'GST %',
                controller: _gstController,
                keyboardType: TextInputType.number,
                validator: (value) => value == null || value.isEmpty
                    ? 'Please enter GST percentage'
                    : null,
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
              ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF028090),
                ),
                child: Text('Update', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
