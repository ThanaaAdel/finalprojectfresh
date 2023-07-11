import 'package:flutter/material.dart';
import 'package:finalprojectfresh/features/forget_password_page/screens/Forget_Password_page.dart';
import 'package:finalprojectfresh/features/register_page/screens/register_page.dart';
import 'package:lottie/lottie.dart';
import '../../register_page/widgets/custom_login_text_field.dart';
import '../../register_page/widgets/gaps.dart';
import '../widgets/elvated_button_login_widget.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isVisable = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final double widthScreen = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.blueGrey,
        body: Stack(
          children: [
            Container(
              constraints: const BoxConstraints.expand(),
              child: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Lottie.asset('assets/lottie1.json')),
                      const Text(
                        "Fresh Academy",
                        style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                            fontFamily: "myfont"),
                      ),
                      Center(
                        child: Padding(
                          padding: widthScreen > 600
                              ? EdgeInsets.symmetric(
                                  horizontal: widthScreen * .3)
                              : const EdgeInsets.all(33.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CustomLoginTextField(
                                iconSuffix: const Icon(Icons.email),
                                textInputType: TextInputType.text,
                                obscureText: false,
                                stringInTextField: "Enter your Email",
                                typeController: emailController,
                              ),
                              CustomLoginTextField(
                                iconSuffix: const Icon(Icons.lock),
                                textInputType: TextInputType.text,
                                obscureText: true,
                                stringInTextField: "Enter your password",
                                typeController: passwordController,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text("Do you Forget Password ?",
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.white)),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                              const ForgetPassword()),
                                        );
                                      },
                                      child: const Text('Forget Password',
                                          style: TextStyle(
                                              fontSize: 15,
                                              decoration:
                                              TextDecoration.underline))),
                                ],
                              ),
                              Gaps.vGap20,
                              const ElevatedButtonLogin(),
                             Gaps.vGap10,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text("Do not have an account?",
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.white)),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const Register()),
                                        );
                                      },
                                      child: const Text('sign up',
                                          style: TextStyle(
                                              fontSize: 18,
                                              decoration:
                                                  TextDecoration.underline))),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ]),
              ),
            ),
          ],
        ));
  }
}
