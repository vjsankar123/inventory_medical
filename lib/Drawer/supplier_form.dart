import 'package:flutter/material.dart';

class SupplierForm extends StatefulWidget {
  final Function(Map<String, String>) onAddSupplier;
  final Map<String, String>? initialSupplier;

  SupplierForm({required this.onAddSupplier, this.initialSupplier});

  @override
  _SupplierFormState createState() => _SupplierFormState();
}

class _SupplierFormState extends State<SupplierForm> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();
  final _gstController = TextEditingController();
  String _status = 'Active';

  @override
  void initState() {
    super.initState();
    if (widget.initialSupplier != null) {
      _nameController.text = widget.initialSupplier!['Name']!;
      _phoneController.text = widget.initialSupplier!['Phone No']!;
      _emailController.text = widget.initialSupplier!['Email']!;
      _addressController.text = widget.initialSupplier!['Address']!;
      _gstController.text = widget.initialSupplier!['GST No']!;
      _status = widget.initialSupplier!['Status']!;
    }
  }

 @override
Widget build(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Container(
      // color: Colors.white, // Set background color to white
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Add New Supplier', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            _buildTextField(_nameController, 'Name'),
            _buildTextField(_phoneController, 'Phone No'),
            _buildTextField(_emailController, 'Email'),
            _buildTextField(_addressController, 'Address'),
            _buildTextField(_gstController, 'GST No'),
            const SizedBox(height: 16),
            Text('Status:', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.black),
              ),
              child: DropdownButton<String>(
                value: _status,
                onChanged: (newValue) {
                  setState(() {
                    _status = newValue!;
                  });
                },
                isExpanded: true,
                underline: SizedBox(),
                items: <String>['Active', 'Inactive']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(value),
                    ),
                  );
                }).toList(),
                dropdownColor: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    ),
                    child: Text('Cancel', style: TextStyle(color: Colors.white)),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      final newSupplier = {
                        'Name': _nameController.text,
                        'Phone No': _phoneController.text,
                        'Email': _emailController.text,
                        'Address': _addressController.text,
                        'GST No': _gstController.text,
                        'Status': _status,
                      };
                      widget.onAddSupplier(newSupplier);
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF028090),
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    ),
                    child: Text('Add'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
  
}


  Widget _buildTextField(TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold),
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
    );
  }
}
