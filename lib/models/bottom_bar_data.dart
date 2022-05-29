// ignore_for_file: constant_identifier_names
// ignore_for_file: prefer_final_fields

import 'package:flutter/material.dart';
import '../screens/messanger_screen.dart';
import '../screens/todo_manager_screen.dart';

const MESSENGER_SCREEN = 0;
const TODOMANAGER_SCREEN = 1;

class BottomBarData extends ChangeNotifier {
  int _currentScreenIndex = MESSENGER_SCREEN;
  int get currentScreenIndex => _currentScreenIndex;

  final Map<int, Widget> _screens = {
    MESSENGER_SCREEN: MessangerScreen(),
    TODOMANAGER_SCREEN: TodoManagerScreen(),
  };

  Widget get activeScreen => _screens.values.elementAt(_currentScreenIndex);

  void setTab(int tab) {
    if (tab == currentScreenIndex) {
    } else {
      _currentScreenIndex = tab;
      notifyListeners();
    }
  }
}
