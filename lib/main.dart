import 'package:finalprojectfresh/provider/user_provider.dart';
import 'package:finalprojectfresh/responsive/mobile.dart';
import 'package:finalprojectfresh/responsive/web.dart';
import 'package:finalprojectfresh/shared/snakbar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'Responsive/Responsive.dart';
import 'features/splash_page/screens/splash_screen.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyCNy7eNZvhsXHeRjEFmaPfhMQ5o7YxQrEg",
            authDomain: "fcicommunity-ec828.firebaseapp.com",
            projectId: "fcicommunity-ec828",
            storageBucket: "fcicommunity-ec828.appspot.com",
            messagingSenderId: "75440737578",
            appId: "1:75440737578:web:dd0d88997a04be7d43e253"
        ));
  } else {
    await Firebase.initializeApp();
  }
  WidgetsFlutterBinding.ensureInitialized();


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        return UserProvider();
        },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light(),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ));
            } else if (snapshot.hasError) {
              return showSnackBar(context, "Something went wrong");
            } else if (snapshot.hasData) {
              return const Resposive(
                myMobileScreen: MobileScerren(),
                myWebScreen: WebScerren(),
              );
            } else {
              return const SplashScreen();
            }
          },
        ),

      ),
    );
  }
}
