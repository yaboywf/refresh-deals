import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import '../pages/register3.dart';
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
          MaterialPageRoute(builder: (context) => SignupPage3(username: user.displayName ?? "ReFresher", uid: user.uid)),
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
          MaterialPageRoute(builder: (context) => SignupPage3(username: user.displayName ?? "ReFresher", uid: user.uid)),
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

  // get current user
  User? getCurrentUser() {
    return FirebaseAuth.instance.currentUser;
  }

  // get user information
  Future<dynamic> getUserInformation() async {
    if (getCurrentUser() == null) return Future.value(null);
    DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection('users').doc(getCurrentUser()!.uid).get();

    if (!snapshot.exists) {
      return Future.value(null);
    }

    return snapshot.data();
  }

  // update password
  Future<void> updatePassword(BuildContext context, String password) async {
    try {
      User? user = getCurrentUser();

      if (user != null) {
        await user.updatePassword(password);
      }
    } catch (e) {
      if (e is FirebaseAuthException) {
        String message = '';
        switch (e.code) {
          case 'invalid-password':
            {
              message = 'This is an invalid password. Please try again.';
              break;
            }
          case 'weak-password':
            {
              message = 'This is a weak password. Please try again.';
              break;
            }
          default:
            message = e.code;
        }

        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar(text: message, color: Colors.red, textColor: Colors.white));
      }
      debugPrint("Error updating password: $e");
    }
  }

  // update username

  Future<void> updateUsername(BuildContext context, String newUsername) async {
    try {
      User? user = getCurrentUser();

      if (user != null) {
        await FirebaseFirestore.instance.collection('users').doc(user.uid).update({'username': newUsername});
        await user.updateDisplayName(newUsername);
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar(text: 'Username updated successfully!', textColor: Colors.white));
      }
    } catch (e) {
      if (e is FirebaseAuthException) {
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar(text: e.code, color: Colors.red, textColor: Colors.white));
        debugPrint("Error updating username: $e");
      }
    }
  }

  // email verification
  Future<void> sendEmailVerification() async {
    try {
      User? user = getCurrentUser();

      if (user != null) {
        await user.sendEmailVerification();
      }
    } catch (e) {
      debugPrint("Error sending email verification: $e");
    }
  }
}
