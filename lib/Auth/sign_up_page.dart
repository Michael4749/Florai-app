import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lets_get_serious/main/nav.dart';
import '../services/auth_service.dart';
import '../tools/design.dart';
import 'auth_page.dart';
import 'sign_in_page.dart';
import 'verify_email_page.dart';
import '../config/widgets/my_textfield.dart';
import '../config/widgets/pass_text_custom_widget.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> with SingleTickerProviderStateMixin {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void signUserUp() async {
    // Retrieve and trim the input fields (name, email, password, confirmPassword)
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();

    // Check if any of the input fields are empty, and show an error if true
    if (name.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      _showErrorDialog('Please fill all fields');
      return; // Exit the function if any fields are empty
    }

    // Check if the password and confirm password fields match, and show an error if they don't
    if (password != confirmPassword) {
      _showErrorDialog('Passwords do not match');
      return; // Exit the function if passwords don't match
    }

    try {
      // Attempt to create a new user with Firebase Authentication
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      // Retrieve the user object after successful sign-up
      User? user = userCredential.user;

      // If the user is not null, update the user's display name and reload the user data
      if (user != null) {
        await user.updateDisplayName(name);
        await user.reload(); // Reload to update the user's display name
      }

      // Check if the user exists and if their email is verified
      if (user != null && user.emailVerified) {
        // If email is verified, navigate to the home page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Nav(index: 0)),
        );
      } else {
        // If email is not verified, navigate to the email verification page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const VerifyEmailPage()),
        );
      }
    } catch (e) {
      // Catch any errors that occur during the sign-up process and show an error dialog
      _showErrorDialog('Sign Up Failed');
    }
  }


  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.red,
        title: Center(
          child: Text(
            message,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (bool value) async {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const SignIn(),
          ),
        );
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: Container(
            decoration: BoxDecoration(gradient: backgroundGradient),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                Image.asset(
                  'assets/icons/sign_up.png',
                  height: 150,
                ),
                const SizedBox(height: 80),
                MyTextField(
                  controller: nameController,
                  label: 'Name',
                  obscureText: false,
                  prefixIcon: const Icon(
                    Icons.person,
                    size: 30,
                  ),
                ),
                const SizedBox(height: 15),
                MyTextField(
                  controller: emailController,
                  label: 'Email Address',
                  obscureText: false,
                  prefixIcon: const Icon(
                    Icons.mail_outlined,
                    size: 30,
                  ),
                ),
                const SizedBox(height: 15),
                PassTextField(
                  controller: passwordController,
                  label: 'Password',
                  obscureText: true,
                  prefixIcon: const Icon(
                    Icons.lock_outline,
                    size: 30,
                  ),
                ),
                const SizedBox(height: 15),
                PassTextField(
                  controller: confirmPasswordController,
                  label: 'Confirm Password',
                  obscureText: true,
                  prefixIcon: const Icon(
                    Icons.lock_outline,
                    size: 30,
                  ),
                ),
                const SizedBox(height: 25),
                ElevatedButton(
                  onPressed: signUserUp,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: color2,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 65, vertical: 8),
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
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignIn(),
                      ),
                    );
                  },
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () async {
                        var google = await AuthService().signInWithGoogle();
                        if (google != null) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AuthPage(),
                            ),
                          );
                        }
                      },
                      icon: Image.asset(
                        'assets/icons/google.png',
                        height: 80,
                        width: 80,
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
