// ignore_for_file: prefer_final_fields

import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:hive_exercise/box_manager.dart';
import 'package:hive_exercise/models/user_data.dart';
import 'entities/todo.dart';
import 'user_data.dart';

class TodoData extends ChangeNotifier {
  UserData userData;
  TodoData(this.userData);

  List<Todo> _todos = [];
  List<Todo> get todos => _todos;

  List<Todo>? _todosOfActiveUser = [];
  // List<Todo>? get todosOfActiveUser => _todosOfActiveUser;

  Future<void> addSimpleTodo(String name, String description) async {
    final todoBox = await BoxManager.instance.openTodoBox();
    await BoxManager.instance.openUserBox();
    final todo = Todo(name: name, description: description, isDone: false);
    final activeUser = userData.activeUser;
    if (activeUser?.todos?.isEmpty ?? true) {
      activeUser?.todos = HiveList(todoBox);
    }
    todoBox.add(todo);
    _todosOfActiveUser?.add(todo);
    activeUser?.todos?.add(todo);
    activeUser?.save();
    // print('todoBox.values ${todoBox.values}');
    // print('activeUser?.todos ${activeUser?.todos}');
    notifyListeners();
  }

  Future<List<Todo>> getTodoOfActiveUser() async {
    await BoxManager.instance.openUserBox();
    await BoxManager.instance.openTodoBox();
    final activeUser = userData.activeUser;
    // print(activeUser?.todos?.isNotEmpty);
    if (activeUser != null && (activeUser.todos?.isNotEmpty ?? false)) {
      _todosOfActiveUser = activeUser.todos?.toList() as List<Todo>;
      return _todosOfActiveUser ?? [];
    }
    return [];
  }
}
