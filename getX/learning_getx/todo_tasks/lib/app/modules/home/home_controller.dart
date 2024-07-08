import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_tasks/app/data/models/task.dart';

class HomeController extends GetxController {
  RxString title = "".obs;
  RxList<Task> tasks = <Task>[].obs;

  final TextEditingController textController = TextEditingController();

  setTitle(title) => this.title.value = title;

  add() {
    int id = tasks.isNotEmpty ? tasks.last.id + 1 : 0;
    tasks.add(Task(id: id, title: title.value));

    textController.clear();
  }

  delete(int id) {
    final task = tasks.firstWhere((element) => element.id == id);
    tasks.remove(task);
  }
}
