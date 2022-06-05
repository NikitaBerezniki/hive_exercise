// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

import 'user.dart';

part 'todo.g.dart';

@HiveType(typeId: 1)
class Todo extends HiveObject {
  @HiveField(0)
  String? name;
  @HiveField(1)
  String? description;
  @HiveField(2)
  bool? isDone;
  @HiveField(3)
  Map<String, bool>? listOfIssues;
  @HiveField(4)
  int dateCreate = DateTime.now().millisecondsSinceEpoch;
  @HiveField(5)
  int? startTime;
  @HiveField(6)
  int? finishTime;
  @HiveField(7)
  int? deadlineForCompletion;
  @HiveField(8)
  HiveList<Todo>? subtasks;
  @HiveField(9)
  HiveList<User>? responsibleUsers;
  @HiveField(10)
  int? priority;
  // @HiveField(11)
  // int? whenToRepeat; // надо ли повторить к какому времени
  // @HiveField(12)
  // List<int>? notifications; // Список будильников для уведомлений
  // @HiveField(13)
  // int? color;
  // =>>> Groups, Files
  @override
  String toString() {
    return '$name $description';
  }

  Todo({
    this.name,
    this.description,
    this.isDone,
    this.listOfIssues,
    this.startTime,
    this.finishTime,
    this.deadlineForCompletion,
    this.subtasks,
    this.responsibleUsers,
    this.priority,
  });

  static String dateMessage(Todo? todo) {
    if (todo == null) return '';
    final date = DateTime.fromMillisecondsSinceEpoch(todo.dateCreate);
    return '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Todo &&
        other.name == name &&
        other.description == description &&
        other.isDone == isDone &&
        mapEquals(other.listOfIssues, listOfIssues) &&
        other.dateCreate == dateCreate &&
        other.startTime == startTime &&
        other.finishTime == finishTime &&
        other.deadlineForCompletion == deadlineForCompletion &&
        other.subtasks == subtasks &&
        other.responsibleUsers == responsibleUsers &&
        other.priority == priority;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        description.hashCode ^
        isDone.hashCode ^
        listOfIssues.hashCode ^
        dateCreate.hashCode ^
        startTime.hashCode ^
        finishTime.hashCode ^
        deadlineForCompletion.hashCode ^
        subtasks.hashCode ^
        responsibleUsers.hashCode ^
        priority.hashCode;
  }
}
