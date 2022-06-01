import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hive_exercise/constants.dart';
import 'package:hive_exercise/models/todo_data.dart';
import 'package:provider/provider.dart';
import '../models/entities/todo.dart';

class TodoManagerScreen extends StatefulWidget {
  const TodoManagerScreen({Key? key}) : super(key: key);
  static const String appBartitle = 'Менеджер задач';

  @override
  State<TodoManagerScreen> createState() => _TodoManagerScreenState();
}

class _TodoManagerScreenState extends State<TodoManagerScreen> {
  // @override
  // void initState() {
  //   // Provider.of<TodoData>(context, listen: false).getTodoofActiveUser();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Consumer<TodoData>(builder: (_, model, __) {
      return FutureBuilder<List<Todo>>(
          future: model.getTodoOfActiveUser(),
          builder: (context, snapshot) {
            return ListView.builder(
              itemCount: snapshot.data?.length ?? 0,
              itemBuilder: (context, index) {
                Todo todo = snapshot.data!.elementAt(index);
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: kPadding / 2),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(kRadius),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(kRadius)),
                      child: Slidable(
                        closeOnScroll: true,
                        endActionPane:
                            ActionPane(motion: const ScrollMotion(), children: [
                          SlidableAction(
                            onPressed: (context) {},
                            backgroundColor: const Color(0xFFFE4A49),
                            foregroundColor: Colors.white,
                            icon: Icons.delete,
                            label: 'Удалить',
                          ),
                        ]),
                        child: ListTile(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(kRadius)),
                          title: Text(todo.name ?? ''),
                          subtitle: Text(todo.description ?? ''),
                          leading:
                              StatefulBuilder(builder: (context, setState) {
                            return Transform.scale(
                              scale: 1.8,
                              child: Checkbox(
                                activeColor: Theme.of(context).primaryColor,
                                checkColor: Colors.white,
                                shape: CircleBorder(),
                                onChanged: (value) {
                                  setState(
                                    () {
                                      todo.isDone = value;
                                      todo.save();
                                    },
                                  );
                                },
                                value: todo.isDone,
                              ),
                            );
                          }),
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          });
    });
  }
}
