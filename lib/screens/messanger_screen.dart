import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hive_exercise/screens/chat_screen.dart';
import 'package:hive_exercise/services/global_extensions.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../models/entities/user.dart';
import '../models/user_data.dart';

class MessangerScreen extends StatelessWidget {
  const MessangerScreen({Key? key}) : super(key: key);
  static const String appBartitle = 'Мессенджер';

  @override
  Widget build(BuildContext context) {
    return Consumer<UserData>(builder: (context, model, _) {
      return Column(
        children: [
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: model.activeUser?.friends?.length ?? 0,
              itemBuilder: (context, index) {
                final User? friend =
                    model.activeUser?.friends?.elementAt(index);
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: FriendCard(friend),
                );
              },
            ),
          ),
        ],
      );
    });
  }
}

class FriendCard extends StatelessWidget {
  final User? friend;
  const FriendCard(this.friend, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<UserData>(builder: (context, model, _) {
      return Card(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(kRadius / 4),
          child: Slidable(
            closeOnScroll: true,
            endActionPane: ActionPane(motion: const ScrollMotion(), children: [
              SlidableAction(
                onPressed: (context) {
                  model.deleteFromFriends(friend?.key);
                },
                backgroundColor: const Color(0xFFFE4A49),
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: 'Удалить из друзей',
              ),
            ]),
            child: ListTile(
              onTap: () {
                if (friend == null) return;
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ChatScreen(toUser: friend!),
                ));
              },
              contentPadding:
                  EdgeInsets.only(top: 8, bottom: 8, left: 2, right: 8),
              horizontalTitleGap: 8,
              // isThreeLine: true,
              visualDensity: VisualDensity.comfortable,
              leading: CircleAvatar(
                  radius: 28,
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Colors.white,
                  child: Icon(
                    Icons.person,
                    size: 40,
                  )),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${friend?.name.capitalize()} ${friend?.surname.capitalize()}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text('12:05')
                ],
              ),
              subtitle: Column(children: [
                SizedBox(height: 8),
                Text('Displaying images is fundamental for most mobile apps.')
              ]),
            ),
          ),
        ),
      );
    });
  }
}
