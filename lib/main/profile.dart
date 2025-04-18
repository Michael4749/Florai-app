import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../Auth/auth_page.dart';
import '../tools/design.dart';
import 'nav.dart';
import 'welcome_page.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final user = FirebaseAuth.instance.currentUser!;
  bool isGoogle = FirebaseAuth.instance.currentUser?.providerData
          .any((provider) => provider.providerId == 'google.com') ??
      false;

  bool canResendEmail = true;

  void logOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const WelcomePage(),
      ),
    );
  }

  void updatePassword() async {
    try {
      if (canResendEmail) {
        setState(() {
          canResendEmail = false;
        });
        await FirebaseAuth.instance
            .sendPasswordResetEmail(email: user.email.toString());
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: color2,
            title: Center(
              child: Text(
                'Reset Password',
                style: TextStyle(color: Colors.white),
              ),
            ),
            actions: [
              Column(
                spacing: 10,
                children: [
                  Text(
                    'We have sent a password reset link to your email at ${user.email}. Please check your inbox, trash, and spam folders.',
                    style: TextStyle(color: Colors.white),
                  ),
                  _actionButton('OK', () {
                    Navigator.of(context).pop();
                  })
                ],
              ),
            ],
          ),
        );
        Future.delayed(const Duration(seconds: 1)).then(
          (value) => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => AuthPage(),
            ),
          ),
        );
      }
      await Future.delayed(const Duration(seconds: 5));
      setState(() {
        canResendEmail = true;
      });
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  'Me',
                  style: TextStyle(color: color4),
                ),
              ],
            ),
            Divider(thickness: 3, color: color4),
          ],
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: color4,
          ),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const Nav(
                  index: 0,
                ),
              ),
            );
          },
        ),
        backgroundColor: backgroundGradientColor1,
      ),
      backgroundColor: Colors.blueGrey[900],
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height / 2,
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: backgroundGradient,
            borderRadius: BorderRadius.all(Radius.circular(20)),
            border: Border.all(color: color4),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              user.photoURL == null
                  ? ClipRRect(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(150)),
                      child: Image.asset('assets/icons/icon.png'))
                  : ClipRRect(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(150)),
                      child: Image.network(user.photoURL!),
                    ),
              const SizedBox(height: 10),
              Text(
                user.displayName!,
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Visibility(
                    visible: !isGoogle,
                    child: _actionButton(
                      'Reset Password',
                      () {
                        updatePassword();
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  _actionButton(
                    'Log out',
                    () {
                      logOut(context);
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 2,
                        color: color4,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        'Stats',
                        style: TextStyle(
                            fontSize: 20,
                            color: color4,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 2,
                        color: color4,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Plants',
                    style: TextStyle(
                      color: color4,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    '5',
                    style: TextStyle(
                      color: color4,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ), //!plants.length.toString(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _actionButton(String text, void Function()? pressCallback) {
    return ElevatedButton(
      onPressed: pressCallback,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(13),
        ),
        side: const BorderSide(color: color4),
        backgroundColor: color2,
      ),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
          color: color4,
        ),
      ),
    );
  }

  Widget _statBox(String title, String value) {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Colors.white12,
            border: Border.all(color: color4),
            borderRadius: BorderRadius.circular(150),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    color: color4,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(child: Divider(color: color4)),
              Expanded(
                child: Text(
                  value,
                  style: const TextStyle(
                    fontSize: 15,
                    color: color4,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
