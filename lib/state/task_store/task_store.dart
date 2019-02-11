import 'dart:async';

import 'package:mobx/mobx.dart';
import 'package:todo/models/task.dart';
import 'package:todo/provider/task_provider.dart';
import 'package:uuid/uuid.dart';

part 'task_store.g.dart';

class TaskStore = TaskStoreBase with _$TaskStore;

abstract class TaskStoreBase implements Store {
  @observable
  List<Task> tasks = new List();
  final TaskProvider _taskProvider = new TaskProvider();
  @observable
  String enteredText = "";

  @action
  Future<void> fetchTasks() async {
    await _taskProvider.open();
    tasks= await _taskProvider.getAllTasks();
  } 

  @action
  void onTextChanged(String text) {
    enteredText = text;
  }

  @action
  Future<void> onAddClicked() async {
    if(enteredText.isNotEmpty) {
      Task createdTask = Task(Uuid().v4(), enteredText, new DateTime.now().millisecondsSinceEpoch);
      await _taskProvider.open();
      await _taskProvider.insertTask(createdTask);
      await fetchTasks();
      enteredText = "";
    }
  }

  @action
  Future<void> deleteItem(String itemId) async {
    await _taskProvider.open();
    await _taskProvider.deleteTask(itemId);
    await fetchTasks();
  }

}