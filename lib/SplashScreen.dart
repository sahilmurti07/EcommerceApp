import 'package:flutter/material.dart';
import 'package:flutter_application_1/representation/pages/HomeMain.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => Homemain()), // Go to Nav Layout
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.asset(
          "assets/animations/Shopping cart.json",
          width: 400,
          height: 300,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
