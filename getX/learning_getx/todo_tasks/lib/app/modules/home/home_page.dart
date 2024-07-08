import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'home_controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(fontSize: 20);
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
              controller: controller.textController,
              onChanged: controller.setTitle,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                  labelText:
                      "Enter Title and then click add or task's edit button"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                onPressed: controller.addTask,
                child: const Text("Add", style: textStyle)),
          ),
          const SizedBox(height: 20),
          Obx(() => Column(
                children: controller.tasks
                    .map((task) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                task.title,
                                style: textStyle,
                              ),
                              Row(
                                children: [
                                  ElevatedButton(
                                      onPressed: () =>
                                          controller.setFavoriteTask(task.id),
                                      child: Icon(
                                        task.isFavorite
                                            ? Icons.favorite_sharp
                                            : Icons.favorite_outline_sharp,
                                        color: Colors.yellow,
                                      )),
                                  const SizedBox(width: 10),
                                  ElevatedButton(
                                      onPressed: () =>
                                          controller.updateTask(task.id),
                                      child: const Icon(
                                        Icons.edit,
                                        color: Colors.green,
                                      )),
                                  const SizedBox(width: 10),
                                  ElevatedButton(
                                      onPressed: () =>
                                          controller.deleteTask(task.id),
                                      child: const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ))
                                ],
                              ),
                            ],
                          ),
                        ))
                    .toList(),
              ))
        ],
      ),
    );
  }
}
