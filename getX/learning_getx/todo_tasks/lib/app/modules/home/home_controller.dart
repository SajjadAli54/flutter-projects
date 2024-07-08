import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_tasks/app/data/models/task.dart';
import 'package:todo_tasks/app/data/repositories/database.dart';

class HomeController extends GetxController {
  RxString title = "".obs;
  RxList<Task> tasks = <Task>[].obs;

  final TextEditingController textController = TextEditingController();

  final _database = DatabaseHelper.instance;

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    tasks.value = await _database.readAll();
  }

  void setTitle(title) => this.title.value = title;

  void addTask() async {
    if (title.isEmpty) return;

    var task = await _database
        .upsert(Task(id: -1, title: title.value, isFavorite: false));
    tasks.add(task);

    setTitle("");
    textController.clear();
  }

  void updateTask(id) {
    if (title.isEmpty) return;

    var task = tasks.firstWhere((element) => element.id == id);
    task.title = title.value;
    // tasks.value = tasks
    //     .map((task) => task.id == id
    //         ? Task(id: id, title: title.value, isFavorite: task.isFavorite)
    //         : task)
    //     .toList();

    setTitle("");
    textController.clear();
  }

  void setFavoriteTask(id) {
    tasks.value = tasks
        .map((task) => task.id == id
            ? Task(id: id, title: task.title, isFavorite: !task.isFavorite)
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
