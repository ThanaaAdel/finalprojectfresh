import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:finalprojectfresh/models/Items/items_of_grade4.dart';
import 'package:finalprojectfresh/features/add_post_group_page/screens/add_post_group_page.dart';
import 'package:finalprojectfresh/features/post_design_event_page/screens/information_of_event_post.dart';
class AllGroupsOfGrade4 extends StatefulWidget {
  ItemsGrade4 itemsGrade4 ;
  AllGroupsOfGrade4({super.key,required this.itemsGrade4});
  @override
  State<AllGroupsOfGrade4> createState() => _AllGroupsOfGrade4State();
}

class _AllGroupsOfGrade4State extends State<AllGroupsOfGrade4> {
  Map groupData = {};
  bool isLoading = true;
  int postCount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blueGrey,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddPostGroup(),
              ),
            );
          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
          )),
      appBar: MediaQuery.of(context).size.width > 600
          ? null
          : AppBar(
        title:   Text(widget.itemsGrade4.subjectName),
        backgroundColor: Colors.blueGrey,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Image.asset("assets/images/OIP.jpg"),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    child: Text(widget.itemsGrade4.subjectName,
                      style: const TextStyle(
                          fontSize: 30,
                          fontFamily: "myfont",
                          color: Colors.black),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.person_add,
                    color: Colors.white,
                    size: 24.0,
                  ),
                  label: const Text(
                    "دعوة",
                    style: TextStyle(fontSize: 17),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        const Color.fromARGB(0, 200, 200, 100)),
                    padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 33)),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7),
                        side: const BorderSide(
                            color: Color.fromARGB(109, 255, 255, 255),
                            width: 1,
                            style: BorderStyle.solid),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.groups_rounded,
                    size: 24.0,
                  ),
                  label: const Text(
                    "تم الانضمام",
                    style: TextStyle(fontSize: 17),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        const Color.fromARGB(255, 8, 45, 75)),
                    padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 33)),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 9,
            ),
            const Divider(
              color: Colors.black,
              thickness: 0.44,
            ),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('postgroup')
                  .orderBy("datePublished", descending: true)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                return ListView(
                  children:
                  snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                    return InformationOfEventPost(
                      dataFromDB: data,
                    );
                  }).toList(),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
