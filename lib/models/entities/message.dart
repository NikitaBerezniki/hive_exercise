// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive/hive.dart';
import 'package:hive_exercise/models/entities/user.dart';
part 'message.g.dart';

@HiveType(typeId: 2)
class Message extends HiveObject {
  @HiveField(0)
  String text;
  @HiveField(1)
  User fromUser;
  @HiveField(2)
  User toUser;
  @HiveField(3)
  int createDate = DateTime.now().millisecondsSinceEpoch;
  @HiveField(4)
  Message? replyOfMessage;
  // @HiveField(5)
  // HiveList<Group>? group;

  @override
  String toString() {
    return 'text $text. fromUser: $fromUser toUser: $toUser. createDate ${createDate}';
  }

  Message({
    required this.text,
    required this.fromUser,
    required this.toUser,
    this.replyOfMessage,
    // this.group,
  });
}
