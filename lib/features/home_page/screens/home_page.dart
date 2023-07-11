import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:finalprojectfresh/shared/colors.dart';
import 'package:finalprojectfresh/features/post_design_home_page/screens/information_of_home_post.dart';
import '../../chat_page/auth/login_page.dart';
import '../widgets/add_post_home_widgets.dart';
import '../widgets/drawer_data.dart';
class Home extends StatefulWidget {
  final String uid;
  const Home({Key? key, required this.uid}) : super(key: key);
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map userDate = {};
  bool isLoading = true;
  int postCount = 0;
  getData() async {
    // Get data from DB

    setState(() {
      isLoading = true;
    });
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance
              .collection('users')
              .doc(
                widget.uid,
              )
              .get();

      userDate = snapshot.data()!;
    } catch (e) {
      print(e.toString());
    }

    setState(() {
      isLoading = false;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 218, 216, 216),
        floatingActionButton:
        const AddPostHomeWidgets(),
        drawer: Drawer(
          width: MediaQuery.of(context).size.width * 0.70,
          backgroundColor: appbarbluegray,
          child:
          const DrawerDataHome(),
        ),
        appBar: MediaQuery.of(context).size.width > 600
            ? null
            : AppBar(
                backgroundColor: appbarbluegray,
                actions: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ChatLogInPage(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.message),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                ],
                title: const Text(
                  "Fresh Academy",
                  style: TextStyle(fontFamily: "myfont"),
                ),
              ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('posts')
              .orderBy("datePublished", descending: true)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            return ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                return InformationOfHomePost(
                  dataFromDB: data,
                );
              }).toList(),
            );
          },
        ));
  }
}
