import 'package:flutter/material.dart';
import 'package:hive_exercise/constants.dart';
import 'package:hive_exercise/models/message_data.dart';
import 'package:hive_exercise/widgets/custom_app_bar.dart';
import 'package:provider/provider.dart';
import '../models/entities/message.dart';
import '../models/entities/user.dart';
import '../widgets/alert_dialog/message_detail_alert_dialog.dart';

extension SelectionsOfMessages on _ChatScreenState {
  void onLongPressOnMessage(message) {
    if (!isSelectedMessages) {
      setState(() => onSelectMessages(message));
    }
  }

  void onTapOnMessage(message) {
    if (isSelectedMessages) {
      setState(() {
        onSelectMessages(message);
      });
    } else {
      if (message != null) {
        messageDetailAlertDialog(context, message);
      }
    }
  }

  void onSelectMessages(message) {
    if (selectedMessages.contains(message)) {
      selectedMessages.remove(message!);
      if (selectedMessages.isEmpty) {
        isSelectedMessages = false;
      }
    } else {
      isSelectedMessages = true;
      selectedMessages.add(message!);
    }
  }
}

class ChatScreen extends StatefulWidget {
  final User toUser;
  const ChatScreen({required this.toUser, Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late FocusNode _focusNode;
  late TextEditingController _messageController;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _messageController = TextEditingController();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  List<Message> selectedMessages = [];
  bool isSelectedMessages = false;
  bool isOpenAddAtachments = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<MessageData>(builder: (_, messageModel, __) {
      return Scaffold(
        appBar: customAppBar('${widget.toUser.name} ${widget.toUser.surname}'),
        body: Column(children: [
          Expanded(
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              reverse: true,
              child: GestureDetector(
                onTap: () {
                  _focusNode.nextFocus();
                },
                child: FutureBuilder<List<Message>>(
                    future: messageModel.showActiveDialog(widget.toUser),
                    builder: (context, snapshot) {
                      return ListView.builder(
                        controller: _scrollController,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data?.length ?? 1,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final isToUser =
                              snapshot.data?.elementAt(index).toUser ==
                                  widget.toUser;
                          final message = snapshot.data?.elementAt(index);
                          final timeMessage = MessageData.dateMessage(message);
                          if (snapshot.hasData == false) {
                            return Center(
                              child: Text('Напишите первым!!!'),
                            );
                          }
                          return GestureDetector(
                            onLongPress: () => onLongPressOnMessage(message),
                            onTap: () => onTapOnMessage(message),
                            child: Container(
                              padding: EdgeInsets.only(
                                  left: 14, right: 14, top: 5, bottom: 5),
                              child: Align(
                                alignment: (!isToUser
                                    ? Alignment.topLeft
                                    : Alignment.topRight),
                                child: Stack(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: (!isToUser
                                            ? (selectedMessages
                                                    .contains(message)
                                                ? Colors.grey.shade400
                                                : Colors.grey.shade200)
                                            : (selectedMessages
                                                    .contains(message)
                                                ? Colors.blue[400]
                                                : Colors.blue[200])),
                                      ),
                                      padding: EdgeInsets.only(
                                          top: kPadding,
                                          bottom: kPadding,
                                          left: kPadding,
                                          right: kPadding * 3),
                                      child: Text(
                                        message?.text ?? '',
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ),
                                    Positioned(
                                        bottom: 5,
                                        right: 10,
                                        child: Text(
                                          timeMessage,
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.black
                                                  .withOpacity(0.4)),
                                        )),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
                border: Border(
                    top: BorderSide(
                        width: 1,
                        color:
                            Theme.of(context).primaryColor.withOpacity(0.5)))),
            child: TextField(
              focusNode: _focusNode,
              controller: _messageController,
              keyboardType: TextInputType.multiline,
              minLines: 1,
              maxLines: 5,
              decoration: InputDecoration(
                border: InputBorder.none,
                prefixIcon: IconButton(
                  icon: Icon(Icons.attach_file_rounded),
                  onPressed: () {
                    setState(() => isOpenAddAtachments = !isOpenAddAtachments);
                  },
                ),
                hintText: 'Сообщение',
                suffixIcon: IconButton(
                    icon: Icon(Icons.send_rounded),
                    onPressed: () {
                      if (_messageController.text.trim().isEmpty) return;
                      messageModel.sendMessage(
                          _messageController.text, widget.toUser);
                      _messageController.clear();
                    }),
              ),
            ),
          ),
          if (isOpenAddAtachments)
            ListView(
              shrinkWrap: true,
              children: [
                Card(
                  child: ListTile(
                      onTap: () {},
                      leading: Icon(Icons.image),
                      title: Text('Фотографии')),
                ),
                Card(
                  child: ListTile(
                      onTap: () {},
                      leading: Icon(Icons.document_scanner_rounded),
                      title: Text('Документы')),
                ),
                Card(
                  child: ListTile(
                      onTap: () {},
                      leading: Icon(Icons.task),
                      title: Text('Задачи')),
                ),
              ],
            )
        ]),
      );
    });
  }
}
