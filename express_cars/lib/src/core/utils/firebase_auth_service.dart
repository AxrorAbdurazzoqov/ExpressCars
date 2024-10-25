import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseService {
  static final FirebaseService _instance = FirebaseService.init();
  static FirebaseService get instance => _instance;
  FirebaseService.init();

  Future<void> signInWithGoogle({required VoidCallback onSuccess, required VoidCallback onError}) async {
    try {
      await GoogleSignIn().disconnect();

      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential).whenComplete(onSuccess);
    } catch (e) {
      onError();
    }
  }

  Future<void> signInAsGuest({required VoidCallback onSuccess, required VoidCallback onError}) async {
    try {
      await FirebaseAuth.instance.signInAnonymously().whenComplete(onSuccess);
    } catch (e) {
      onError();
    }
  }

  Future<void> createAccountWithEmail({required String email, required String password, required String username, required VoidCallback onSuccess, required VoidCallback onFailure}) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      await FirebaseAuth.instance.currentUser!.updateDisplayName(username).whenComplete(onSuccess);
    } catch (e) {
      onFailure();
    }
  }

  Future<void> signInWithEmail({required String email, required String password, required VoidCallback onSuccess, required VoidCallback onError}) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).whenComplete(onSuccess);
    } catch (e) {
      onError();
    }
  }
}
