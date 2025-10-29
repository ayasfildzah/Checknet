import 'package:flutter/material.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToLogin();
  }

  _navigateToLogin() async {
    await Future.delayed(const Duration(seconds: 3), () {});
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/bgrnet.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo with Wi-Fi signal lines
              Container(
                width: 200,
                height: 120,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/logornnet.png'),
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              // Wi-Fi signal lines
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildSignalLine(20),
                  const SizedBox(width: 8),
                  _buildSignalLine(30),
                  const SizedBox(width: 8),
                  _buildSignalLine(40),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                'Internet Connection',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 10),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  'We provide the best internet service to home or grow up your business',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: Color(0x8766056D)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSignalLine(double height) {
    return Container(
      width: 4,
      height: height,
      decoration: BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }
}
