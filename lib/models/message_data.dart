import 'package:flutter/material.dart';
import 'package:hive_exercise/box_manager.dart';
import 'package:hive_exercise/models/entities/message.dart';
import 'package:hive_exercise/models/user_data.dart';
import 'entities/user.dart';

class MessageData extends ChangeNotifier {
  final UserData userData;
  MessageData(this.userData);

  List<Message>? _dialog;
  List<Message>? get dialog => _dialog;
  // User? activeUser = userData.activeUser;

  Future<void> sendMessage(String text, User toUser) async {
    await BoxManager.instance.openUserBox();
    final boxMessage = await BoxManager.instance.openMessageBox();
    await BoxManager.instance.openTodoBox(); // ?????
    final activeUser = userData.activeUser;
    if (activeUser == null) return;
    final message = Message(text: text, fromUser: activeUser, toUser: toUser);
    print(message);
    boxMessage.add(message);
    _dialog?.add(message);
    notifyListeners();
  }

  Future<void> showDialog(User toUser) async {
    final boxMessage = await BoxManager.instance.openMessageBox();
    _dialog = boxMessage.values
        .where((dialog) =>
            dialog.fromUser == userData.activeUser && dialog.toUser == toUser)
        .toList();
    notifyListeners();
  }

  Future<List<Message>?> showDialogForFutureBuilder(User toUser) async {
    showDialog(toUser);
    return _dialog;
  }
}
