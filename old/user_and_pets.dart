// import 'package:hive/hive.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// part 'model.g.dart';

// class Model {
//   void test() async {
//     // var box = await Hive.openBox<dynamic>('testBox');
//     // Hive.box('name');
//     // await box.put('name', 'Dima');
//     // await box.put('surname', ['Karpov', 'Smirnoff', 'Gagarin', 'Borrel']);
//     // final name = box.get('name') as String?;
//     // print(name);
//     // final index = await box.add('123');
//     // print(index);
//     // print(box.keys);
//     // print(box.values);
//     // box.clear();
//     // if (box.isOpen) box.close();
//   }

//   void userAdapterFunc() async {
//     if (!Hive.isAdapterRegistered(0)) Hive.registerAdapter(UserAdapter());
//     if (!Hive.isAdapterRegistered(1)) Hive.registerAdapter(PetAdapter());

//     var box_pet = await Hive.openBox<Pet>('pet');
//     final pet = Pet('Musia', 3);
//     await box_pet.add(pet);
//     final pet2 = Pet('Zevs', 4);
//     await box_pet.add(pet2);

//     // final petFromBox = box_pet.getAt(0);

//     var box_user = await Hive.openBox<User>('user');
//     final user =
//         User('Ivan', 54, pets: HiveList(box_pet, objects: [pet, pet2]));
//     await box_user.add(user);
//     final userFromBox = box_user.getAt(0);

//     print(userFromBox);
//     userFromBox?.pets?.forEach((element) {
//       print(element.name);
//       box_pet.clear();
//       box_pet.compact();
//       // if (box_pet.isOpen) box_pet.close();
//       box_user.clear();
//       box_user.compact();
//       // if (box_user.isOpen) box_user.close();
//     });
//   }
// }

// // for generate
// @HiveType(typeId: 0)
// class User extends HiveObject {
//   @HiveField(0)
//   String name;
//   @HiveField(1)
//   int age;
//   @HiveField(2)
//   HiveList<Pet>? pets;

//   User(this.name, this.age, {this.pets});

//   @override
//   String toString() => 'user: $name $age $pets';
// }

// @HiveType(typeId: 1)
// class Pet extends HiveObject {
//   @HiveField(0)
//   String name;
//   @HiveField(1)
//   int age;
//   @HiveField(2)
//   HiveList<Pet>? pets;

//   Pet(this.name, this.age);
//   @override
//   String toString() => 'pet: $name $age';
// }
// // class User {
// //   String name;
// //   int age;
// //   User(this.name, this.age);

// //   @override
// //   String toString() => '$name $age';
// // }

// // class UserAdapter extends TypeAdapter<User> {
// //   @override
// //   final typeId = 0;

// //   @override
// //   User read(BinaryReader reader) {
// //     final name = reader.readString();
// //     final age = reader.readInt();
// //     return User(name, age);
// //   }

// //   @override
// //   void write(BinaryWriter writer, User obj) {
// //     writer.writeString(obj.name);
// //     writer.writeInt(obj.age);
// //   }
// // }
