import 'package:flutter/material.dart';
import 'package:hive_exercise/models/user_data.dart';
import 'package:hive_exercise/services/global_extensions.dart';
import 'package:provider/provider.dart';
import '../../constants.dart';
import '../../models/entities/user.dart';

void addFriendsModalSheet(BuildContext context) {
  void onAddFriends(
      activeUser, List<int> selectedItem, List<User>? acquaintances) {
    if (selectedItem.isEmpty && activeUser != null) {
      return Navigator.pop(context);
    }
    for (var index in selectedItem) {
      final addUser = acquaintances?.elementAt(index);
      if (addUser != null) {
        Provider.of<UserData>(context, listen: false)
            .addFriend(activeUser, addUser);
      }
    }
    Navigator.pop(context);
  }

  showModalBottomSheet(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        topLeft: Radius.circular(kRadius),
        topRight: Radius.circular(kRadius),
      )),
      context: context,
      builder: (context) {
        final draggableScrollableController = DraggableScrollableController();
        return Consumer<UserData>(builder: (contextModel, model, _) {
          List<User>? acquaintances = model.searchForAcquaintances();
          List<int> selectedItem = [];
          final User? activeUser = model.activeUser;
          // print(acquaintances);
          return Stack(clipBehavior: Clip.none, children: [
            Positioned(
              right: 0,
              left: 0,
              bottom: kPadding / 2,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                    onPressed: () =>
                        onAddFriends(activeUser, selectedItem, acquaintances),
                    child: Text(
                      'Добавить',
                      style: TextStyle(fontSize: 18),
                    )),
              ),
            ),
            Padding(
                padding: EdgeInsets.only(
                    left: kPadding,
                    right: kPadding,
                    bottom: MediaQuery.of(context).viewInsets.bottom +
                        kPadding * 4),
                child: DraggableScrollableSheet(
                    controller: draggableScrollableController,
                    expand: false,
                    minChildSize: 0.5,
                    maxChildSize: 1,
                    builder: (_, controller) {
                      return SingleChildScrollView(
                        controller: controller,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            DividerOfModalBottom(),
                            SizedBox(height: 8),
                            TextAddFriend(),
                            SizedBox(height: kPadding),
                            StatefulBuilder(builder: (context, setState) {
                              return ListView.builder(
                                  controller: controller,
                                  physics:
                                      (draggableScrollableController.size ==
                                              1.0)
                                          ? NeverScrollableScrollPhysics()
                                          : BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: acquaintances?.length ?? 0,
                                  itemBuilder: (context, index) {
                                    final notFriend =
                                        acquaintances?.elementAt(index);

                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ListTile(
                                        onTap: () {
                                          setState(() {
                                            if (selectedItem.contains(index)) {
                                              selectedItem.removeWhere(
                                                  (element) =>
                                                      element == index);
                                            } else {
                                              selectedItem.add(index);
                                            }
                                          });
                                        },
                                        leading: CircleAvatar(
                                          radius: 30,
                                          backgroundColor: selectedItem
                                                  .contains(index)
                                              ? Colors.orange
                                              : Theme.of(context).primaryColor,
                                          child: CircleAvatar(
                                              radius: 26,
                                              backgroundColor:
                                                  selectedItem.contains(index)
                                                      ? Colors.orange
                                                      : Theme.of(context)
                                                          .primaryColor,
                                              foregroundColor: Colors.white,
                                              child: Icon(
                                                Icons.person,
                                                size: 38,
                                                color:
                                                    selectedItem.contains(index)
                                                        ? Colors.black
                                                        : Colors.white,
                                              )),
                                        ),
                                        title: Text(
                                          '${notFriend?.name.capitalize()} ${notFriend?.surname.capitalize()}',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight:
                                                  selectedItem.contains(index)
                                                      ? FontWeight.bold
                                                      : FontWeight.normal),
                                        ),
                                      ),
                                    );
                                  });
                            }),
                          ],
                        ),
                      );
                    }))
          ]);
        });
      });
}

class DividerOfModalBottom extends StatelessWidget {
  const DividerOfModalBottom({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kPadding / 2),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(kRadius),
            color: Colors.black.withOpacity(0.1)),
        height: 5,
        width: 50,
      ),
    );
  }
}

class TextAddFriend extends StatelessWidget {
  const TextAddFriend({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text('Добавить собеседника',
        style: Theme.of(context)
            .textTheme
            .headline6
            ?.copyWith(fontWeight: FontWeight.bold));
  }
}
