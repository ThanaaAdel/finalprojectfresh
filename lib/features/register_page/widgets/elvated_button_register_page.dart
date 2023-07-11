import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../../../Responsive/Responsive.dart';
import '../../../firebase_services/auth.dart';
import '../../../responsive/mobile.dart';
import '../../../responsive/web.dart';
import '../../../shared/snakbar.dart';
class ElvatedButtomRegister extends StatefulWidget {
  const ElvatedButtomRegister({Key? key}) : super(key: key);

  @override
  State<ElvatedButtomRegister> createState() => _ElvatedButtomRegisterState();
}

class _ElvatedButtomRegisterState extends State<ElvatedButtomRegister> {
  @override
  Widget build(BuildContext context) {
    Uint8List? imgPath;
    String? imgName;
    final _formKey = GlobalKey<FormState>();
    bool isLoading = false;
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    bool doctor = false;
    final usernameController = TextEditingController();
    final ageController = TextEditingController();
    final titleController = TextEditingController();

    clickOnRegister() async {
      if (_formKey.currentState!.validate() &&
          imgName != null &&
          imgPath != null) {
        setState(() {
          isLoading = true;
        });

        await AuthMethods().register(
          userEmail: emailController.text,
          userPassword: passwordController.text,
          context: context,
          userTitle: titleController.text,
          userName: usernameController.text,
          imgName: imgName,
          imgPath: imgPath,
          doctor: doctor,
        );
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
      } else {
        showSnackBar(context, "ERROR");
      }
    }

    @override
    void dispose() {
      // TODO: implement dispose
      emailController.dispose();
      passwordController.dispose();

      usernameController.dispose();
      ageController.dispose();
      titleController.dispose();
      super.dispose();
    }
    return ElevatedButton(
      onPressed: () async {
        clickOnRegister();
      },
      style: ButtonStyle(
        // backgroundColor: MaterialStateProperty.all(BTNgreen),
        padding:
        MaterialStateProperty.all(const EdgeInsets.all(12)),
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8))),
      ),
      child: isLoading
          ? const CircularProgressIndicator(
        color: Colors.white,
      )
          : const Text(
        "Register",
        style: TextStyle(fontSize: 19),
      ),
    );
  }
}
