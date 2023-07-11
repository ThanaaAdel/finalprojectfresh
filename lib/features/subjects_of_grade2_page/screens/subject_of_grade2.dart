import 'package:flutter/material.dart';
import 'package:finalprojectfresh/models/Items/items_of_grade2.dart';
import 'package:finalprojectfresh/provider/user_provider.dart';
import 'package:finalprojectfresh/features/details_subjects_of_grade2_page/screens/details_subject_of_grade2_page.dart';
import 'package:finalprojectfresh/features/search_page/screens/search.dart';
import 'package:finalprojectfresh/features/registered_subjects_page/screens/register_subjects_page.dart';
import 'package:provider/provider.dart';

class SubjectOfGrade2 extends StatefulWidget {
  const SubjectOfGrade2({Key? key}) : super(key: key);

  @override
  State<SubjectOfGrade2> createState() => _SubjectOfGrade2State();
}

class _SubjectOfGrade2State extends State<SubjectOfGrade2> {
  bool isGoin = true;
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
                "Subjects Of Grade 2",
                style: TextStyle(fontFamily: "myfont", fontSize: 25),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Search(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.search),
                ),
                const SizedBox(
                  width: 10,
                ),
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
            itemCount: subjectsOfGrade2.length,
            itemBuilder: (BuildContext context, int index) {
              return GridTile(
                footer: GridTileBar(
                  backgroundColor: const Color.fromARGB(182, 0, 0, 0),

                  title: Text(
                    subjectsOfGrade2[index].subjectName,
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
                        builder: (context) => DetailsSubjectOfGrade2(
                            itemsGrade2: subjectsOfGrade2[index]),
                      ),
                    );
                  },
                  child: Image.asset("assets/images/OIP.jpg"),
                ),
              );
            }),
      ),
    );
  }
}
