import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../controllers/db/online/dio_helper.dart';

class CreateAccountScreen extends StatelessWidget {
  CreateAccountScreen({super.key});

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Account"),
      ),
      body: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(controller: nameController),
            TextField(controller: emailController),
            TextField(controller: passController),
            ElevatedButton(
              onPressed: () async {
                try {
                  var response = await DioHelper.dio.post(
                    "https://api.escuelajs.co/api/v1/users",
                    data: {
                      "name": nameController.text,
                      "email": emailController.text,
                      "password": passController.text,
                      "avatar": "https://picsum.photos/800"
                    },
                  );

                  if (response.statusCode == 201) {
                    Navigator.pop(context);
                  }
                } catch (e) {
                  print(e.toString());
                }
              },
              child: const Text("Create"),
            ),
          ],
        ),
      ),
    );
  }
}
