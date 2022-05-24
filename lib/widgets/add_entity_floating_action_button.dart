import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'modal_sheet/add_person_modal_sheet.dart';

class AddEntityFloatingActionButton extends StatelessWidget {
  const AddEntityFloatingActionButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      icon: Icons.add,
      activeIcon: Icons.close,
      spacing: 3,
      spaceBetweenChildren: 4,
      animationCurve: Curves.easeInOut,
      isOpenOnStart: false,
      animationDuration: const Duration(milliseconds: 200),
      children: [
        SpeedDialChild(
          child: const Icon(Icons.task),
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
          label: 'Добавить задачу',
          onTap: () {},
        ),
        SpeedDialChild(
          child: const Icon(Icons.person_add),
          backgroundColor: Colors.deepOrange,
          foregroundColor: Colors.white,
          label: 'Добавить друга',
          onTap: () => addPersonModalSheet(context),
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
