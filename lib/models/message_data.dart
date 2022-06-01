import 'package:flutter/material.dart';
import 'package:hive_exercise/box_manager.dart';
import 'package:hive_exercise/models/entities/message.dart';
import 'package:hive_exercise/models/user_data.dart';
import 'entities/user.dart';

class MessageData extends ChangeNotifier {
  final UserData userData;
  MessageData(this.userData);

  List<Message> _activeDialog = [];
  // List<Message> get activeDialog => _activeDialog;

  // Map<User, List<Message>>? _dialogs;
  // Map<User, List<Message>>? get dialogs => _dialogs;

  static String dateMessage(Message? message) {
    if (message == null) return '';
    final date = DateTime.fromMillisecondsSinceEpoch(message.createDate);
    return '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }

  Future<Message> sendMessage(String text, User toUser) async {
    await BoxManager.instance.openUserBox();
    final boxMessage = await BoxManager.instance.openMessageBox();
    await BoxManager.instance.openTodoBox();
    final activeUser = userData.activeUser;
    final message = Message(text: text, fromUser: activeUser!, toUser: toUser);
    boxMessage.add(message);
    // _activeDialog.add(message);
    // _dialogs?[toUser]?.add(message);
    notifyListeners();
    return message;
  }

  // Future<void> showDialogsForMessengerList() async {
  //   final boxMessage = await BoxManager.instance.openMessageBox();
  //   await BoxManager.instance.openUserBox(); // ???
  //   // final friends = userData.activeUser?.friends;
  //   final friends = userData.activeUser?.friends;
  //   List<Message> temp = [];
  //   for (var message in boxMessage.values) {
  //     if (friends != null &&
  //         message.fromUser == userData.activeUser &&
  //         friends.contains(message.toUser)) {
  //       // print('${message.toUser} ------- $message');
  //       // _dialogs?[message.toUser]?.add(message);
  //       temp.add(message);
  //       // print(temp);
  //       _dialogs?[message.toUser] = temp;
  //     }
  //   }
  //   // print(_dialogs);
  // }

  Future<List<Message>> showActiveDialog(User toUser) async {
    final boxMessage = await BoxManager.instance.openMessageBox();
    _activeDialog = boxMessage.values
        .where((dialog) =>
            (dialog.fromUser == userData.activeUser &&
                dialog.toUser == toUser) ||
            (dialog.fromUser == toUser && dialog.toUser == userData.activeUser))
        .toList();
    return _activeDialog;
  }


  Future<bool> deleteMessage(Message message) async {
    await BoxManager.instance.openMessageBox();
    try {
      message.delete();
      notifyListeners();
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }
}
