import 'package:flutter/material.dart';
import 'package:hive_exercise/models/todo_data.dart';
import 'package:hive_exercise/models/user_data.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';

void addSimpleTaskModalSheet(BuildContext context) {
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();

  void onAddUser() {
    final name = nameController.text.trim();
    final description = descriptionController.text.trim();
    if (name.isNotEmpty && description.isNotEmpty) {
      Provider.of<TodoData>(context, listen: false).addSimpleTodo(name, description);
      Navigator.of(context).pop();
    }
  }

  showModalBottomSheet(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        topLeft: Radius.circular(kRadius),
        topRight: Radius.circular(kRadius),
      )),
      context: context,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
              left: kPadding,
              right: kPadding,
              bottom: MediaQuery.of(context).viewInsets.bottom + 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.all(kPadding / 2),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(kRadius),
                        color: Colors.black.withOpacity(0.1)),
                    height: 5,
                    width: 50,
                  ),
                ),
              ),
              Text('Добавить новую задачу',
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      ?.copyWith(fontWeight: FontWeight.bold)),
              SizedBox(height: kPadding),
              TextField(
                autofocus: true,
                controller: nameController,
                decoration: const InputDecoration(
                  hintText: 'Название',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(kRadius),
                    ),
                  ),
                ),
              ),
              SizedBox(height: kPadding),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  hintText: 'Описание',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(kRadius),
                    ),
                  ),
                ),
              ),
              SizedBox(height: kPadding),
              ElevatedButton(onPressed: onAddUser, child: Text('Добавить'))
            ],
          ),
        );
      });
}
