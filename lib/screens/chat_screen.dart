import 'package:flutter/material.dart';
import 'package:hive_exercise/constants.dart';
import 'package:hive_exercise/models/message_data.dart';
import 'package:hive_exercise/widgets/custom_app_bar.dart';
import 'package:provider/provider.dart';
import '../models/entities/message.dart';
import '../models/entities/user.dart';

class CustomListViewScrollController extends ScrollController {}

class ChatScreen extends StatefulWidget {
  final User toUser;
  const ChatScreen({required this.toUser, Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<MessageData>(context, listen: false)
          .showDialog(widget.toUser);
    });
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

  final _focusNode = FocusNode();
  final _messageController = TextEditingController();
  List<Message> selectedMessages = [];
  bool isSelectedMessages = false;
  bool isOpenAddition = false;
  @override
  Widget build(BuildContext context) {
    return Consumer<MessageData>(builder: (context, model, child) {
      if (model.dialog?.length == null) {
        return Scaffold(appBar: AppBar(), body: Container());
      }
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
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: model.dialog?.length ?? 0,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final isToUser =
                        model.dialog?.elementAt(index).toUser == widget.toUser;
                    final message = model.dialog?.elementAt(index);
                    final dateMessage = DateTime.fromMillisecondsSinceEpoch(
                        message?.createDate ?? 0);
                    return GestureDetector(
                      onLongPress: () {
                        setState(() {
                          if (!isSelectedMessages) onSelectMessages(message);
                        });
                      },
                      onTap: () {
                        setState(() {
                          if (isSelectedMessages) onSelectMessages(message);
                        });
                      },
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
                                      ? (selectedMessages.contains(message)
                                          ? Colors.grey.shade400
                                          : Colors.grey.shade200)
                                      : (selectedMessages.contains(message)
                                          ? Colors.blue[400]
                                          : Colors.blue[200])),
                                ),
                                padding: EdgeInsets.only(
                                    top: kPadding,
                                    bottom: kPadding,
                                    left: kPadding,
                                    right: kPadding * 3),
                                child: Text(
                                  model.dialog?.elementAt(index).text ?? '',
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                              Positioned(
                                  bottom: 5,
                                  right: 10,
                                  child: Text(
                                    '${dateMessage.hour}:${dateMessage.minute}',
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.black.withOpacity(0.4)),
                                  )),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
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
                    setState(() {
                      isOpenAddition = !isOpenAddition;
                    });
                  },
                ),
                hintText: 'Сообщение',
                suffixIcon: IconButton(
                    icon: Icon(Icons.send_rounded),
                    onPressed: () {
                      if (_messageController.text.trim().isEmpty) return;
                      model.sendMessage(_messageController.text, widget.toUser);
                      _messageController.clear();
                    }),
              ),
            ),
          ),
          if (isOpenAddition)
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
