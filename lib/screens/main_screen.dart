import 'package:flutter/material.dart';
import 'package:hive_exercise/models/bottom_bar_data.dart';
import 'package:hive_exercise/models/user_data.dart';
import 'package:provider/provider.dart';
import '../widgets/floating_button/add_entity_floating_action_button.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_bottom_navigation_bar.dart';
import '../widgets/custom_drawer.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // int? _currentIndex;
  ValueListenableProvider<int>? currentIndexBottomBar;
  @override
  void initState() {
    super.initState();
    Provider.of<UserData>(context, listen: false).getUsers();
  }

  TextEditingController editingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<UserData>(builder: (_, model, __) {
      // if (model.users.isNotEmpty) model.setActiveUser(model.users.first);
      return SafeArea(
          child: Scaffold(
        bottomNavigationBar: CustomBottomNavigationBar(),
        drawer: CustomDrawer(),
        appBar: customAppBar(''),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: const AddEntityFloatingActionButton(),
        body: Consumer<BottomBarData>(builder: (context, model, child) {
          return model.activeScreen;
        }),
      ));
    });
  }
}
