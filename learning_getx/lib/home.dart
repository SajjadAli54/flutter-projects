import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'counter.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    var text = "hello".tr;
    return Scaffold(
      appBar: AppBar(title: Text("GetX Learning $text")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: ElevatedButton(
              onPressed: () {
                Get.to(CounterPage());
              },
              child: const Text("Counter"),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Get.snackbar("Title", "This is the message");
            },
            child: const Text("Snackbar"),
          ),
          ElevatedButton(
            onPressed: () {
              Get.defaultDialog(title: "I am a dialog");
            },
            child: const Text("Dialog"),
          ),
          ElevatedButton(
            onPressed: () {},
            child: const Text("GetView"),
          )
        ],
      ),
    );
  }
}
