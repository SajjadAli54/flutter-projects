import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manage_zones/controllers/LoginController.dart';
import 'package:manage_zones/view/home.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginController controller = Get.put(LoginController());

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
              onPressed: () async => {
                    controller.login(),
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomePage())),
                  },
              child: const Text("Login")),
          Obx(() => Text("${controller.body}"))
        ],
      ),
    );
  }
}
