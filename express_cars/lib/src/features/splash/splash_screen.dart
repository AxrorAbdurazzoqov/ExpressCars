import 'dart:async';

import 'package:express_cars/src/core/constants/vectors/app_vectors.dart';
import 'package:express_cars/src/features/navigation/screen/navigation.dart';
import 'package:express_cars/src/features/onboarding/screen/onboarging_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(milliseconds: 1500),
      () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FirebaseAuth.instance.currentUser != null ? const Navigation() : const OnboargingScreen(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Image.asset(
        fit: BoxFit.fill,
        AppVectors.instance.splash,
      ),
    );
  }
}
