import 'package:brew_crew/models/user.dart';
import 'package:firebase_database/firebase_database.dart';

class DatabaseService {
  final String? uid;

  DatabaseService({required this.uid});

  // collection reference
  final DatabaseReference brewCollection = FirebaseDatabase.instance
      .ref()
      .child('brews');

  Future updateUserData(String sugars, String name, int strength) async {
    final ref = FirebaseDatabase.instance.ref("brews/$uid");
    await ref.set({'sugars': sugars, 'name': name, 'strength': strength});
  }


// get brews stream
  Stream<List<Brew>> get brews {
    final DatabaseReference brewsRef = FirebaseDatabase.instance.ref('brews');

    return brewsRef.onValue.map((event) {
      final data = event.snapshot.value as Map<dynamic, dynamic>?;

      if (data == null) return [];

      return data.entries.map((entry) {
        final brewData = entry.value as Map<dynamic, dynamic>;
        return Brew(
          name: brewData['name'] ?? '',
          strength: brewData['strength'] ?? 0,
          sugars: brewData['sugars'] ?? '0',
        );
      }).toList();
    });
  }

// get user doc stream
  Stream<UserData> get userData {
    return FirebaseDatabase.instance
        .ref('brews/$uid')
        .onValue
        .map((event) => UserData.userDataFromSnapshot(event.snapshot));
  }
}


class Brew {
  final String name;
  final int strength;
  final String sugars;

  Brew({required this.name, required this.strength, required this.sugars
  });
}
