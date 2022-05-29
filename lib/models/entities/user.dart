// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive/hive.dart';
import 'package:hive_exercise/models/entities/todo.dart';
part 'user.g.dart';

@HiveType(typeId: 0)
class User extends HiveObject {
  @HiveField(0)
  String name;
  @HiveField(1)
  String surname;
  @HiveField(2)
  int birthday;
  @HiveField(3)
  HiveList<User>? friends;
  @HiveField(4)
  HiveList<Todo>? todos;

  static DateTime toDate(int millisecondsSinceEpoch) {
    return DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch);
  }

  @override
  String toString() {
    return '$name $surname $key';
  }

  User({
    required this.name,
    required this.surname,
    required this.birthday,
    this.friends,
    this.todos,
  });

  factory User.toHive({
    required name,
    required surname,
    required DateTime birthdayDateTime,
    friends,
    todos,
  }) {
    return User(
        name: name,
        surname: surname,
        birthday: birthdayDateTime.millisecondsSinceEpoch,
        friends: friends,
        todos: todos);
  }
}
