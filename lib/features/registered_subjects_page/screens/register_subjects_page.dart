import 'package:flutter/material.dart';
import 'package:finalprojectfresh/models/Items/items_of_grade1.dart';
import 'package:finalprojectfresh/provider/user_provider.dart';
import 'package:finalprojectfresh/features/groups_of_grade1_page/screens/groups_of_grade1_page.dart';
import 'package:provider/provider.dart';

class YourGroups extends StatelessWidget {
  const YourGroups({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<UserProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: const Text(
          "My Groups",
          style: TextStyle(fontFamily: "myfont", fontSize: 25),
        ),
        actions: [
          Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const YourGroups(),
                    ),
                  );
                },
                icon: const Icon(Icons.search),
              ),
              const SizedBox(
                width: 10,
              ),
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 550,
              child: ListView.builder(
                  padding: const EdgeInsets.all(5),
                  itemCount: cart.selectedSubject.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AllGroupsOfGrade1(
                                  itemsGrade1: subjectsOfGrade1[index])),
                        );
                      },
                      child: Card(
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.blueGrey,
                              borderRadius: BorderRadius.circular(5)),
                          child: ListTile(
                            title:
                            Text(cart.selectedSubject[index].subjectName),
                            subtitle: Text(
                              "${cart.selectedSubject[index].doctorName}",
                            ),
                            leading: const CircleAvatar(
                              backgroundImage:
                              AssetImage("assets/images/OIP.jpg"),
                            ),
                            trailing: IconButton(
                                onPressed: () {

                                  cart.deleteItemsGrade1(
                                      cart.selectedSubject[index]);
                                  cart.deleteItemsGrade2(
                                      cart.selectedSubject[index]);
                                  cart.deleteItemsGrade3(
                                      cart.selectedSubject[index]);
                                  cart.deleteItemsGrade3(
                                      cart.selectedSubject[index]);
                                },
                                icon: const Icon(Icons.remove)),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}