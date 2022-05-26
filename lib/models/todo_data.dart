import 'package:flutter/cupertino.dart';
import 'package:hive_exercise/models/user_data.dart';
import 'entities/todo.dart';
import 'user_data.dart';

class TodoData extends ChangeNotifier {
  UserData userModel;
  TodoData(this.userModel);
  List<Todo> _todos = [];
  List<Todo> get todos => _todos;
  
  void getTodoofUser() {
    userModel.activeUser;
  }
}
