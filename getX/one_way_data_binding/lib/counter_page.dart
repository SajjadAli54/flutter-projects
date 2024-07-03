import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one_way_data_binding/counter_controller.dart';

class CounterPage extends StatelessWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final CounterController controller = Get.put(CounterController());
    return Scaffold(
        appBar: AppBar(title: const Text('One-Way Binding')),
        body: Center(
          child: Obx(() => Text("Count: ${controller.count}")),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: controller.increment,
          child: const Icon(Icons.add),
        ));
  }
}
