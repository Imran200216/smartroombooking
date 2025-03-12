import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:smartroombooking/core/helper/toast_helper.dart';

class GoogleSignInProvider extends ChangeNotifier {
  /// web client ids
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId:
        dotenv.env['ENV'] == "prod"
            ? dotenv.env['PROD_WEB_CLIENT_ID']
            : dotenv.env['DEV_WEB_CLIENT_ID'],
  );

  GoogleSignInAccount? _user;
  bool _isLoading = false;

  GoogleSignInAccount? get user => _user;

  bool get isLoading => _isLoading;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  // Sign in with Google
  Future<void> signInWithGoogle(BuildContext context) async {
    _setLoading(true);
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        _setLoading(false);
        return;
      }

      _user = googleUser;
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the Google credential
      await FirebaseAuth.instance.signInWithCredential(credential).then((
        _,
      ) async {
        // Success message after Google Sign-In
        ToastHelper.showSuccessToast(
          context: context,
          message: "Google Sign In Successful!",
        );

        // Store the user data in Fire store
        await FirebaseFirestore.instance.collection("users").doc().set({
          "userEmail": googleUser.email,
          // Store email from Google SignIn
          "userUID": FirebaseAuth.instance.currentUser!.uid,
          // Store UID from Firebase
        });
      });
    } catch (e) {
      print('Error signing in with Google: $e');
      ToastHelper.showErrorToast(
        context: context,
        message: "Google Sign In Not Successful!",
      );
    } finally {
      _setLoading(false);
    }
  }

  // Sign out
  Future<void> logout(BuildContext context) async {
    _setLoading(true);
    try {
      await _googleSignIn.disconnect();
      await FirebaseAuth.instance.signOut();
      _user = null;

      // Show success toast
      ToastHelper.showSuccessToast(
        context: context,
        message: "Logout Successful",
      );
    } catch (e) {
      // Show error toast
      ToastHelper.showErrorToast(
        context: context,
        message: "Error signing out: $e",
      );
    } finally {
      _setLoading(false);
    }
  }

  // Check authentication state
  Future<bool> isUserSignedIn() async {
    return FirebaseAuth.instance.currentUser != null;
  }
}
