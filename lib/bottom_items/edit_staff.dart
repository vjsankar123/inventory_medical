import 'package:flutter/material.dart';

class EditStaffPage extends StatefulWidget {
  final Map<String, dynamic> staffData;
  final Function(Map<String, dynamic>) onSave;

  EditStaffPage({required this.staffData, required this.onSave});

  @override
  _EditStaffPageState createState() => _EditStaffPageState();
}

class _EditStaffPageState extends State<EditStaffPage> {
  late TextEditingController nameController;
  late TextEditingController contactController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController aadhaarController;
  late TextEditingController addressController;
  String? selectedRole;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.staffData['name']);
    contactController =
        TextEditingController(text: widget.staffData['contact'] ?? '');
    emailController = TextEditingController(text: widget.staffData['email']);
    passwordController =
        TextEditingController(text: widget.staffData['password'] ?? '');
    aadhaarController =
        TextEditingController(text: widget.staffData['aadhaarId'] ?? '');
    addressController =
        TextEditingController(text: widget.staffData['address'] ?? '');
    selectedRole = widget.staffData['role'] ?? 'Staff';
  }

  @override
  void dispose() {
    nameController.dispose();
    contactController.dispose();
    emailController.dispose();
    passwordController.dispose();
    aadhaarController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit User',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white
          ),
          
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF028090),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTextField('Name', nameController),
              SizedBox(height: 10),
              _buildTextField('Contact Number', contactController),
              SizedBox(height: 10),
              _buildTextField('Email', emailController),
              SizedBox(height: 10),
              _buildTextField('Password', passwordController,
                  obscureText: true),
              SizedBox(height: 10),
              _buildTextField('Aadhaar ID', aadhaarController),
              SizedBox(height: 20),
              _buildDropdown(),
              SizedBox(height: 20),
              _buildTextArea('Address', addressController),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _showSaveConfirmation(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF028090),
                ),
                child: Text(
                  'Save Changes',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String hintText, TextEditingController controller,
      {bool obscureText = false}) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
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
        contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      ),
      cursorColor: Color(0xFF028090),
    );
  }

  Widget _buildDropdown() {
    return DropdownButtonFormField<String>(
      value: selectedRole,
      decoration: InputDecoration(
        hintText: 'Select Role',
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
        contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      ),
      items: [
        DropdownMenuItem(value: 'Admin', child: Text('Admin')),
        DropdownMenuItem(value: 'Staff', child: Text('Staff')),
      ],
      onChanged: (value) {
        setState(() {
          selectedRole = value;
        });
      },
      dropdownColor: Colors.white,
    );
    
  }

  Widget _buildTextArea(String hintText, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      maxLines: 4,
      decoration: InputDecoration(
        hintText: hintText,
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
        contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      ),
      cursorColor: Color(0xFF028090),
    );
  }

  void _showSaveConfirmation() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Confirm Save',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
              SizedBox(height: 10),
              Text('Are you sure you want to save these changes?'),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context); // Close the modal
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    child: Text(
                      'Cancel',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Map<String, dynamic> updatedData = {
                        'name': nameController.text,
                        'contact': contactController.text,
                        'email': emailController.text,
                        'password': passwordController.text,
                        'aadhaarId': aadhaarController.text,
                        'address': addressController.text,
                        'role': selectedRole,
                      };
                      widget.onSave(updatedData); // Pass updated data back

                      Navigator.pop(context); // Close the modal
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Staff updated successfully!'),
                          backgroundColor: Colors.green,
                        ),
                      );

                      Navigator.pop(context); // Navigate back
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    child: Text(
                      'Save',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
