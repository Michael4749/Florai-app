import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lets_get_serious/Auth/sign_in_page.dart';
import 'package:lets_get_serious/main/nav.dart';
import 'dart:async';

import '../tools/design.dart';
import 'sign_up_page.dart';

class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({super.key});

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  final user = FirebaseAuth.instance.currentUser;
  bool isEmailVerified = false;
  Timer? timer;
  bool canResendEmail = true;

  Future sendVerificationEmail() async {
    try {
      // Check if the verification email can be resent (i.e., the flag is true)
      if (canResendEmail) {
        // Disable the ability to resend the verification email while the process is ongoing
        setState(() {
          canResendEmail = false;
        });

        // Get the current user from Firebase Authentication
        final user = FirebaseAuth.instance.currentUser!;

        // Send the email verification to the current user's email address
        await user.sendEmailVerification();
      }

      // Wait for 5 seconds before re-enabling the option to resend the email
      await Future.delayed(const Duration(seconds: 5));

      // Re-enable the resend option after the delay
      setState(() {
        canResendEmail = true;
      });
    } catch (e) {
      // Log any errors that occur during the process
      log(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    if (!isEmailVerified) {
      sendVerificationEmail();
      timer = Timer.periodic(
        const Duration(seconds: 3),
        (_) => checkEmailVerified(),
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
  }

  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });
    if (isEmailVerified) timer?.cancel();
  }

  @override
  Widget build(BuildContext context) => isEmailVerified
      ? const Nav(
          index: 0,
        )
      : PopScope(
          canPop: false,
          onPopInvoked: (bool value) async {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const SignUp(),
              ),
            );
          },
          child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: color4,
                ),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignIn(),
                    ),
                  );
                },
              ),
              backgroundColor: backgroundGradientColor1,
            ),
            body: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(gradient: backgroundGradient),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/icons/Design_separator.png',
                  ),
                  const SizedBox(height: 25),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: color4),
                      gradient: secondaryGradient,
                    ),
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/icons/email_verify.png',
                        ),
                        const Text(
                          'Confirm Email',
                          style: TextStyle(
                              fontSize: 35,
                              color: color4,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 15),
                        user!.email != null
                            ? Text(
                                'We have sent a verification link to ${user!.email}. Please check your inbox and spam folders.',
                                style: const TextStyle(
                                  fontSize: 20,
                                  color: color4,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              )
                            : Text(
                                'Error sending email. Please try again',
                                style: const TextStyle(
                                    fontSize: 20, color: color4),
                                textAlign: TextAlign.center,
                              ),
                        const SizedBox(height: 35),
                        SizedBox(
                            height: 50,
                            width: 50,
                            child: CircularProgressIndicator(
                              color: color4,
                            )),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: color2,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text('Didn’t get it?',
                                  style: TextStyle(
                                    color: color4,
                                    fontSize: 17,
                                  )),
                              TextButton(
                                onPressed: sendVerificationEmail,
                                child: Text(
                                  'Resend Code',
                                  style: TextStyle(
                                    color: color4,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
}
