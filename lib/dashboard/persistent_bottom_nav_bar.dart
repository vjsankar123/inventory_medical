import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Billing/pnarmacy_invoice.dart';
import 'package:flutter_application_1/Drawer/category_page.dart';
import 'package:flutter_application_1/bottom_items/home_page.dart';
import 'package:flutter_application_1/bottom_items/staff_page.dart';
import 'package:flutter_application_1/components/screen.dart';
import 'package:flutter_application_1/dashboard/custom_drawer.dart';
import 'package:flutter_application_1/products/product_list.dart';
import 'package:flutter_application_1/profile/profile.dart';

class PersistentBottomNavBar extends StatefulWidget {
  @override
  _PersistentBottomNavBarState createState() => _PersistentBottomNavBarState();
}

class _PersistentBottomNavBarState extends State<PersistentBottomNavBar> {
  final _controller = NotchBottomBarController(index: 0);

  final List<Widget> _pages = [
    Homepage(),
    ProductList(),
    PharmacyInvoiceScreen(),
    StaffPage(),
    ShopDetailsScreen(),
    // CategoryPage(),
  ];

  bool _isDrawerOpen = false;
  int _selectedDrawerIndex = 0;

  // This method will update the index based on drawer tap
  void _onDrawerItemTap(int index) {
    setState(() {
      _selectedDrawerIndex = index;
      _controller.index =
          index.clamp(0, 4); // Ensure valid index range (0 to 4)
    });
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text('Log Out'),
          content: Text('Are you sure you want to log out?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text(
                'Cancel',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            TextButton(
              onPressed: () async {
                // Show a dialog with a loading spinner and "Logging out..." text
                showDialog(
                  context: context,
                  barrierDismissible: false, // Prevent closing the dialog
                  builder: (BuildContext context) {
                    return Dialog(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Color(
                                    0xFF028090), // Custom color for the spinner
                              ),
                            ),
                            SizedBox(height: 15),
                            Text(
                              'Logging out...',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );

                // Wait for 2 seconds
                await Future.delayed(Duration(seconds: 2));

                // Dismiss the loading dialog
                Navigator.of(context).pop();

                // Navigate to the login page
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => Screenpages(),
                ));
              },
              child: Text('OK', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(2, 116, 131, 1),
        centerTitle: true, // This will center the title
        title: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            'HealthPlus Pharmacy', // Adjusted title for flexibility
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold, // Bold text for better visibility
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.logout,
              color: Colors.red,
              size: 25.0,
            ),
            onPressed: _showLogoutDialog,
          ),
        ],
      ),

      drawer: CustomDrawer(
          onTap: _onDrawerItemTap), // Pass the _onDrawerItemTap method
      body: _pages[_controller.index], // Display page based on bottom bar index
      bottomNavigationBar: AnimatedNotchBottomBar(
        notchBottomBarController: _controller,
        onTap: (index) {
          setState(() {
            if (index == 0) {
              if (_controller.index != 0) {
                _controller.index = 0;
              }
            } else {
              _controller.index = index.clamp(0, 4);
            }
          });
        },
        kIconSize: 24,
        kBottomRadius: 30,
        notchColor: Color.fromRGBO(2, 116, 131, 1),
        bottomBarItems: [
          BottomBarItem(
            inActiveItem: Icon(Icons.home, color: Colors.black),
            activeItem: Center(
              child: Icon(Icons.home_outlined, color: Colors.white, size: 25),
            ),
            itemLabel: 'Home',
          ),
          BottomBarItem(
            inActiveItem:
                Icon(Icons.production_quantity_limits, color: Colors.black),
            activeItem: Center(
              child: Icon(Icons.production_quantity_limits,
                  color: Colors.white, size: 25),
            ),
            itemLabel: 'Product',
          ),
          BottomBarItem(
            inActiveItem: Icon(Icons.currency_rupee, color: Colors.black),
            activeItem: Center(
              child: Icon(Icons.currency_rupee, color: Colors.white, size: 25),
            ),
            itemLabel: 'Billing',
          ),
          BottomBarItem(
            inActiveItem: Icon(Icons.diversity_3, color: Colors.black),
            activeItem: Center(
              child: Icon(Icons.diversity_3, color: Colors.white, size: 25),
            ),
            itemLabel: 'Staff management',
          ),
          BottomBarItem(
            inActiveItem: Icon(Icons.account_circle, color: Colors.black),
            activeItem: Center(
              child: Icon(Icons.account_circle, color: Colors.white, size: 25),
            ),
            itemLabel: 'Profile',
          ),
        ],
        showLabel: true,
      ),
    );
  }
}
