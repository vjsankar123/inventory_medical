import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final String title;
  final String data;
  // final Color color;
  final Gradient gradient;
  final IconData icon;

  const CustomCard({
    Key? key,
    required this.title,
    required this.data,
    // required this.color,
    required this.icon,
    required this.gradient,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minWidth: 140, // Minimum width to maintain rectangle shape
        minHeight: 100, // Adjusted minimum height to provide more space
      ),
      margin: const EdgeInsets.all(5), // Adjust margin as needed
       decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8), // Added comma here
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start, // Space out items evenly
          children: [
            Container(
              padding: const EdgeInsets.all(8), // Padding around the icon
              decoration: BoxDecoration(
                color: Color(0xFFFFFFFF), // Background color for the icon
                borderRadius: BorderRadius.circular(
                    50), // Rounded corners for the background
              ),
              child: Icon(
                icon,
                color: Colors.black,
                size: 24, // Larger icon for better visibility
              ),
            ),
            SizedBox(
              width: 6,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15, // Adjust font size as needed
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  data,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20, // Adjust font size as needed
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
