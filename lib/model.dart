import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Model {
  void test() async {
    // var box = await Hive.openBox<dynamic>('testBox');
    // Hive.box('name');
    // await box.put('name', 'Dima');
    // await box.put('surname', ['Karpov', 'Smirnoff', 'Gagarin', 'Borrel']);
    // final name = box.get('name') as String?;
    // print(name);
    // final index = await box.add('123');
    // print(index);
    // print(box.keys);
    // print(box.values);
    // box.clear();
    // if (box.isOpen) box.close();
  }

  void doSome() async {
    // if (!Hive.isAdapterRegistered(0)) Hive.registerAdapter(UserAdapter());
    var box = await Hive.openBox<User>('user');
    final user = User('Ivan', 54);
    await box.add(user);
    final userFromBox = box.getAt(0);
    print(userFromBox);
  }
}

class User {
  String name;
  int age;
  User(this.name, this.age);

  @override
  String toString() => '$name $age';
}

class UserAdapter extends TypeAdapter<User> {
  @override
  final typeId = 0;

  @override
  User read(BinaryReader reader) {
    final name = reader.readString();
    final age = reader.readInt();
    return User(name, age);
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer.writeString(obj.name);
    writer.writeInt(obj.age);
  }
}
