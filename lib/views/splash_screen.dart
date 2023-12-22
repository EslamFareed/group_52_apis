import 'package:flutter/material.dart';
import 'package:flutter_application_7/controllers/db/offline/shared_helper.dart';
import 'package:flutter_application_7/views/home_screen.dart';
import 'package:flutter_application_7/views/login_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => SharedHelper.prefs.getBool("isLogin") ?? false
              ? HomeScreen()
              : LoginScreen(),
        ),
      );
    });
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
