import 'package:flutter/material.dart';

class TextFieldComponent extends StatelessWidget {
  final String label;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  TextFieldComponent({
    required this.label,
    this.keyboardType = TextInputType.text,
    required this.controller,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        TextFormField(
          decoration: InputDecoration(
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
          controller: controller,
          keyboardType: keyboardType,
          validator: validator,
        ),
        SizedBox(height: 16),
      ],
    );
  }
}
