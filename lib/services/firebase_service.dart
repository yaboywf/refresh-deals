import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {
  // register
  Future<UserCredential> register(email, password) {
    return FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
  }

  // login
  Future<UserCredential> login(email, password) {
    return FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
  }

  // forget password
  Future<void> forgetPassword(email) {
    return FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }

  // logout
  Future<void> logout() {
    return FirebaseAuth.instance.signOut();
  }
}
