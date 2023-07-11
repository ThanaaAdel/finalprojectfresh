import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../Responsive/Responsive.dart';
import '../../../responsive/mobile.dart';
import '../../../responsive/web.dart';
import '../../../shared/snakbar.dart';
class ElevatedButtonLogin extends StatefulWidget {
  const ElevatedButtonLogin({Key? key}) : super(key: key);

  @override
  State<ElevatedButtonLogin> createState() => _ElevatedButtonLoginState();
}

class _ElevatedButtonLoginState extends State<ElevatedButtonLogin> {
  bool isVisable = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;



  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    signIn() async {
      setState(() {
        isLoading = true;
      });

      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailController.text, password: passwordController.text);

        if (!mounted) return;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => const Resposive(
                  myMobileScreen: MobileScerren(), myWebScreen: WebScerren())),
        );
      } on FirebaseAuthException catch (e) {
        showSnackBar(context, "ERROR :  ${e.code} ");
      }

      setState(() {
        isLoading = false;
      });
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => const Resposive(
                myMobileScreen: MobileScerren(), myWebScreen: WebScerren())),
      );
    }
    return  ElevatedButton(
      onPressed: () async {
        await signIn();
        if (!mounted) return;
        showSnackBar(
            context, "successfully sign-in ☺");
      },
      style: ButtonStyle(
        padding: MaterialStateProperty.all(
            const EdgeInsets.all(12)),
        shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
                borderRadius:
                BorderRadius.circular(8))),
      ),
      child: isLoading
          ? const CircularProgressIndicator(
        color: Colors.white,
      )
          : const Text(
        "Sign in",
        style: TextStyle(fontSize: 19),
      ),
    );
  }
}
