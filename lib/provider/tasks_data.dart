import 'dart:collection';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/database/shared_preferences.dart';
import 'package:todo_app/models/tasks.dart';

class TaskData with ChangeNotifier {
  List<Task> _tasks = [
    // Task(name: 'Buy milk'),
    // Task(name: 'Buy eggs'),
    // Task(name: 'Buy bread'),
  ];
  SharedPreferences? sharedPreferences;

  UnmodifiableListView<Task> get tasks {
    return UnmodifiableListView(_tasks);
  }

  int get taskCount {
    return _tasks.length;
  }

  Future<void> addTask(String id, String title, String note, bool isCompleted,
      String date, String startTime, String endTime, int color) async {
    final task = Task(
        id: id,
        title: title,
        note: note,
        isCompleted: isCompleted,
        date: date,
        startTime: startTime,
        endTime: endTime,
        color: color);
    _tasks.add(task);
    saveDataToLocalStorage();
    notifyListeners();
  }

  Future<void> updateTask(Task task) async {
    var tasks = task.update();
    saveDataToLocalStorage();
    notifyListeners();
  }

  void removeTask(String id) async {
    _tasks.removeWhere((element) => element.id == id);
    removeDataToLocalStorage();
    // _tasks.remove(task);
    notifyListeners();
  }

  // SP Methods
  void initSharedPreferences() async {
    await SharedPreferencesHelper.init();
    sharedPreferences = SharedPreferencesHelper.instance;
    loadDataFromLocalStorage();
    notifyListeners();
  }

  void saveDataToLocalStorage() {
    List<String>? spList = _tasks.map((e) => json.encode(e.toMap())).toList();
    sharedPreferences!.setStringList('tasks', spList);
  }

  void updateDataToLocalStorage() {
    sharedPreferences!.getString('task');
  }

  void loadDataFromLocalStorage() {
    List<String>? spList = sharedPreferences!.getStringList('tasks');
    if (spList != null) {
      _tasks = spList.map((e) => Task.fromMap(json.decode(e))).toList();
    }
  }

  void removeDataToLocalStorage() {
    sharedPreferences!.remove('tasks');
    saveDataToLocalStorage();
  }
}
