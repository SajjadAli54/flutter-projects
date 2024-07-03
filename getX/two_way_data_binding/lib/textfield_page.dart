import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:two_way_data_binding/text_controller.dart';

class TextFieldPage extends StatelessWidget {
  const TextFieldPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TextController());

    return Scaffold(
      appBar: AppBar(title: const Text("Two Way Data Binding")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                onChanged: (value) => controller.updateText(value),
                keyboardType: TextInputType.multiline,
                maxLines: 5,
                decoration: const InputDecoration(
                  labelText: 'Enter Text',
                ),
              ),
              const SizedBox(height: 20),
              Obx(() => Text("Input Text\n\t ${controller.text}"))
            ],
          ),
        ),
      ),
    );
  }
}
