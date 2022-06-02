import 'package:flutter/material.dart';
import 'package:hive_exercise/models/todo_data.dart';
import 'package:hive_exercise/models/user_data.dart';
import 'package:hive_exercise/services/global_extensions.dart';
import 'package:provider/provider.dart';
import '../../constants.dart';
import '../../models/entities/user.dart';

void addSimpleTaskModalSheet(BuildContext context) {
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  DateTimeRange datepicker = DateTimeRange(
      start: DateTime.now(), end: DateTime.now().add(Duration(days: 1)));
  User? responsibleUser;

  void onAddUser() {
    final name = nameController.text.trim();
    final description = descriptionController.text.trim();

    if (name.isNotEmpty && description.isNotEmpty) {
      Provider.of<TodoData>(context, listen: false)
          .addSimpleTodo(name, description, responsibleUser, datepicker);
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
        return Consumer<UserData>(builder: (_, userMdoel, __) {
          return Padding(
            padding: EdgeInsets.only(
                left: kPadding,
                right: kPadding,
                bottom: MediaQuery.of(context).viewInsets.bottom + 20),
            child: SingleChildScrollView(
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
                  Align(
                      alignment: Alignment.topLeft,
                      child: Text('Выбрать ответственного')),
                  StatefulBuilder(builder: (context, setState) {
                    User? selectedFriend = userMdoel.activeUser;
                    responsibleUser = userMdoel.activeUser;
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DropdownButtonFormField<User>(
                        items: [
                          DropdownMenuItem(
                            child: Text(
                              'Текущий пользователь - ${userMdoel.activeUser?.name} ${userMdoel.activeUser?.surname}',
                              // style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            value: userMdoel.activeUser,
                          ),
                          ...?userMdoel.activeUser?.friends
                              ?.map((friend) => DropdownMenuItem(
                                    child: Text(
                                        '${friend.name} ${friend.surname}'),
                                    value: friend,
                                  ))
                              .toList()
                        ],
                        onChanged: (selected) {
                          setState(
                            () {
                              if (selected != null) {
                                selectedFriend = selected;
                                responsibleUser = selected;
                              }
                            },
                          );
                        },
                        value: selectedFriend,
                      ),
                    );
                  }),
                  // SizedBox(height: kPadding),
                  TextButton(
                    onPressed: () async {
                      final temp = await showDateRangePicker(
                          context: context,
                          firstDate: DateTime(2020),
                          currentDate: DateTime.now(),
                          initialDateRange: datepicker,
                          lastDate: DateTime(2030));
                      if (temp != null) datepicker = temp;
                    },
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Дата начала: ${datepicker.start.toddmmyyyy()}'
                        '\nДата окончания: ${datepicker.end.toddmmyyyy()}',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                  // Дата начала, дата окончания
                  // приоритет
                  //
                  SizedBox(height: kPadding),
                  ElevatedButton(onPressed: onAddUser, child: Text('Добавить'))
                ],
              ),
            ),
          );
        });
      });
}
