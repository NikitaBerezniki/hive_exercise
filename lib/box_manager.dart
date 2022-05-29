import 'package:hive/hive.dart';
import 'package:hive_exercise/models/entities/message.dart';
import 'models/entities/user.dart';
import 'models/entities/todo.dart';

class BoxManager {
  static final BoxManager instance = BoxManager._();
  BoxManager._();

  Future<Box<Message>> openMessageBox() async {
    return _openBox('message', 2, MessageAdapter());
  }

  Future<Box<User>> openUserBox() async {
    return _openBox('user', 0, UserAdapter());
  }

  Future<Box<Todo>> openTodoBox() async {
    return _openBox('todo', 1, TodoAdapter());
  }

  Future<Box<T>> _openBox<T>(
      String name, int typeId, TypeAdapter<T> adapter) async {
    if (!Hive.isAdapterRegistered(typeId)) {
      Hive.registerAdapter(adapter);
    }
    if (!Hive.isBoxOpen(name)) return Hive.openBox<T>(name);
    return Hive.box<T>(name);
  }
}
