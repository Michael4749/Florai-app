import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lets_get_serious/main/nav.dart';
import '../services/auth_service.dart';
import '../tools/design.dart';
import 'forgot_pass_page.dart';
import 'sign_up_page.dart';
import 'verify_email_page.dart';
import '../config/widgets/my_textfield.dart';
import '../config/widgets/pass_text_custom_widget.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> with SingleTickerProviderStateMixin {
  bool canPop = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _showErrorMessage(String msg) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.red,
          title: Center(
            child: Text(
              msg,
              style: const TextStyle(color: Color(0xFFFFFFFF)),
            ),
          ),
        );
      },
    );
  }

  Future<void> _signUserIn() async {
    // Retrieve and trim the email and password entered by the user
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    // Check if either email or password is empty, if so show an error message and exit
    if (email.isEmpty || password.isEmpty) {
      _showErrorMessage('Please fill all fields');
      return;
    }

    try {
      // Attempt to sign in the user using Firebase Authentication
      final userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Retrieve the user object from the signed-in credentials
      final user = userCredential.user;

      // Check if the user exists
      if (user != null) {
        // If the user is signed in and their email is verified, navigate to the home page
        if (user.emailVerified) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const Nav(index: 0),
            ),
          );
        } else {
          // If the email is not verified, navigate to the email verification page
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const VerifyEmailPage(),
            ),
          );
        }
      } else {
        // If the user does not exist in the system, show an error message
        _showErrorMessage('User does not exist');
      }
    } catch (e) {
      // If an error occurs during the sign-in process, display a generic error message
      _showErrorMessage('Error signing in');
    }
  }


  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (bool value) async {
        exit(0);
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
            minWidth: MediaQuery.of(context).size.width,
          ),
          child: Container(
            decoration: BoxDecoration(gradient: backgroundGradient),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                Image.asset(
                  'assets/icons/log_in.png',
                ),
                const SizedBox(height: 120),
                MyTextField(
                  controller: emailController,
                  label: 'Email Address',
                  obscureText: false,
                  prefixIcon: const Icon(
                    Icons.mail_outlined,
                    size: 30,
                  ),
                ),
                const SizedBox(height: 25),
                PassTextField(
                  controller: passwordController,
                  label: 'Password',
                  obscureText: true,
                  prefixIcon: const Icon(
                    Icons.lock_outline,
                    size: 30,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 17),
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ForgotPass(),
                            ),
                          );
                        },
                        child: const Text(
                          'Forgot Password',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: color4,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: _signUserIn,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: color2,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 70, vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(13),
                    ),
                    side: const BorderSide(color: Color(0xFFD8E4FF)),
                  ),
                  child: Text(
                    'Log In',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: Color(0xFFD8E4FF),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Or',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: color4,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignUp(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: color2,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 65, vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(13),
                    ),
                    side: const BorderSide(color: color4),
                  ),
                  child: Text(
                    'Sign up',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: color4,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        AuthService().signInWithGoogle();
                      },
                      icon: Image.asset(
                        'assets/icons/google.png',
                        height: 60,
                        width: 60,
                        scale: 0.9,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
