import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

deleteDatabaseAlertDialog(BuildContext context) {
  // set up the buttons
  Widget cancelButton = TextButton(
    child: Text("Отмена"),
    onPressed: () {
      Navigator.pop(context);
    },
  );
  Widget continueButton = TextButton(
    child: Text("Удалить"),
    onPressed: () {
      Hive.deleteFromDisk();
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    title: Text("Удаление базы данных"),
    content: Text(
        "Вы точно хотите полностью удалить локальную базу данных приложения?"),
    actions: [
      cancelButton,
      continueButton,
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
