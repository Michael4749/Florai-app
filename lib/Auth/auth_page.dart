import 'package:lets_get_serious/main/welcome_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../services/database.dart';
import 'verify_email_page.dart';
import 'sign_in_page.dart';
import '../main/nav.dart';

// ignore: must_be_immutable
class AuthPage extends StatelessWidget {
  AuthPage({super.key});

  bool firstTime = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          DataBase(
            name: 'mrwan',
            email: 'mrwanahmedplaker@gmail.com',
            password: '123123',
          ).connection();
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (FirebaseAuth.instance.currentUser != null) {
            if (snapshot.hasData) {
              var user = snapshot.data;
              if (user != null &&
                  user.providerData.any((provider) =>
                      provider.providerId == 'google.com' ||
                      provider.providerId == 'facebook.com' ||
                      provider.providerId == 'apple.com')) {
                return const Nav(
                  index: 0,
                );
              }
              if (user != null && user.emailVerified) {
                return const Nav(
                  index: 0,
                );
              } else if (user != null && !(user.emailVerified)) {
                return const VerifyEmailPage();
              }
            }
          }
          firstTime ? const WelcomePage() : const SignIn();
          firstTime = false;
          return const SignIn();
        },
      ),
    );
  }
}
