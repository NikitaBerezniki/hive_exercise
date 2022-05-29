import 'package:flutter/material.dart';

AppBar customAppBar(String title) {
  return AppBar(
    title: Text(title),
    centerTitle: true,
    actions: [IconButton(onPressed: () {}, icon: Icon(Icons.search_rounded))],
  );
}
