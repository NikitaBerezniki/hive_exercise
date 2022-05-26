import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hive_exercise/constants.dart';
import 'package:hive_exercise/models/user_data.dart';
import 'package:provider/provider.dart';
import '../models/entities/user.dart';
import '../widgets/add_entity_floating_action_button.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<UserData>(context, listen: false).getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Список пользователей'),
          centerTitle: true,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: const AddEntityFloatingActionButton(),
        body: SafeArea(
          child: Consumer<UserData>(builder: (context, model, _) {
            return Center(
              child: ListView.builder(
                itemCount: model.users.length,
                itemBuilder: (context, index) {
                  final User user = model.users.elementAt(index);
                  return Card(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(kRadius / 4),
                      child: Slidable(
                        closeOnScroll: true,
                        endActionPane:
                            ActionPane(motion: const ScrollMotion(), children: [
                          SlidableAction(
                            onPressed: (context) {
                              model.deleteUser(user.key);
                            },
                            backgroundColor: const Color(0xFFFE4A49),
                            foregroundColor: Colors.white,
                            icon: Icons.delete,
                            label: 'Удалить',
                          ),
                          SlidableAction(
                            onPressed: (context) {},
                            backgroundColor: const Color(0xFF21B7CA),
                            foregroundColor: Colors.white,
                            icon: Icons.create,
                            label: 'Редактировать',
                          ),
                        ]),
                        child: ListTile(
                          onTap: (){
                            
                          },
                          title: Text(
                              'Имя: ${user.name} Фамилия: ${user.surname}\n День рождения: ${User.toDate(user.birthday)}'),
                          subtitle: Column(children: [
                            Row(
                              children: [
                                Text('Друзья: '),
                                Text(user.friends
                                        ?.map((e) => e.name)
                                        .toString() ??
                                    ''),
                              ],
                            )
                          ]),
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          }),
        ));
  }
}
