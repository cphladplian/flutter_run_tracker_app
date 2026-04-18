import 'package:flutter/material.dart';
import 'package:flutter_run_tracker_app/views/show_all_run_ui.dart';

class SplashScreenUi extends StatefulWidget {
  const SplashScreenUi({super.key});

  @override
  State<SplashScreenUi> createState() => _SplashScreenUiState();
}

class _SplashScreenUiState extends State<SplashScreenUi> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ShowAllRunUi()),
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF090359),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/icon/tracker.png',
              height: 150,
              width: 150,
            ),
            SizedBox(height: 20),
            Text(
              'Run Tracker',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(40),      
        child: Text(
          '© 2026 RUN TRACKER\nCreated by Chatinon',
          style: TextStyle(
            color: const Color.fromARGB(129, 231, 230, 230),
            fontSize: 12,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}