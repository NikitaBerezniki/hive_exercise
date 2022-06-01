import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_exercise/constants.dart';
import 'package:hive_exercise/models/entities/message.dart';
import 'package:hive_exercise/models/message_data.dart';
import 'package:provider/provider.dart';

messageDetailAlertDialog(BuildContext context, Message message) {
  Widget alertButton(String title, callBackFunction) {
    return Container(
      padding: EdgeInsets.all(kPadding),
      width: double.infinity,
      child: GestureDetector(
        onTap: callBackFunction,
        child: Text(
          title,
          style: TextStyle(color: Colors.black87, fontSize: 18),
        ),
      ),
    );
  }

  onReplyMessage() {
    Navigator.pop(context);
  }

  Widget replyButton = alertButton('Ответить', onReplyMessage);

  onRedirectMessage() {
    Navigator.pop(context);
  }

  Widget redirectButton = alertButton('Переслать', onRedirectMessage);

  onCopyMessage() {
    Clipboard.setData(ClipboardData(text: message.text));
    SnackBar snackBar = SnackBar(
      padding: EdgeInsets.all(20),
      // shape:
      //     RoundedRectangleBorder(borderRadius: BorderRadius.circular(kRadius)),
      content: Text(
        'Скопировано в буфер обмена!',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 20),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    Navigator.pop(context);
  }

  Widget copyButton = alertButton('Скопировать', onCopyMessage);

  onEditMessage() {
    Navigator.pop(context);
  }

  Widget editButton = alertButton('Редактировать', onEditMessage);

  onDeleteMessage() {
    Provider.of<MessageData>(context, listen: false).deleteMessage(message);
    Navigator.pop(context);
  }

  Widget deleteButton = alertButton('Удалить', onDeleteMessage);

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    actions: [
      replyButton,
      redirectButton,
      copyButton,
      editButton,
      deleteButton
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
