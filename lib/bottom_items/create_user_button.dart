import 'package:flutter/material.dart';

class CreateUserButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ElevatedButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) => ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.0),
                topRight: Radius.circular(16.0),
              ),
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.all(16.0),
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.75,
                ),
                child: Scrollbar(
                  // Adding the scrollbar here
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Create User',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 20),
                        _buildTextField('Name'),
                        SizedBox(height: 10),
                        _buildTextField('Contact Number'),
                        SizedBox(height: 10),
                        _buildTextField('Email'),
                        SizedBox(height: 10),
                        _buildTextField('Password', obscureText: true),
                        SizedBox(height: 10),
                        _buildTextField('Aadhaar ID'),
                        SizedBox(height: 20),
                        _buildDropdown(),
                        SizedBox(height: 20),
                        _buildTextArea('Address'),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            // Handle form submission
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Staff created successfully!'),
                                backgroundColor: Colors.green,
                              ),
                            );
                            // Close the bottom sheet if needed
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF028090),
                          ),
                          child: Text(
                            'Submit',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF028090),
          shape: CircleBorder(),
          padding: EdgeInsets.all(10),
        ),
        child: Icon(Icons.person_add, color: Colors.white, size: 24),
      ),
    );
  }

  Widget _buildTextField(String title, {bool obscureText = false}) {
    return TextField(
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: title,
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
      cursorColor: Color(0xFF028090), // Cursor color
    );
  }

  Widget _buildDropdown() {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        hintText: 'Select Role',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(
            color: Colors.black, // Default border color
            width: 1.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(
            color: Color(0xFF028090), // Focused border color
            width: 2.0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(
            color: Color(0xFF028090), // Enabled border color
            width: 1.0,
          ),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      ),
      items: [
        DropdownMenuItem(child: Text('Admin'), value: 'Admin'),
        DropdownMenuItem(child: Text('Staff'), value: 'Staff'),
      ],
      onChanged: (value) {
        // Handle dropdown selection
      },
      dropdownColor: Colors.white, // Set dropdown background color
      selectedItemBuilder: (context) {
        return [
          Text(
            'Admin',
            style: TextStyle(color: Colors.red), // Color for Admin
          ),
          Text(
            'Staff',
            style: TextStyle(color: Colors.blue), // Color for Staff
          ),
        ];
      },
    );
  }

  Widget _buildTextArea(String title) {
    return TextField(
      maxLines: 4,
      decoration: InputDecoration(
        hintText: title,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(
            color: Colors.black, // Default border color
            width: 1.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(
            color: Color(0xFF028090), // Focused border color
            width: 2.0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(
            color: Color(0xFF028090), // Enabled border color
            width: 1.0,
          ),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      ),
      cursorColor: Color(0xFF028090), // Cursor color
    );
  }
}
