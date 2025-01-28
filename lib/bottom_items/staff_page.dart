import 'package:flutter/material.dart';
import 'package:flutter_application_1/dashboard/persistent_bottom_nav_bar.dart';
import 'staff_card.dart';
import 'search_widget.dart';
import 'create_user_button.dart';

class StaffPage extends StatefulWidget {
  @override
  _StaffPageState createState() => _StaffPageState();
}

class _StaffPageState extends State<StaffPage> {
  final List<Map<String, String>> staffList = [
    // Sample staff data
    {
      'name': 'Vignesh',
      'email': 'Vignesh@example.com',
      'contact': '1234567890',
      'role': 'Admin'
    },
    {
      'name': 'Sankar',
      'email': 'Sankar@example.com',
      'contact': '0987654321',
      'role': 'Staff'
    },
    {
      'name': 'Ram',
      'email': 'Ram@example.com',
      'contact': '1122334455',
      'role': 'Admin'
    },
  ];

  TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Navigate back to the PersistentBottomNavBar with the Home tab selected
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => PersistentBottomNavBar(),
        ));
        return false; // Prevent the default back button behavior
      },
      child: Scaffold(
        appBar: AppBar(
          title: _isSearching
              ? SearchWidget(controller: _searchController)
              :FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            'User List', // Adjusted title for flexibility
            style: TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.bold, // Bold text for better visibility
            ),
          ),
        ),
          actions: [
            IconButton(
              icon: Icon(_isSearching ? Icons.cancel : Icons.search),
              onPressed: () {
                setState(() {
                  _isSearching = !_isSearching;
                  if (!_isSearching) _searchController.clear();
                });
              },
            ),
            CreateUserButton(),
          ],
          backgroundColor: Colors.white,
        ),
        backgroundColor: Colors.white,
        body: ListView.builder(
          itemCount: staffList.length,
          itemBuilder: (context, index) {
            if (_searchController.text.isNotEmpty &&
                !staffList[index]['name']!
                    .toLowerCase()
                    .contains(_searchController.text.toLowerCase())) {
              return Container();
            }
            return StaffCard(
              staff: staffList[index],
              onDelete: () {},
            );
          },
        ),
      ),
    );
  }
}
