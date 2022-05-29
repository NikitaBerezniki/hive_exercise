import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:hive_exercise/widgets/modal_sheet/add_friends_modal_sheet.dart';
import 'package:hive_exercise/widgets/modal_sheet/add_task_modal_sheet.dart';
import '../modal_sheet/add_person_modal_sheet.dart';

class AddEntityFloatingActionButton extends StatelessWidget {
  const AddEntityFloatingActionButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      icon: Icons.add,
      activeIcon: Icons.close,
      spacing: 5,
      spaceBetweenChildren: 5,
      animationCurve: Curves.easeInOut,
      isOpenOnStart: false,
      animationDuration: const Duration(milliseconds: 200),
      children: [
        SpeedDialChild(
          child: const Icon(Icons.task),
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
          label: 'Добавить задачу',
          onTap: () {
            addSimpleTaskModalSheet(context);
          },
        ),
        SpeedDialChild(
          child: const Icon(Icons.person_add),
          backgroundColor: Colors.deepOrange,
          foregroundColor: Colors.white,
          label: 'Добавить нового собеседника',
          onTap: () => addFriendsModalSheet(context),
        ),
        SpeedDialChild(
          child: const Icon(Icons.person_add),
          backgroundColor: Colors.deepOrange,
          foregroundColor: Colors.white,
          label: 'Добавить пользователя',
          onTap: () => addPersonModalSheet(context),
        ),
      ],
    );
  }
}
