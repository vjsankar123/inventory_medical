import 'package:flutter/material.dart';
import 'package:flutter_application_1/dashboard/persistent_bottom_nav_bar.dart';

void main() {
  runApp(const ProfilePage());
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ShopDetailsScreen(),
    );
  }
}

class ShopDetailsScreen extends StatefulWidget {
  @override
  _ShopDetailsScreenState createState() => _ShopDetailsScreenState();
}

class _ShopDetailsScreenState extends State<ShopDetailsScreen> {
  String shopName = "HealthPlus Pharmacy";
  String gstNumber = "29ABCDE1234F2Z5";
  String address = "123, Main Street, City Center";
  String pinCode = "560001";
  String phoneNumber = "+91 9876543210";
  bool isGovernmentRegistered = true;

  void _updateShopDetails({
    required String updatedShopName,
    required String updatedGstNumber,
    required String updatedAddress,
    required String updatedPinCode,
    required String updatedPhoneNumber,
    required bool updatedIsGovernmentRegistered,
  }) {
    setState(() {
      shopName = updatedShopName;
      gstNumber = updatedGstNumber;
      address = updatedAddress;
      pinCode = updatedPinCode;
      phoneNumber = updatedPhoneNumber;
      isGovernmentRegistered = updatedIsGovernmentRegistered;
    });
  }

  // Function to show the delete confirmation dialog
  void _showDeleteConfirmationDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text('Delete Shop'),
          content: Text('Are you sure you want to delete this shop details?'),
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
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                // Handle the delete action here
                // For example, navigate back or show a snackbar confirming deletion
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Shop details deleted successfully')),
                );
                // You can also navigate to a different screen if required
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => PersistentBottomNavBar(),
                ));
              },
              child: Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => PersistentBottomNavBar(),
        ));
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Shop Details",
            style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
                color: Colors.black),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          // elevation: 4.0,
        ),
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(color: Colors.black, width: 2.0),
                ),
                color: Colors.white,
                elevation: 5.0,
                margin: const EdgeInsets.only(bottom: 16.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border(
                      top: BorderSide(color: Colors.black, width: 2.0),
                      left: BorderSide(color: Colors.black, width: 2.0),
                      right: BorderSide(color: Colors.black, width: 2.0),
                      bottom: BorderSide(color: Colors.black, width: 5.0),
                    ),
                  ),
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      detailRow("Shop Name", shopName, isHeader: true),
                      const SizedBox(height: 12.0),
                      const Divider(),
                      const SizedBox(height: 12.0),
                      detailRow("GST Number", gstNumber),
                      const SizedBox(height: 12.0),
                      detailRow("Address", address),
                      const SizedBox(height: 12.0),
                      detailRow("PIN", pinCode),
                      const SizedBox(height: 12.0),
                      detailRow("Phone Number", phoneNumber),
                      const SizedBox(height: 12.0),
                      detailRow(
                        "Government Registered",
                        isGovernmentRegistered ? "Yes" : "No",
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      showModalBottomSheet(
                        backgroundColor: Colors.white,
                        context: context,
                        isScrollControlled: true,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20.0),
                          ),
                        ),
                        builder: (context) {
                          return EditShopForm(
                            shopName: shopName,
                            gstNumber: gstNumber,
                            address: address,
                            pinCode: pinCode,
                            phoneNumber: phoneNumber,
                            isGovernmentRegistered: isGovernmentRegistered,
                            onSave: _updateShopDetails,
                          );
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: 24.0),
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    icon: const Icon(Icons.edit, color: Colors.white),
                    label: const Text(
                      "Edit",
                      style: TextStyle(color: Colors.white, fontSize: 16.0),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed:
                        _showDeleteConfirmationDialog, // Call the delete confirmation dialog
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: 24.0),
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    icon: const Icon(Icons.delete, color: Colors.white),
                    label: const Text(
                      "Delete",
                      style: TextStyle(color: Colors.white, fontSize: 16.0),
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

  Widget detailRow(String label, String value, {bool isHeader = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$label:",
            style: TextStyle(
              fontWeight: isHeader ? FontWeight.bold : FontWeight.w600,
              fontSize: isHeader ? 18.0 : 16.0,
              color: isHeader ? Colors.black : Colors.black87,
            ),
          ),
          const SizedBox(width: 8.0),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: isHeader ? 18.0 : 16.0,
                fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
                color: isHeader ? Color(0xFF028090) : Colors.black54,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class EditShopForm extends StatefulWidget {
  final String shopName;
  final String gstNumber;
  final String address;
  final String pinCode;
  final String phoneNumber;
  final bool isGovernmentRegistered;
  final Function({
    required String updatedShopName,
    required String updatedGstNumber,
    required String updatedAddress,
    required String updatedPinCode,
    required String updatedPhoneNumber,
    required bool updatedIsGovernmentRegistered,
  }) onSave;

  const EditShopForm({
    super.key,
    required this.shopName,
    required this.gstNumber,
    required this.address,
    required this.pinCode,
    required this.phoneNumber,
    required this.isGovernmentRegistered,
    required this.onSave,
  });

  @override
  _EditShopFormState createState() => _EditShopFormState();
}

class _EditShopFormState extends State<EditShopForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController shopNameController;
  late TextEditingController gstNumberController;
  late TextEditingController addressController;
  late TextEditingController pinCodeController;
  late TextEditingController phoneNumberController;
  late bool isGovernmentRegistered;

  @override
  void initState() {
    super.initState();
    shopNameController = TextEditingController(text: widget.shopName);
    gstNumberController = TextEditingController(text: widget.gstNumber);
    addressController = TextEditingController(text: widget.address);
    pinCodeController = TextEditingController(text: widget.pinCode);
    phoneNumberController = TextEditingController(text: widget.phoneNumber);
    isGovernmentRegistered = widget.isGovernmentRegistered;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16.0,
        right: 16.0,
        top: 16.0,
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Form(
        key: _formKey,
        child: ListView(
          shrinkWrap: true,
          children: [
            const Text(
              "Edit Shop Details",
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16.0),
            buildTextField("Shop Name", shopNameController),
            buildTextField("GST Number", gstNumberController),
            buildTextField("Address", addressController),
            buildTextField("PIN Code", pinCodeController),
            buildTextField("Phone Number", phoneNumberController),
            const SizedBox(height: 16.0),
            DropdownButtonFormField<bool>(
              value: isGovernmentRegistered,
              decoration: InputDecoration(
                labelText: "Government Registered",
                labelStyle: const TextStyle(
                  color: Colors.black,
                ),
                floatingLabelStyle: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: const BorderSide(
                    color: Color(0xFF028090),
                    width: 2.0,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: const BorderSide(
                    color: Color(0xFF028090),
                    width: 2.0,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: const BorderSide(
                    color: Colors.black38,
                    width: 1.0,
                  ),
                ),
              ),
              items: const [
                DropdownMenuItem(
                  value: true,
                  child: Text("Yes"),
                ),
                DropdownMenuItem(
                  value: false,
                  child: Text("No"),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  isGovernmentRegistered = value!;
                });
              },
              dropdownColor: Colors.white,
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  widget.onSave(
                    updatedShopName: shopNameController.text,
                    updatedGstNumber: gstNumberController.text,
                    updatedAddress: addressController.text,
                    updatedPinCode: pinCodeController.text,
                    updatedPhoneNumber: phoneNumberController.text,
                    updatedIsGovernmentRegistered: isGovernmentRegistered,
                  );
                  Navigator.pop(context);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              child: const Text(
                'Save',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(
            color: Colors.black,
          ),
          floatingLabelStyle: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: const BorderSide(
              color: Color(0xFF028090),
              width: 2.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: const BorderSide(
              color: Color(0xFF028090),
              width: 2.0,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: const BorderSide(
              color: Colors.black38,
              width: 1.0,
            ),
          ),
        ),
        cursorColor: const Color(0xFF028090),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "$label cannot be empty";
          }
          return null;
        },
      ),
    );
  }
}
