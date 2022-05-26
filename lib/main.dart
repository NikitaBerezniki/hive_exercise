import 'package:flutter/material.dart';
import 'package:hive_exercise/models/todo_data.dart';
import 'package:hive_exercise/models/user_data.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'models/entities/user.dart';
import 'models/exchange_data.dart';
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
          ChangeNotifierProvider<UserData>(
            create: (BuildContext context) => UserData(),
          ),
          ProxyProvider<UserData, TodoData>(
            update: (context, userModel, todoModel) {
              return TodoData(userModel);
            },
          )
          // ProxyProvider2<UserData, TodoData, ExchangeData>(
          //   update: (BuildContext context, UserData userData, TodoData todoData,
          //           ExchangeData exchangeModel) =>
          //       ExchangeData(),
          // ),
          // ChangeNotifierProvider<TodoData>(
          //   create: (BuildContext context) => TodoData(),
          // ),
        ],
        builder: (context, snapshot) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData.light().copyWith(
              primaryColor: Colors.blue,
              brightness: Brightness.light,
            ),
            title: 'Hive Todo App',
            home: const MainScreen(),
          );
        });
  }
}
