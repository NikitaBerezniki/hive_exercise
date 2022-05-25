import 'package:flutter/material.dart';
import 'package:hive_exercise/models/user_data.dart';
import 'package:provider/provider.dart';
import '../../constants.dart';
import '../../models/entities/user.dart';

void addFriendsModalSheet(BuildContext context) {
  void onAddFriends(User user, User friend) {
    Provider.of<UserData>(context, listen: false).addFriends(user, friend);
    Navigator.of(context).pop();
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
              bottom: MediaQuery.of(context).viewInsets.bottom + 50),
          child: Consumer<UserData>(builder: (context, model, _) {
            User? selectedUser;
            User? selectedFriend;
            final size = MediaQuery.of(context).size;
            return StatefulBuilder(builder: (context, setState) {
              return Column(
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
                  Text('Добавить нового друга',
                      style: Theme.of(context)
                          .textTheme
                          .headline6
                          ?.copyWith(fontWeight: FontWeight.bold)),
                  SizedBox(height: kPadding),
                  Row(
                    children: [
                      Text('Пользователь'),
                      SizedBox(width: size.width / 20),
                      DropdownButton<User>(
                          items: model.users
                              .map((user) => DropdownMenuItem(
                                  child: Text('${user.name} ${user.surname}'),
                                  value: user))
                              .toList(),
                          onChanged: (user) {
                            setState(() {
                              if (user != null) selectedUser = user;
                            });
                          },
                          value: selectedUser ),
                    ],
                  ),
                  SizedBox(height: kPadding),
                  Row(
                    children: [
                      Text('Друг'),
                      SizedBox(width: size.width / 20),
                      DropdownButton<User>(
                          items: model.users
                              .map((user) => DropdownMenuItem(
                                  child: Text('${user.name} ${user.surname}'),
                                  value: user))
                              .toList(),
                          onChanged: (user) {
                            setState(() {
                              if (user != null) selectedFriend = user;
                            });
                          },
                          value: selectedFriend),
                    ],
                  ),
                  SizedBox(height: kPadding),
                  ElevatedButton(
                      onPressed: () {
                        if (selectedFriend != null && selectedUser != null) {
                          onAddFriends(selectedUser!, selectedFriend!);
                        }
                      },
                      child: Text('Добавить'))
                ],
              );
            });
          }),
        );
      });
}
