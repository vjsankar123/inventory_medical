import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter_application_1/dashboard/persistent_bottom_nav_bar.dart';

void main() {
  runApp(Screenpages());
}

class Screenpages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: BackgroundWithGif(),
      ),
    );
  }
}

class BackgroundWithGif extends StatefulWidget {
  @override
  _BackgroundWithGifState createState() => _BackgroundWithGifState();
}

class _BackgroundWithGifState extends State<BackgroundWithGif> {
  bool _isNewPasswordVisible = false;
  String? _selectedRole;
  bool _isLoading = false;
  String _message = '';
  late ConfettiController _confettiController;
  bool _hasConfettiFired = false;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: Duration(seconds: 3));
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  Future<void> _attemptLogin() async {
    setState(() {
      _isLoading = true;
      _message = ''; // Clear previous messages
    });

    // Simulate network delay
    await Future.delayed(Duration(seconds: 2));

    // Dummy logic for success or failure
    bool isSuccess = _selectedRole == 'Admin' && _isNewPasswordVisible;

    setState(() {
      _isLoading = false;
      if (isSuccess) {
        _message = 'Login Successful';

        // Trigger confetti before navigation
        if (!_hasConfettiFired) {
          _confettiController.play();
          _hasConfettiFired = true; // Set the flag to true to prevent firing again
        }

        // Navigate to the Dashboard page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => PersistentBottomNavBar()),
        );
      } else {
        _message = 'Login Failed. Try again.';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Return true to allow the app to close
        return true;
      },
      child: Stack(
        children: [
          // GIF Background
          Positioned.fill(
            child: Image.asset(
              'assets/image/medical.gif',
              fit: BoxFit.cover,
            ),
          ),
          // Blur Area in a Specific Box
          Center(
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10), // Adjust blur intensity
                child: SingleChildScrollView(
                  child: Container(
                    width: 350, // Set your box width
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 1), // Optional border
                      borderRadius: BorderRadius.circular(10), // Rounded corners
                    ),
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          RichText(
                            text: TextSpan(
                              text: 'WELCOME BACK!',
                              style: TextStyle(
                                fontSize: 25,
                                color: Color(0xFF028090),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          RichText(
                            text: TextSpan(
                              text: 'Login to your account',
                              style: TextStyle(
                                fontSize: 15,
                                color: Color(0xFF028090),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          DropdownButtonFormField<String>(
                            value: _selectedRole,
                            items: [
                              DropdownMenuItem(
                                value: 'Admin',
                                child: Text('Admin'),
                              ),
                              DropdownMenuItem(
                                value: 'Staff',
                                child: Text('Staff'),
                              ),
                            ],
                            onChanged: (value) {
                              setState(() {
                                _selectedRole = value;
                              });
                            },
                            dropdownColor: Colors.white,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: Color(0xFF028090), width: 2.0),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 18, horizontal: 16),
                              hintText: 'Select Role',
                              prefixIcon: Icon(
                                Icons.person,
                                color: Colors.grey,
                                size: 20,
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            cursorColor: Color(0xFF028090),
                            decoration: InputDecoration(
                              hintText: 'Email',
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: Color(0xFF028090), width: 2.0),
                              ),
                              prefixIcon: Icon(Icons.email,
                                  color: Colors.grey, size: 20),
                            ),
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            obscureText: !_isNewPasswordVisible,
                            cursorColor: Color(0xFF028090),
                            decoration: InputDecoration(
                              hintText: 'Password',
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: Color(0xFF028090), width: 2.0),
                              ),
                              prefixIcon: Icon(Icons.lock,
                                  color: Colors.grey, size: 20),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _isNewPasswordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Color(0xFF028090),
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isNewPasswordVisible =
                                        !_isNewPasswordVisible;
                                  });
                                },
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            child: ElevatedButton(
                              onPressed: () async {
                                await _attemptLogin();
                              },
                              child: _isLoading
                                  ? CircularProgressIndicator(color: Colors.white)
                                  : Text(
                                      'Login',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                              style: ElevatedButton.styleFrom(
                                elevation: 20,
                                foregroundColor: Colors.white, // Button text color
                                backgroundColor: Color(0xFF028090),
                                padding: EdgeInsets.symmetric(
                                    vertical: 12.0, horizontal: 70.0),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          if (_message.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                _message,
                                style: TextStyle(
                                  fontSize: 20,
                                  color: _message == 'Login Successful'
                                      ? Colors.green
                                      : Colors.red,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'poppins',
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
