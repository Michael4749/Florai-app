import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../tools/design.dart';
import 'auth_page.dart';
import 'sign_in_page.dart';
import '../config/widgets/my_textfield.dart';

class ForgotPass extends StatefulWidget {
  const ForgotPass({super.key});

  @override
  State<ForgotPass> createState() => _ForgotPassState();
}

class _ForgotPassState extends State<ForgotPass> {
  final emailController = TextEditingController();
  bool canResendEmail = true;

  @override
  void initState() {
    super.initState();
  }

  void forgotPass() async {
    // Check if the email field is empty
    if (emailController.text.isEmpty) {
      // Show an error dialog if the email field is empty
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          backgroundColor: Colors.red,
          title: Center(
            child: Text(
              'Please enter your email',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      );
    } else {
      try {
        // Disable the option to resend the password reset email while processing
        setState(() {
          canResendEmail = false;
        });

        // Send a password reset email using Firebase Authentication
        await FirebaseAuth.instance
            .sendPasswordResetEmail(email: emailController.text);

        // Show a success dialog indicating the reset email has been sent
        showDialog(
          context: context,
          builder: (context) => const AlertDialog(
            backgroundColor: Color.fromARGB(255, 41, 221, 86),
            title: Center(
              child: Text(
                'Password Reset Email Sent',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        );

        // Wait for 5 seconds before allowing the resend button again
        await Future.delayed(const Duration(seconds: 5));

        // Re-enable the resend option
        setState(() {
          canResendEmail = true;
        });

        // Navigate the user back to the authentication page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => AuthPage(),
          ),
        );
      } catch (e) {
        // Log any errors that occur during the password reset process
        log(e.toString());
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const SignIn(),
          ),
        );
        return false;
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
        resizeToAvoidBottomInset: false,
        body: Container(
          decoration: BoxDecoration(gradient: backgroundGradient),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/icons/Design_separator.png',
                    ),
                    SizedBox(height: 20),
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
                            'assets/icons/password_reset.png',
                          ),
                          const Text(
                            'Reset Password',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: color4,
                                fontSize: 35,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Enter the email associated with your account and we will send you a password reset request.',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: color4, fontSize: 20),
                          ),
                          const SizedBox(height: 20),
                          MyTextField(
                            controller: emailController,
                            obscureText: false,
                            prefixIcon: const Icon(Icons.mail_outlined),
                            label: 'Email Address',
                            color: color2,
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: forgotPass,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: color2,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 70, vertical: 8),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(13),
                              ),
                              side: const BorderSide(color: Color(0xFFD8E4FF)),
                            ),
                            child: Text(
                              'Send Link',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                                color: Color(0xFFD8E4FF),
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
}
