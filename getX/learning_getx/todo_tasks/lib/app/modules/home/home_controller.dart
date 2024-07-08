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
    super.onInit();
    tasks.value = await _database.readAll();
  }

  void setTitle(title) => this.title.value = title;

  Future<void> addTask() async {
    if (title.isEmpty) return;

    var task = await _database
        .upsert(Task(id: -1, title: title.value, isFavorite: false));
    tasks.add(task);

    setTitle("");
    textController.clear();
  }

  Future<void> updateTask(id) async {
    if (title.isEmpty) return;

    var task = tasks.firstWhere((element) => element.id == id);
    task.title = title.value;
    _update(task);
  }

  void setFavoriteTask(id) {
    var task = tasks.firstWhere((task) => task.id == id);
    task.isFavorite = !task.isFavorite;
    _update(task);
  }

  void _update(Task task) async {
    tasks.value = tasks.map((ele) => ele.id == task.id ? task : ele).toList();

    await _database.upsert(task);
    setTitle("");
    textController.clear();
  }

  void deleteTask(int id) {
    final task = tasks.firstWhere((element) => element.id == id);
    tasks.remove(task);

    _database.delete(id);
  }
}
