import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CounterPage extends StatelessWidget {
  CounterPage({super.key});

  final CounterController _controller = Get.put(CounterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("GetX Counter Example"),
      ),
      body: Center(
        child: Obx(() => Text('Count: ${_controller.count}')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _controller.increment,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class CounterController extends GetxController {
  var count = 0.obs;

  void increment() {
    count++;
    update();
  }
}
