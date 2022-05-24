// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive/hive.dart';
part 'todo.g.dart';

@HiveType(typeId: 1)
class Todo extends HiveObject{
  @HiveField(0)
  String name;
  @HiveField(1)
  String description;
  @HiveField(2)
  DateTime date = DateTime.now();
  @HiveField(3)
  bool isDone = false;

  Todo({
    required this.name,
    required this.description,
    required this.isDone,
  });
  

}
