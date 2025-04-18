import 'dart:developer';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  Future<UserCredential?> signInWithGoogle() async {
    print('Starting Google Sign-In...');

    final GoogleSignIn googleSignIn =
        GoogleSignIn(scopes: ['email', 'profile']);
    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser == null) {
        return null; // User canceled the sign-in
      }


      // Fetch the authentication details from Google
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential for Firebase authentication
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the credential
      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);


      return userCredential;
    } catch (error) {
      // Catch any errors and print them
      log('Error during Google Sign-In: $error');
      return null;
    }
  }
}
