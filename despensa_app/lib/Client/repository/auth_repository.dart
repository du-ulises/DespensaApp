import 'package:firebase_auth/firebase_auth.dart';
import 'package:despensaapp/Client/repository/firebase_auth_api.dart';

class AuthRepository {
  final _firebaseAuthAPI = FirebaseAuthAPI();

  Future<FirebaseUser> signInFirebase() => _firebaseAuthAPI.signInWithGoogle();

  signOut() => _firebaseAuthAPI.signOut();

}