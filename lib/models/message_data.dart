import 'package:flutter/material.dart';
import 'package:hive_exercise/services/box_manager.dart';
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

  Future<List<MapEntry<User, Message?>>> getLastMessagesOfFriends() async {
    final boxMessage = await BoxManager.instance.openMessageBox();
    await BoxManager.instance.openUserBox();
    final friends = userData.activeUser?.friends;
    Map<User, Message?> lastMessages = {};
    for (var lastMessage in boxMessage.values) {
      // print(
      //     '|${lastMessage.toUser} ${userData.activeUser}| ${friends != null} ${friends?.contains(lastMessage.toUser)} ${lastMessage.text}');
      if ((friends != null &&
              (friends.contains(lastMessage.toUser)) &&
              (lastMessage.toUser == userData.activeUser) ||
          lastMessage.fromUser == userData.activeUser)) {
        lastMessages[lastMessage.toUser] = lastMessage;
        // print(lastMessages);
      }
    }
    if (friends != null) {
      for (var friend in friends.toList()) {
        if (lastMessages.containsKey(friend) == false) {
          lastMessages[friend] = null;
        }
      }
    }
    List<MapEntry<User, Message?>> sortedLastMessages =
        lastMessages.entries.toList();
    sortedLastMessages.sort((a, b) {
      if (a.value == null) return -1;
      if (b.value == null) return -1;
      return b.value!.createDate.compareTo(a.value!.createDate);
    });
    return sortedLastMessages;
  }

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
