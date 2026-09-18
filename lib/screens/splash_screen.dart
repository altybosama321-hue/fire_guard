import 'package:flutter/material.dart';
import 'package:fire_guard/theme/colors.dart';
import 'package:fire_guard/screens/login_screen.dart';
import 'package:fire_guard/widgets/fire_guard_logo.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 2), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const LoginScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const FireGuardLogo(size: 220),

            const SizedBox(height: 12),

            const Text(
              'Fire Detection and\nAutomatic Suppression System',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                color: Colors.black45,
                height: 1.5,
              ),
            ),

            const SizedBox(height: 36),

            const SizedBox(
              width: 28,
              height: 28,
              child: CircularProgressIndicator(color: red, strokeWidth: 2.8),
            ),
          ],
        ),
      ),
    );
  }
}
