// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TodoAdapter extends TypeAdapter<Todo> {
  @override
  final int typeId = 1;

  @override
  Todo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Todo(
      name: fields[0] as String?,
      description: fields[1] as String?,
      isDone: fields[2] as bool?,
      listOfIssues: (fields[3] as Map?)?.cast<String, bool>(),
      startTime: fields[5] as int?,
      finishTime: fields[6] as int?,
      deadlineForCompletion: fields[7] as int?,
      subtasks: (fields[8] as HiveList?)?.castHiveList(),
      responsibleUsers: (fields[9] as HiveList?)?.castHiveList(),
      priority: fields[10] as int?,
    )..dateCreate = fields[4] as int;
  }

  @override
  void write(BinaryWriter writer, Todo obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.isDone)
      ..writeByte(3)
      ..write(obj.listOfIssues)
      ..writeByte(4)
      ..write(obj.dateCreate)
      ..writeByte(5)
      ..write(obj.startTime)
      ..writeByte(6)
      ..write(obj.finishTime)
      ..writeByte(7)
      ..write(obj.deadlineForCompletion)
      ..writeByte(8)
      ..write(obj.subtasks)
      ..writeByte(9)
      ..write(obj.responsibleUsers)
      ..writeByte(10)
      ..write(obj.priority);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TodoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
