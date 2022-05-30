import 'package:flutter/material.dart';
import 'package:hive_exercise/constants.dart';
import 'package:hive_exercise/models/message_data.dart';
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
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<MessageData>(context, listen: false)
          .showDialog(widget.toUser);
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // scrollController.addListener(() {
      //   print('scrolling');
      // });
      // scrollController.position.isScrollingNotifier.addListener(() {
      //   if (!scrollController.position.isScrollingNotifier.value) {
      //     print('scroll is stopped');
      //   } else {
      //     print('scroll is started');
      //   }
      // });
    });
  }

  void scrollDown() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.position.hasViewportDimension) {
        scrollController.jumpTo(scrollController.position.maxScrollExtent);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  final scrollController = ScrollController();
  final messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Consumer<MessageData>(builder: (context, model, child) {
      if (model.dialog?.length == null) return Container();
      return Scaffold(
        appBar: customAppBar('${widget.toUser.name} ${widget.toUser.surname}'),
        body: Column(children: [
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              itemCount: model.dialog?.length ?? 0,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final isToUser =
                    model.dialog?.elementAt(index).toUser == widget.toUser;
                final message = model.dialog?.elementAt(index);
                final dateMessage = DateTime.fromMillisecondsSinceEpoch(
                    message?.createDate ?? 0);
                if (model.dialog?.length == index + 1) scrollDown();
                return Container(
                  padding:
                      EdgeInsets.only(left: 14, right: 14, top: 5, bottom: 5),
                  child: Align(
                    alignment:
                        (!isToUser ? Alignment.topLeft : Alignment.topRight),
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: (!isToUser
                                ? Colors.grey.shade200
                                : Colors.blue[200]),
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
                );
              },
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
                      if (messageController.text.trim().isEmpty) return;
                      model.sendMessage(messageController.text, widget.toUser);
                      messageController.clear();
                    }),
              ),
            ),
          ),
        ]),
      );
    });
  }
}
