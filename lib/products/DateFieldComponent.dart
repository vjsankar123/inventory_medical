import 'package:flutter/material.dart';

class DateFieldComponent extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;

  DateFieldComponent({
    required this.controller,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Expiry Date',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        TextFormField(
          readOnly: true,
          decoration: InputDecoration(
            suffixIcon: IconButton(
              icon: Icon(Icons.calendar_today),
              onPressed: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2100),
                  builder: (context, child) {
                    return Theme(
                      data: Theme.of(context).copyWith(
                        colorScheme: ColorScheme.light(
                          primary: Color(0xFF028090),
                          onPrimary: Colors.white,
                          onSurface: Colors.black,
                        ),
                      ),
                      child: child!,
                    );
                  },
                );

                if (pickedDate != null) {
                  controller.text =
                      '${pickedDate.day.toString().padLeft(2, '0')}/${pickedDate.month.toString().padLeft(2, '0')}/${pickedDate.year.toString().substring(2)}';
                }
              },
            ),
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
            hintText: 'DD-MM-YYYY',
          ),
          controller: controller,
          validator: validator,
        ),
        SizedBox(height: 16),
      ],
    );
  }
}
