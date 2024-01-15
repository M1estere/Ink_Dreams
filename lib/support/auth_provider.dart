import 'package:firebase_auth/firebase_auth.dart';

Future<int> registerUser(String email, String password, String nickname) async {
  try {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
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
  return 0;
}

Future<int> signIn(String email, String password) async {
  try {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
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

  return 0;
}
