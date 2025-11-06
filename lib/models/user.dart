import 'package:firebase_database/firebase_database.dart';

class CustomUser{

  final String? uid;

  CustomUser({this.uid});
}
class UserData {
  final String uid;
  final String name;
  final String sugars;
  final int strength;

  UserData({
    required this.sugars,
    required this.strength,
    required this.name,
    required this.uid,
  });

  static UserData userDataFromSnapshot(DataSnapshot snapshot) {
    final value = snapshot.value;

    print('Raw snapshot value: $value'); // helpful for debugging

    if (value == null || value is! Map) {
      // fallback to prevent crash
      return UserData(
        sugars: '0',
        strength: 100,
        name: '',
        uid: '', // or use snapshot.key if needed
      );
    }

    final data = value as Map<dynamic, dynamic>;

    return UserData(
      sugars: data['sugars'] ?? '0',
      strength: data['strength'] ?? 100,
      name: data['name'] ?? '',
      uid: data['uid'] ?? '', // optional: use snapshot.key if uid isn't stored
    );
  }

}
