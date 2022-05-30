import 'package:flutter/material.dart';
import 'package:hive_exercise/models/user_data.dart';
import 'package:hive_exercise/services/global_extensions.dart';
import 'package:hive_exercise/widgets/alert_dialog/delete_database_alert_dialog.dart';
import 'package:provider/provider.dart';

import '../models/entities/user.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<UserData>(builder: (context, model, child) {
      User? selectedUser;
      if (model.users.isNotEmpty) {
        selectedUser = model.users.first;
      }
      return Drawer(
          // backgroundColor: Theme.of(context).primaryColor.withOpacity(0.5),
          child: SafeArea(
        child: ListView(
          children: [
            DrawerHeader(
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage('assets/img/1.jpg'),
                  opacity: 0.9,
                  filterQuality: FilterQuality.low,
                  fit: BoxFit.cover,
                )),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      alignment: Alignment.bottomLeft,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Theme.of(context).primaryColor.withOpacity(0.5),
                      ),
                      child: StatefulBuilder(builder: (context, setState) {
                        return DropdownButton<User>(
                          underline: SizedBox.shrink(),
                          alignment: Alignment.bottomLeft,
                          borderRadius: BorderRadius.circular(20),
                          dropdownColor: Theme.of(context).primaryColor,
                          elevation: 5,
                          icon: Icon(Icons.person_pin,
                              color: Colors.white, size: 32),
                          isExpanded: true,
                          items: model.users
                              .map((user) => DropdownMenuItem(
                                    child: Text(
                                        '${user.name.capitalize()} ${user.surname.capitalize()}',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold)),
                                    value: user,
                                  ))
                              .toList(),
                          value: model.activeUser ?? selectedUser,
                          onChanged: (value) {
                            if (value != null) {
                              setState(() => selectedUser = value);
                              model.setActiveUser(value);
                            }
                          },
                        );
                      }),
                    ),
                  ],
                )),
            MenuItemDrawer(title: 'Главная страница', icon: Icons.home),
            MenuItemDrawer(title: 'Графики', icon: Icons.donut_large),
            MenuItemDrawer(
              title: 'Очистить базу',
              icon: Icons.delete,
              onTap: () => deleteDatabaseAlertDialog(context),
            ),
          ],
        ),
      ));
    });
  }
}

class MenuItemDrawer extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback? onTap;
  const MenuItemDrawer({
    required this.title,
    required this.icon,
    this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        color: Colors.deepOrange,
        margin: EdgeInsets.only(left: 16, right: 16, bottom: 12),
        child: ListTile(
            leading: Icon(
              icon,
              color: Colors.white,
              size: 40,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            onTap: onTap,
            title: Text(
              title,
              // textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 20),
            )));
  }
}
