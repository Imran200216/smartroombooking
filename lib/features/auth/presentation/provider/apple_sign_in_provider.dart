import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:smartroombooking/core/helper/toast_helper.dart';

class AppleSignInProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  /// Sign in with Apple
  Future<void> signInWithApple(BuildContext context) async {
    _setLoading(true);
    try {
      // Perform the sign-in request
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      // Convert to Firebase OAuth credential
      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: credential.identityToken,
        accessToken: credential.authorizationCode,
      );

      // Sign in with Firebase
      UserCredential userCredential = await _auth.signInWithCredential(
        oauthCredential,
      );
      User? user = userCredential.user;

      if (user != null) {
        // Store user details in Firestore
        await FirebaseFirestore.instance.collection("users").doc(user.uid).set({
          "userEmail": user.email ?? "",
          "userUID": user.uid,
          "displayName": credential.givenName ?? "Apple User",
        }, SetOptions(merge: true));

        // Show success toast
        ToastHelper.showSuccessToast(
          context: context,
          message: "Sign-in successful",
        );
      }

      notifyListeners();
    } catch (e) {
      ToastHelper.showErrorToast(
        context: context,
        message: "Apple Sign-In Failed",
      );
    } finally {
      _setLoading(false);
    }
  }
}
