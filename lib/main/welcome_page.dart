import 'package:flutter/material.dart';
import 'dart:io';

import '../Auth/auth_page.dart';
import '../tools/design.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  bool canPop = false;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: canPop,
      onPopInvoked: (bool value) async {
        exit(0);
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          decoration: BoxDecoration(gradient: backgroundGradient),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/icons/icon.png',
              ),
              Center(
                child: Text(
                  'Welcome!',
                  style: TextStyle(
                    fontSize: 47,
                    color: Color(0xFFD8E4FF),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AuthPage(),
                    ),
                  );
                },
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
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AuthPage(),
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
                  side: const BorderSide(color: Color(0xFFD8E4FF)),
                ),
                child: Text(
                  'Sign up',
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
      ),
    );
  }
}
