import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manage_zones/controllers/LoginController.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginController controller = Get.put(LoginController());
    return Scaffold(
        appBar: AppBar(title: const Text("Home Page")),
        body: FutureBuilder(
            future: controller.readToken(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      '${snapshot.error} occurred',
                      style: const TextStyle(fontSize: 18),
                    ),
                  );
                } else {
                  // Extracting data from snapshot object
                  final data = snapshot.data as String;
                  return Center(
                    child: Text(
                      data,
                      style: const TextStyle(fontSize: 18),
                    ),
                  );
                }
              } else {
                return const Text("Loading...");
              }
            }));
  }
}
