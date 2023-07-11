
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

import '../../gpa/screens/gpa_screen.dart';
import '../../login_page/screens/Login_page.dart';
import '../../maps/slider.dart';
import '../../settings/widgets/SettingList.dart';
import '../screens/home_page.dart';
import 'DisplayEmail.dart';
import 'displayname.dart';
class DrawerDataHome extends StatelessWidget {
  const DrawerDataHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return           Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            const UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/coll1.jpg"),
                    fit: BoxFit.cover),
              ),
              accountName: DisplayName(),
              accountEmail: DisplayEmail(),
              currentAccountPictureSize: Size.square(99),

            ),
            ListTile(
                title: const Text("Home"),
                leading: const Icon(Icons.home),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Home(
                        uid: FirebaseAuth.instance.currentUser!.uid,
                      ),
                    ),
                  );
                }),
            ListTile(
                title: const Text("Regulation"),
                leading: const Icon(Icons.book),
                onTap: () {
                  Share.share(
                      'http://mu.menofia.edu.eg/PrtlFiles/Faculties/fci/Portal/Files/%D9%84%D8%A7%D8%A6%D8%AD%D8%A9%20%D8%AD%D8%A7%D8%B3%D8%A8%D8%A7%D8%AA%20%D8%A7%D9%84%D9%85%D9%86%D9%88%D9%81%D9%8A%D8%A9%20%D8%A7%D9%84%D9%86%D8%B3%D8%AE%D8%A9%20%D8%A7%D9%84%D9%85%D8%B9%D8%AF%D9%84%D8%A9-1.pdf',
                      subject: 'Regulation');
                }),
            ListTile(
                title: const Text("Maps"),
                leading: const Icon(Icons.maps_ugc_sharp),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>const CarouselClass(),
                    ),
                  );
                }),
            ListTile(
                title: const Text("Setting"),
                leading: const Icon(Icons.help_center),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SettingList(),
                    ),
                  );
                }),
            ListTile(
                title: const Text("Calc gpa"),
                leading: const Icon(Icons.calculate),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const GPACalc(),
                    ),
                  );
                }),
            ListTile(
                title: const Text("Logout"),
                leading: const Icon(Icons.exit_to_app),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Login(),
                    ),
                  );
                }),
          ],
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 12),
          child: const Text("Developed by sanaa adel © 2022",
              style: TextStyle(fontSize: 16)),
        )
      ],
    );
  }
}
