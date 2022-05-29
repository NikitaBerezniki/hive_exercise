import 'package:flutter/material.dart';
import 'package:hive_exercise/constants.dart';
import 'package:hive_exercise/models/message_data.dart';
import 'package:hive_exercise/services/global_extensions.dart';
import 'package:hive_exercise/widgets/custom_app_bar.dart';
import 'package:provider/provider.dart';

import '../models/entities/user.dart';

class ChatScreen extends StatefulWidget {
  final User toUser;
  const ChatScreen({required this.toUser, Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Consumer<MessageData>(builder: (context, model, child) {
      return FutureBuilder(
          future: model.showDialogForFutureBuilder(widget.toUser),
          builder: (context, snapshot) {
            return Scaffold(
                appBar: customAppBar(
                    '${widget.toUser.name.capitalize()} ${widget.toUser.surname.capitalize()}'),
                body: Column(children: [
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: model.dialog?.length ?? 0,
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(kRadius)),
                          child:
                              Text(model.dialog?.elementAt(index).text ?? ''),
                        );
                      },
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border(
                            top: BorderSide(
                                width: 1,
                                color: Theme.of(context)
                                    .primaryColor
                                    .withOpacity(0.5)))),
                    child: TextField(
                        controller: messageController,
                        keyboardType: TextInputType.multiline,
                        minLines: 1,
                        maxLines: 5,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: IconButton(
                            icon: Icon(Icons.attach_file_rounded),
                            onPressed: () {},
                          ),
                          hintText: 'Сообщение',
                          suffixIcon: IconButton(
                              icon: Icon(Icons.send_rounded),
                              onPressed: () {
                                print(messageController.text);
                                model.sendMessage(
                                    messageController.text, widget.toUser);
                              }),
                        )),
                  ),
                ]));
          });
    });
  }
}
