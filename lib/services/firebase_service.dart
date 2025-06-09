import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import '../pages/register2.dart';
import '../widgets/snackbar.dart';

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

  // sign in with google
  Future<dynamic> signInWithGoogle(BuildContext context) async {
    try {
      final clientId = '34765062812-9gner2mm53chvt1cicj3t8ihv1o98toi.apps.googleusercontent.com';
      GoogleSignInAccount? googleUser = await GoogleSignIn(clientId: clientId).signIn();
      GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      if (googleUser == null || googleAuth == null) {
        debugPrint('Google sign-in was aborted or failed.');
        return;
      }

      OAuthCredential credential = GoogleAuthProvider.credential(accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
      final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      final User? user = userCredential.user;

      if (user == null) {
        debugPrint('Google Sign-In failed: user is null.');
        return null;
      }

      final DocumentSnapshot userDocument = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      if (userDocument.exists) {
        if (!context.mounted) return;
        Navigator.pushReplacementNamed(context, '/${userDocument['accountType']}_home');
      } else {
        if (!context.mounted) return;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => SignupPage2(username: user.displayName ?? "ReFresher", uid: user.uid)),
        );
      }
    } catch (e) {
      debugPrint('Google Sign-In failed: $e');
      return null;
    }
  }

  // sign in with github
  Future<dynamic> signInWithGithub(BuildContext context) async {
    try {
      final GithubAuthProvider provider = GithubAuthProvider();
      UserCredential userCredential = await FirebaseAuth.instance.signInWithPopup(provider);
      User? user = userCredential.user;

      if (user == null) {
        debugPrint('Github Sign-In failed: user is null.');
        return null;
      }

      final DocumentSnapshot userDocument = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      if (userDocument.exists) {
        if (!context.mounted) return;
        Navigator.pushReplacementNamed(context, '/${userDocument['accountType']}_home');
      } else {
        if (!context.mounted) return;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => SignupPage2(username: user.displayName ?? "ReFresher", uid: user.uid)),
        );
      }
    } catch (e) {
      debugPrint('Github Sign-in failed: $e');
      if (e is FirebaseAuthException && e.code == 'account-exists-with-different-credential') {
        if (!context.mounted) return;
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(CustomSnackBar(text: 'This email is already registered. Please login.', color: Colors.red, textColor: Colors.white));
      }
      return null;
    }
  }

  // get auth user 
  Stream<User?> getAuthUser() {
    return FirebaseAuth.instance.authStateChanges();
  }

  // get current user
  User? getCurrentUser() {
    return FirebaseAuth.instance.currentUser;
  }

  Future<dynamic> getUserInformation() {
    if (getCurrentUser() == null) return Future.value(null);
    return FirebaseFirestore.instance.collection('users').doc(getCurrentUser()!.uid).get();
  }
}
