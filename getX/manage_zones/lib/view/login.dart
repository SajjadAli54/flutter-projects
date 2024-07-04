import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manage_zones/controllers/LoginController.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginController controller = Get.put(LoginController());

    onLoginClick(BuildContext context) async {
      await controller.login();
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Login Page")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            keyboardType: TextInputType.name,
            decoration: const InputDecoration(labelText: "Username"),
            onChanged: (value) => controller.setUsername(value),
          ),
          const SizedBox(height: 20),
          TextField(
            keyboardType: TextInputType.visiblePassword,
            decoration: const InputDecoration(labelText: "Password"),
            onChanged: (value) => controller.setPassword(value),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
              onPressed: () => onLoginClick(context),
              child: const Text("Login"))
        ],
      ),
    );
  }
}
