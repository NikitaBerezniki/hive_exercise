import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_exercise/box_manager.dart';
import 'package:hive_exercise/models/entities/user.dart';

class UserData extends ChangeNotifier {
  List<User> _users = [];
  List<User> get users => _users;

  User? _activeUser;
  User? get activeUser => _activeUser;

  void setActiveUser(User selectedUser) {
    _activeUser = selectedUser;
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

  void addFriends(User user, User friend) {
    user.friends = HiveList(user.box as Box<User>);
    user.friends?.add(friend);
    user.save();
    friend.friends = HiveList(friend.box as Box<User>);
    friend.friends?.add(user);
    friend.save();
    notifyListeners();
  }
}
