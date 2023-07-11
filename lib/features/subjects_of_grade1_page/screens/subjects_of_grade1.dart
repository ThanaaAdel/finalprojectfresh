import 'package:flutter/material.dart';
import 'package:finalprojectfresh/models/Items/items_of_grade1.dart';
import 'package:finalprojectfresh/provider/user_provider.dart';
import 'package:finalprojectfresh/features/details_subjects_of_grade1_page/screens/details_subjects_of_grade1_page.dart';
import 'package:finalprojectfresh/features/registered_subjects_page/screens/register_subjects_page.dart';
import 'package:provider/provider.dart';

class SubjectOfGrade1 extends StatefulWidget {
  const SubjectOfGrade1({Key? key}) : super(key: key);
  @override
  State<SubjectOfGrade1> createState() => _SubjectOfGrade1State();
}

class _SubjectOfGrade1State extends State<SubjectOfGrade1> {
  Map userDate = {};
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<UserProvider>(context);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 218, 216, 216),
      appBar: MediaQuery.of(context).size.width > 600
          ? null
          : AppBar(
              backgroundColor: Colors.blueGrey,
              title: const Text(
                "Subjects Of Grade 1",
                style: TextStyle(fontFamily: "myfont", fontSize: 25),
              ),
              actions: [
                Row(
                  children: [
                    Stack(
                      children: [
                        Positioned(
                          bottom: 19,
                          child: Container(
                              padding: const EdgeInsets.all(5),
                              decoration: const BoxDecoration(
                                  color: Color.fromARGB(211, 164, 255, 193),
                                  shape: BoxShape.circle),
                              child: Text(
                                "${cart.selectedSubject.length}",
                                style: const TextStyle(
                                    fontSize: 16,
                                    color: Color.fromARGB(255, 0, 0, 0)),
                              )),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const YourGroups(),
                              ),
                            );
                          },
                          icon: const Icon(Icons.groups),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 33),
            itemCount: subjectsOfGrade1.length,
            itemBuilder: (BuildContext context, int index) {
              return GridTile(
                footer: GridTileBar(
                  backgroundColor: const Color.fromARGB(182, 0, 0, 0),
                  title: Text(
                    subjectsOfGrade1[index].subjectName,
                    style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontFamily: "myfont"),
                  ),
                ),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailsSubjectOfGrade1(
                            itemsGrade1: subjectsOfGrade1[index]),
                      ),
                    );
                  },
                  child: Image.asset("assets/images/OIP.jpg"),
                  //   CircleAvatar(
                  //       radius: 10,
                  //       backgroundImage: AssetImage(items[index].imgPath)),
                ),
              );
            }),
      ),
    );
  }
}
