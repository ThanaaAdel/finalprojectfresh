import 'package:flutter/material.dart';

import '../../../shared/colors.dart';
import '../../login_page/screens/Login_page.dart';
class DoNotHaveAccountRegister extends StatelessWidget {
  const DoNotHaveAccountRegister({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return    Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Do not have an account?",
            style:
            TextStyle(fontSize: 18, color: kSecondaryColor)),
        TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const Login()),
              );
            },
            child: const Text('sign in',
                style: TextStyle(
                    fontSize: 18,
                    decoration: TextDecoration.underline))),
      ],
    );
  }
}
