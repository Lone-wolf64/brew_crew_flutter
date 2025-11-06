import 'package:brew_crew/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:brew_crew/models/user.dart';
import 'package:brew_crew/services/database.dart';

class AuthService {
  final FirebaseAuth auth = FirebaseAuth.instance;

  // Convert Firebase User to CustomUser
  CustomUser? userFromFirebaseUser(User? user) {
    return user != null ? CustomUser(uid: user.uid) : null;
  }

  // Auth state stream
  Stream<CustomUser?> get user {
    return auth.authStateChanges().map(userFromFirebaseUser);
  }

  // Sign in anonymously
  Future<User?> signInAnon() async {
    try {
      UserCredential result = await auth.signInAnonymously();
      return result.user;
    } catch (e) {
      print("Error signing in anonymously: $e");
      return null;
    }
  }

  // ✅ Correct: Sign in with email and password
  Future<CustomUser?> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userFromFirebaseUser(result.user);
    } catch (e) {
      print("Sign-in error: $e");
      return null;
    }
  }

  // ✅ Correct: Register with email and password
  Future<CustomUser?> registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = result.user; // ✅ Extract the Firebase user

      if (user != null) {
        // ✅ Create a new entry in Realtime Database
        await DatabaseService(uid: user.uid).updateUserData('0', 'new crew member', 100);
        return userFromFirebaseUser(user);
      } else {
        print("User is null after registration.");
        return null;
      }
    } catch (e) {
      print("Registration error: $e");
      return null;
    }
  }


  // Sign out
  Future<void> signOut() async {
    try {
      await auth.signOut();
    } catch (e) {
      print("Sign-out error: $e");
    }
  }
}
