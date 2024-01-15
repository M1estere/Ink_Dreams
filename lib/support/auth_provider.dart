import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthUser {
  final String id;
  final String email;

  const AuthUser({
    required this.id,
    required this.email,
  });

  factory AuthUser.fromFirebase(User user) => AuthUser(
        id: user.uid,
        email: user.email!,
      );
}

Future<int> registerUser(String email, String password, String nickname) async {
  try {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final user = currentUser;
    if (user != null) {
      await FirebaseFirestore.instance.collection('users').doc(user.id).set(
        {
          'id': user.id,
          'email': user.email,
          'nickname': nickname,
        },
      );

      return 0;
    } else {
      return 4;
    }
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      return 1;
    } else if (e.code == 'email-already-in-use') {
      return 2;
    } else if (e.code == 'invalid-email') {
      return 3;
    } else {
      return 4;
    }
  } catch (e) {
    return 4;
  }
}

AuthUser? get currentUser {
  final user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    return AuthUser.fromFirebase(user);
  } else {
    return null;
  }
}

Future<int> signIn(String email, String password) async {
  try {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    final user = currentUser;
    if (user != null) {
      return 0;
    } else {
      return 4;
    }
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      return 1;
    } else if (e.code == 'wrong-password') {
      return 2;
    } else if (e.code == 'invalid-email') {
      return 3;
    } else {
      return 4;
    }
  } catch (e) {
    return 3;
  }
}

Future<int> signOut() async {
  final user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    FirebaseAuth.instance.signOut();
    return 0;
  } else {
    return 1;
  }
}

bool userLogged() {
  bool checker = true;
  FirebaseAuth.instance.authStateChanges().listen((event) {
    if (event == null) {
      checker = false;
    } else {
      checker = true;
    }
  });

  return checker;
}
