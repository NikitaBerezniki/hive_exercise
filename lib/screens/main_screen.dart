import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hive_exercise/constants.dart';
import 'package:hive_exercise/models/user_data.dart';
import 'package:hive_exercise/services/global_extensions.dart';
import 'package:provider/provider.dart';
import '../models/entities/user.dart';
import '../widgets/add_entity_floating_action_button.dart';
import '../widgets/custom_drawer.dart';

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
    int _currentIndex = 0;
    return Consumer<UserData>(builder: (context, model, _) {
      return Scaffold(
          bottomNavigationBar: BottomNavigationBar(
              showUnselectedLabels: false,
              showSelectedLabels: false,
              currentIndex: _currentIndex,
              elevation: 3,

              onTap: (index) => setState(() => _currentIndex),
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.group, size: 32),
                  label: 'Друзья',
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.task, size: 32), label: 'Задачи')
              ]),
          drawer: CustomDrawer(),
          appBar: AppBar(
            title: Text('Список друзей'),
            centerTitle: true,
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          floatingActionButton: const AddEntityFloatingActionButton(),
          body: SafeArea(
            child: Consumer<UserData>(builder: (context, model, _) {
              return Center(
                child: ListView.builder(
                  itemCount: model.activeUser?.friends?.length ?? 0,
                  itemBuilder: (context, index) {
                    final User? friend =
                        model.activeUser?.friends?.elementAt(index);
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(kRadius / 4),
                          child: Slidable(
                            closeOnScroll: true,
                            endActionPane: ActionPane(
                                motion: const ScrollMotion(),
                                children: [
                                  SlidableAction(
                                    onPressed: (context) {
                                      model.deleteUser(friend?.key);
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
                              leading: Icon(Icons.person),
                              onTap: () {},
                              title: Text(
                                  'Друг: ${friend?.name.capitalize()} ${friend?.surname.capitalize()}'),
                              // subtitle: Column(children: []),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            }),
          ));
    });
  }
}
