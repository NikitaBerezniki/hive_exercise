import 'package:flutter/material.dart';
import 'package:hive_exercise/models/bottom_bar_data.dart';
import 'package:provider/provider.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({Key? key}) : super(key: key);

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int? currentIndex;
  @override
  Widget build(BuildContext context) {
    return Consumer<BottomBarData>(builder: (context, model, child) {
      return BottomNavigationBar(
          showUnselectedLabels: false,
          showSelectedLabels: false,
          currentIndex: model.currentScreenIndex,
          elevation: 3,
          onTap: (index) => model.setTab(index),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.question_answer, size: 32),
              label: 'Друзья',
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.task, size: 32), label: 'Задачи')
          ]);
    });
  }
}
