import 'package:firebase_auth/firebase_auth.dart' as fb;

class CustomUser {
  final String uid;
  CustomUser({required this.uid});
}

class AuthService {
  final fb.FirebaseAuth _auth = fb.FirebaseAuth.instance;

  // Create custom user object from Firebase User
  CustomUser? userFromFirebaseUser(fb.User? user) {
    return user != null ? CustomUser(uid: user.uid) : null;
  }

  // Sign in anonymously
  Future<CustomUser?> signInAnon() async {
    try {
      fb.UserCredential result = await _auth.signInAnonymously();
      fb.User? user = result.user;
      return userFromFirebaseUser(user);
    } catch (e) {
      print("Error signing in anonymously: $e");
      return null;
    }
  }
}
