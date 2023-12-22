import 'package:flutter/material.dart';
import 'package:flutter_application_7/controllers/db/offline/shared_helper.dart';
import 'package:flutter_application_7/controllers/db/online/dio_helper.dart';
import 'package:flutter_application_7/views/create_account_screen.dart';
import 'package:flutter_application_7/views/home_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final emailController = TextEditingController();
  final passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(controller: emailController),
            TextField(controller: passController),
            ElevatedButton(
              onPressed: () async {
                var response = await DioHelper.dio.post(
                  "https://api.escuelajs.co/api/v1/auth/login",
                  data: {
                    "email": emailController.text,
                    "password": passController.text,
                  },
                );

                if (response.statusCode == 201) {
                  await SharedHelper.prefs.setBool("isLogin", true);
                  await SharedHelper.prefs
                      .setString("token", response.data["access_token"]);
                  Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (_) => HomeScreen()));
                }
              },
              child: const Text("Login"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => CreateAccountScreen()));
              },
              child: Text("create"),
            )
          ],
        ),
      ),
    );
  }


}
