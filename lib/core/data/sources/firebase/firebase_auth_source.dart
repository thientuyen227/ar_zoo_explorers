import 'dart:convert';
import 'dart:math';

import 'package:ar_zoo_explorers/core/exceptions.dart';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

// Generates a cryptographically secure random nonce, to be included in a credential request.
String generateNonce([int length = 32]) {
  const charset =
      '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
  final random = Random.secure();
  return List.generate(length, (_) => charset[random.nextInt(charset.length)])
      .join();
}

/// Returns the sha256 hash of [input] in hex notation.
String sha256ofString(String input) {
  final bytes = utf8.encode(input);
  final digest = sha256.convert(bytes);
  return digest.toString();
}

class FirebaseAuthSource {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<UserCredential> createUserWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      return await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException {
      rethrow;
    } catch (e) {
      throw UnknownException(e);
    }
  }

  Future<UserCredential> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      return await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException {
      rethrow;
    } catch (e) {
      throw UnknownException(e);
    }
  }

  Future<UserCredential> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      // Once signed in, return the UserCredential
      return await _firebaseAuth.signInWithCredential(credential);
    } catch (e) {
      rethrow;
    }
  }

  Future<UserCredential> signInWithFacebook() async {
    //Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    //create credential from the access token
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);
    //Once signed in,  return the UserCredential
    return _firebaseAuth.signInWithCredential(facebookAuthCredential);
  }

  Future<UserCredential> reauthenticateWithCredential(UserCredential user) {
    late AuthCredential authProvice;
    switch (user.credential!.signInMethod) {
      case "password":
        authProvice = EmailAuthProvider.credential(
            email: user.user!.email!, password: "123456789");
        break;
      case "google.com":
        authProvice = GoogleAuthProvider.credential(
            accessToken: user.credential!.accessToken);
        break;
      case "facebook.com":
        authProvice =
            FacebookAuthProvider.credential(user.credential!.accessToken!);
        break;
    }
    return user.user!.reauthenticateWithCredential(authProvice);
  }

  Future<void> logout() async {
    return await _firebaseAuth.signOut();
  }
}
