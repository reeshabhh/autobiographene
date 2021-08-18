// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

@immutable
class UserFirebase {
  final String uid;
  const UserFirebase(this.uid);
}

class FirebaseAuthService {
  late User userNew;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  UserFirebase _userFromFirebase(User? user) => UserFirebase(user!.uid);

  Stream<UserFirebase> get onAuthStateChanged =>
      _firebaseAuth.authStateChanges().map(
            (event) => _userFromFirebase(userNew),
          );

  Future<UserFirebase> signInAnonymously() async {
    final authResult = await _firebaseAuth.signInAnonymously();
    return _userFromFirebase(authResult.user);
  }

  Future<void> signOut() async {
    return await _firebaseAuth.signOut();
  }

  Future? sighInWithEmailPass(String email, String password) async
  // {
  // String email = '';
  // String password= '';
  // if (_firebaseAuth.currentUser != null) {
  // return
  // =>
  {
    try {
      return await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      // UserCredential? userEmailPass = await _firebaseAuth
      //     .signInWithEmailAndPassword(email: email, password: password);
      // return userEmailPass;
      // UserCredential nesj;
      // return userEmailPass ?? nesj;

      // }
      //  return _userFromFirebase(authEmailPassResult.user);
      // }
    } catch (e) {
      return null;
      // UserCredential nullUser;
      // return nullUser;
    }

    ;
  }
}
