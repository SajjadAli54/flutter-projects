import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'home_controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomePage'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: controller.setTitle,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(labelText: "Enter Title"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                onPressed: controller.add, child: const Text("Add")),
          ),
          const SizedBox(height: 20),
          Obx(() => Text("${controller.title}"))
        ],
      ),
    );
  }
}
