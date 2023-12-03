import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moneymanagementapp_flutter/Core/Colors.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Delay for 2 seconds and then navigate to the OnboardingScreen
    Future.delayed(const Duration(seconds: 3), () {
      Get.toNamed('/onboarding');
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: defaultColor,
      body: SafeArea(child: Center(child: Text('mono', style: TextStyle(color: whiteText,fontSize: 50, fontWeight: FontWeight.bold),))),
    );
  }
}
