import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/screen.dart';

class LoadingPage extends StatefulWidget {
  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3), // Duration of the animation
    );

    // Define a tween for vertical movement
    _animation = Tween<double>(begin: 100, end: 0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    // Start the animation
    _animationController.forward();

    // Navigate to the next page after a delay
    _navigateToLandingPages();
  }

  _navigateToLandingPages() async {
    await Future.delayed(Duration(seconds: 9)); // Show loading for 9 seconds
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Screenpages()),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color.fromARGB(255, 247, 243, 211),
      body: Stack(
        children: [
          // Background GIF
          Positioned.fill(
            child: Image.asset(
              'assets/image/evvi.gif', // Path to your GIF
              fit: BoxFit.cover,
            ),
          ),
          // Animated text
          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Positioned(
                bottom: _animation.value,
                left: 0,
                right: 0,
                // top: 10,
                child: Center(
                  child: Text(
                    'Powered by Evvi',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
