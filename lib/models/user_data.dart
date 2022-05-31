import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_exercise/box_manager.dart';
import 'package:hive_exercise/models/entities/user.dart';

class UserData extends ChangeNotifier {
  List<User> _users = [];
  List<User> get users => _users;

  User? _activeUser;
  User? get activeUser => _activeUser;

  // List<User>? _acquaintancesOfActiveUser;
  // List<User>? get acquaintancesOfActiveUser => _acquaintancesOfActiveUser;

  void setActiveUser(User selectedUser) {
    _activeUser = selectedUser;
    notifyListeners();
  }



  Future<void> getUsers() async {
    final Box<User> userBox = await BoxManager.instance.openUserBox();
    _users = userBox.values.toList();
    notifyListeners();
  }

  Future<void> addUser(String name, String surname) async {
    final Box<User> userBox = await BoxManager.instance.openUserBox();
    final user = User.toHive(
        name: name, surname: surname, birthdayDateTime: DateTime.now());
    userBox.add(user);
    _users = userBox.values.toList();
    notifyListeners();
  }

  Future<void> deleteUser(int key) async {
    final Box<User> userBox = await BoxManager.instance.openUserBox();
    userBox.delete(key);
    _users = userBox.values.toList();
    notifyListeners();
  }

  List<User>? searchForAcquaintances() {
    // Поиск потенциальных друзей
    if (activeUser != null) {
      // await BoxManager.instance.openUserBox();
      return _users
          .where((findFriend) =>
              findFriend != activeUser &&
              !(activeUser?.friends?.contains(findFriend) ?? false))
          .toList();
    }
    return null;
  }

  Future<void> addFriend(User user, User friend) async {
    await BoxManager.instance.openUserBox();
    await BoxManager.instance.openTodoBox();
    void _add(User _user, User _friend) {
      if (_user.friends?.isEmpty ?? true) {
        _user.friends = HiveList(_user.box as Box<User>);
      }
      _user.friends?.add(_friend);
      _user.save();
    }

    _add(user, friend);
    _add(friend, user);
    notifyListeners();
  }

  Future<void> deleteFromFriends(int index) async {
    await BoxManager.instance.openUserBox();
    await BoxManager.instance.openTodoBox();
    User? formerFriend; // Бывший друг
    activeUser?.friends?.removeWhere((element) {
      if (element.key == index) {
        formerFriend = element;
        return true;
      }
      return false;
    });
    activeUser?.save();
    formerFriend?.friends?.remove(activeUser);
    formerFriend?.save();
    notifyListeners();
  }
}
