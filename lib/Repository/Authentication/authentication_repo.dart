import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationRepo {
  final FirebaseAuth _firebaseAuth;
  AuthenticationRepo({FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  Future<AuthResult> registerUser(
      String email, String password, String name, String address) async {
    AuthResult result = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    FirebaseUser user = result.user;
    Firestore.instance.collection('users').document(user.uid).setData(
      {
        'firstName': name,
        'address': address,
      },
    );

    return result;
  }

  Future<AuthResult> logInUser(String email, String password) async {
    return await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future logOutUser() async {
    await _firebaseAuth.signOut();
  }

  Future<FirebaseUser> getUser() async {
    return await _firebaseAuth.currentUser();
  }
}
