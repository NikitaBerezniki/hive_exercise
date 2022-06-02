
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class ChatsWidget extends StatefulWidget {
//   const ChatsWidget({Key? key}) : super(key: key);

//   @override
//   _ChatsWidgetState createState() => _ChatsWidgetState();
// }

// class _ChatsWidgetState extends State<ChatsWidget> {
//   @override
//   Widget build(BuildContext context) {
//     // final ChatController controller = Provider.of<ChatController>(context);
//     final ScrollController scrollController = controller.scrollController;

//     return Flexible(
//       fit: FlexFit.loose,
//       child: Container(
//         padding: EdgeInsets.zero,
//         decoration: BoxDecoration(
//           color: Theme.of(context).backgroundColor,
//         ),
//         child: LayoutBuilder(
//           builder: (BuildContext context, BoxConstraints viewportConstraints) {
//             return SingleChildScrollView(
//               controller: scrollController,
//               reverse: true,
//               padding: EdgeInsets.only(left: 16, right: 16),
//               child: ConstrainedBox(
//                 constraints: BoxConstraints(
//                   minWidth: viewportConstraints.maxWidth,
//                   minHeight: viewportConstraints.maxHeight,
//                 ),
//                 child: StreamProvider<List<Message>>.value(
//                   value: controller.listStream,
//                   initialData: [],
//                   updateShouldNotify: (previous, current) => true,
//                   child: Consumer<List<Message>>(
//                     builder: (context, messages, child) {
//                       return Column(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: <Widget>[
//                           SizedBox(
//                             height: 9,
//                           ),
//                           ...List<Widget>.generate(messages.length, (int index) {
//                             final Message message = messages[index];

//                             return (message.type == MessageType.incoming)
//                                 ? ChangeNotifierProvider<IncomingMessageController>(
//                                     create: (_) => IncomingMessageController(message, controller),
//                                     child: IncomingMessage(),
//                                   )
//                                 : ChangeNotifierProvider<OutgoingMessageController>(
//                                     create: (_) => OutgoingMessageController(message, controller),
//                                     child: OutgoingMessage(),
//                                   );
//                           }).toList(),
//                           SizedBox(
//                             height: 18,
//                           ),
//                         ],
//                       );
//                     }}}


//              void _sendMessage(dynamic content) {
//     Rx.fromCallable(() => _messageService.sendMessage(content))
//         .doOnError((error, stackTrace) => Stream.fromFuture(Future.value(null)))
//         .listen((value) {
//       if (value is Message) {
//         _messages.add(value);

//         this.listSink.add(_messages);
//         this.scrollController.animateTo(
//               0,
//               duration: Duration(milliseconds: 250),
//               curve: Curves.easeInOutCubic,
//             );
//       }
//     });
//   }