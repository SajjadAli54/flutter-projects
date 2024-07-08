import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_tasks/app/data/models/task.dart';

class HomeController extends GetxController {
  RxString title = "".obs;
  RxList<Task> tasks = <Task>[].obs;

  final TextEditingController textController = TextEditingController();

  setTitle(title) => this.title.value = title;

  void addTask() {
    int id = tasks.isNotEmpty ? tasks.last.id + 1 : 0;
    tasks.add(Task(id: id, title: title.value, isFavorite: false));

    setTitle("");
    textController.clear();
  }

  void updateTask(id) {
    tasks.value = tasks
        .map((task) => task.id == id
            ? Task(id: id, title: title.value, isFavorite: task.isFavorite)
            : task)
        .toList();

    setTitle("");
    textController.clear();
  }

  void deleteTask(int id) {
    final task = tasks.firstWhere((element) => element.id == id);
    tasks.remove(task);
  }
}
