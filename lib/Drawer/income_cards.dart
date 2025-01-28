import 'package:flutter/material.dart';

class IncomeCards extends StatelessWidget {
  final String title;
  final String data;
  final Color color;
  final IconData icon;

  const IncomeCards({
    Key? key,
    required this.title,
    required this.data,
    required this.color,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minWidth: 140, // Minimum width to maintain rectangle shape
        minHeight: 90, // Adjusted minimum height to provide more space
      ),
      margin: const EdgeInsets.all(5), // Adjust margin as needed
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10), // Slightly rounded corners
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10), // Padding around the icon
              decoration: BoxDecoration(
                color:  Colors.white, // Background color for the icon
                borderRadius: BorderRadius.circular(50), // Rounded corners
              ),
              child: Icon(
                icon,
                color: Colors.black,
                size: 20, // Larger icon for better visibility
              ),
            ),
            const SizedBox(width: 6),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18, // Adjust font size as needed
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.currency_rupee,
                      color: Colors.white,
                      size: 18, // Small rupee icon size
                    ),
                    Text(
                      data,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22, // Adjust font size as needed
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
