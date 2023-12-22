import 'package:flutter/material.dart';
import 'package:flutter_application_7/controllers/db/offline/shared_helper.dart';
import 'package:flutter_application_7/controllers/db/online/dio_helper.dart';
import 'package:flutter_application_7/views/splash_screen.dart';

import 'views/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  DioHelper.init();

  await SharedHelper.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
