import 'package:flutter/material.dart';
import 'package:finalprojectfresh/features/login_page/screens/Login_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void splashScreenFunction() async {
    await Future.delayed(const Duration(seconds: 2));
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return   const Login();
      },
    ));
  }

  @override
  void initState() {
    super.initState();
    splashScreenFunction();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Image.asset('assets/images/splash.jpg',width: double.infinity , fit: BoxFit.cover),
    );
  }
}