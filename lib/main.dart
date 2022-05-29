import 'package:flutter/material.dart';
import 'package:hive_exercise/models/bottom_bar_data.dart';
import 'package:hive_exercise/models/message_data.dart';
import 'package:hive_exercise/models/todo_data.dart';
import 'package:hive_exercise/models/user_data.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'screens/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // final directory = await getApplicationDocumentsDirectory();
  await Hive.initFlutter();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<BottomBarData>(
              create: (BuildContext context) => BottomBarData()),
          ChangeNotifierProvider<UserData>(
              create: (BuildContext context) => UserData()),
          ChangeNotifierProxyProvider<UserData, TodoData>(
              create: (context) => TodoData(UserData()),
              update: (context, userModel, todoModel) => TodoData(userModel)),
              ChangeNotifierProxyProvider<UserData, MessageData>(
              create: (context) => MessageData(UserData()),
              update: (context, userModel, messageModel) => MessageData(userModel)),
          
        ],
        builder: (context, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData.light().copyWith(
              primaryColor: Colors.blue,
              brightness: Brightness.light,
            ),
            title: 'Social Taskmanager',
            home: const MainScreen(),
          );
        });
  }
}
