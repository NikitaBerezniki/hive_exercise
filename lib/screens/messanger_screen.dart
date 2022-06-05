import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hive_exercise/models/message_data.dart';
import 'package:hive_exercise/screens/chat_screen.dart';
import 'package:hive_exercise/services/global_extensions.dart';
import 'package:provider/provider.dart';
import '../constants.dart';
import '../models/entities/message.dart';
import '../models/entities/user.dart';
import '../models/user_data.dart';

class MessangerScreen extends StatefulWidget {
  const MessangerScreen({Key? key}) : super(key: key);
  static const String appBartitle = 'Мессенджер';

  @override
  State<MessangerScreen> createState() => _MessangerScreenState();
}

class _MessangerScreenState extends State<MessangerScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MessageData>(builder: (_, messageModel, __) {
      return FutureBuilder<List<MapEntry<User, Message?>>>(
          // future: Provider.of<MessageData>(context, listen: false)
          //     .getLastMessagesOfFriends(),
          future: messageModel.getLastMessagesOfFriends(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return Container();
            final lastMessages = snapshot.data;
            return Column(children: [
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: lastMessages?.length ?? 0,
                  itemBuilder: (context, index) {
                    final lastMessage = lastMessages?.elementAt(index).value;
                    final friend = lastMessages?.elementAt(index).key;
                    if (friend == null) return Container();
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: FriendCard(friend, lastMessage),
                    );
                  },
                ),
              )
            ]);
          });
    });
  }
}

class FriendCard extends StatelessWidget {
  final User toUser;
  final Message? message;
  const FriendCard(this.toUser, this.message, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
      return Card(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(kRadius / 4),
          child: Slidable(
            closeOnScroll: true,
            endActionPane: ActionPane(motion: const ScrollMotion(), children: [
              SlidableAction(
                onPressed: (context) {
                  Provider.of<UserData>(context, listen: false).deleteFromFriends(toUser.key);
                },
                backgroundColor: const Color(0xFFFE4A49),
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: 'Удалить из друзей',
              ),
            ]),
            child: ListTile(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ChatScreen(toUser: toUser),
                ));
              },
              contentPadding:
                  EdgeInsets.only(top: 8, bottom: 8, left: 2, right: 8),
              horizontalTitleGap: 8,
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
                    '${toUser.name.capitalize()} ${toUser.surname.capitalize()}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(Message.dateMessage(message)),
                ],
              ),
              subtitle: Text(message?.text ?? ''),
            ),
          ),
        ),
      );
  }
}
