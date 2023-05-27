import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:opinion/components/button.dart';
import 'package:opinion/components/text_field.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({
    super.key,
    required this.onTap,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  void signIn() async {
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailTextController.text,
        password: passwordTextController.text,
      );

      if(context.mounted) Navigator.pop(context);
    } on FirebaseAuthException catch (error) {
      Navigator.pop(context);
      displayMessage(error.code);
    }
  }

  void displayMessage(dynamic message) {
    String errorMessage = "Unknown error occurred";
    if (message is FirebaseAuthException) {
      switch (message.code) {
        case "user-not-found":
          errorMessage = "User not found";
          break;
        case "wrong-password":
          errorMessage = "Wrong password";
          break;
        case "invalid-email":
          errorMessage = "Invalid email";
          break;
        default:
          errorMessage = "Unknown error occurred";
          break;
      }
    }
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(errorMessage),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'images/PRANS.png',
                  height: 150,
                  // width: 100,
                ),
                const Text(
                  "Welcome to PRANS Infotech.",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "This is the right place to pen down your thoughts",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                MyTextField(
                  controller: emailTextController,
                  hintText: "Email",
                  obscuretext: false,
                ),
                const SizedBox(
                  height: 10,
                ),
                MyTextField(
                  controller: passwordTextController,
                  hintText: "Password",
                  obscuretext: true,
                ),
                const SizedBox(
                  height: 15,
                ),
                MyButton(
                  onTap: signIn,
                  text: "Sign In",
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Not a member? "),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        "Register now",
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
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
