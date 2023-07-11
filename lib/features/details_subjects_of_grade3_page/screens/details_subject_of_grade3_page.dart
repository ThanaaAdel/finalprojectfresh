import 'package:flutter/material.dart';
import 'package:finalprojectfresh/models/Items/items_of_grade3.dart';
import 'package:finalprojectfresh/provider/user_provider.dart';
import 'package:provider/provider.dart';

import '../../registered_subjects_page/screens/register_subjects_page.dart';

class DetailsSubjectOfGrade3 extends StatefulWidget {
  ItemsGrade3 itemsGrade3 ;

  DetailsSubjectOfGrade3({super.key, required this.itemsGrade3});


  @override
  State<DetailsSubjectOfGrade3> createState() => _DetailsSubjectOfGrade3State();
}

class _DetailsSubjectOfGrade3State extends State<DetailsSubjectOfGrade3> {
  bool isShowMore = true;
  bool isGoin = true;


  @override
  Widget build(BuildContext context) {
    final carttt = Provider.of<UserProvider>(context);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 218, 216, 216),
      appBar:
      AppBar(
        backgroundColor:  Colors.blueGrey,
        title:  Text( widget.itemsGrade3.subjectName),
        actions: [
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
                      "${carttt.selectedSubject.length}",
                      style: const TextStyle(
                          fontSize: 16, color: Color.fromARGB(255, 0, 0, 0)),
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
          IconButton(onPressed: () {}, icon: const Icon(Icons.search))
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
            color: Colors.white),

        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset("assets/images/OIP.jpg"),
                const SizedBox(
                  height: 22,
                ),
                Text(
                  widget.itemsGrade3.subjectName,
                  style: const TextStyle(fontSize: 22 ,color: Colors.black),
                ),
                const SizedBox(
                  height: 22,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 255, 129, 129),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text(
                        "Rate",
                        style: TextStyle(fontSize: 15,color: Colors.black),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Row(
                      children: const [
                        Icon(
                          Icons.star,
                          size: 20,
                          color:  Colors.black,
                        ),
                        Icon(
                          Icons.star,
                          size: 20,
                          color: Color.fromARGB(255, 255, 191, 0),
                        ),
                        Icon(
                          Icons.star,
                          size: 20,
                          color: Color.fromARGB(255, 255, 191, 0),
                        ),
                        Icon(
                          Icons.star,
                          size: 20,
                          color: Color.fromARGB(255, 255, 191, 0),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 66,
                    ),
                    TextButton(
                        onPressed: () {
                          setState(() {
                            isGoin = !isGoin;
                            if (isGoin == false) {
                              carttt.addItemsGrade3(
                                  ItemsGrade3(
                                      subjectName: widget.itemsGrade3.subjectName,
                                      doctorName: widget.itemsGrade3.doctorName));
                            }
                            else if(isGoin == true){
                              carttt.deleteItemsGrade3(ItemsGrade3(
                                  subjectName: widget.itemsGrade3.subjectName,
                                  doctorName: widget.itemsGrade3.doctorName));
                            }

                          });
                        },
                        child: Text(
                          isGoin ? "join" : "joined",
                          style: const TextStyle(fontSize: 20,color: Colors.black),
                        ))
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: Text(
                      "Definition of ٍSubjects :",
                      style: TextStyle(fontSize: 22,color: Colors.black),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "A flower, sometimes known as a bloom or blossom, is the reproductive structure found in flowering plants (plants of the division Angiospermae). The biological function of a flower is to facilitate reproduction, usually by providing a mechanism for the union of sperm with eggs. Flowers may facilitate outcrossing (fusion of sperm and eggs from different individuals in a population) resulting from cross-pollination or allow selfing (fusion of sperm and egg from the same flower) when self-pollination occurs.",
                    style: const TextStyle(
                        fontSize: 18,
                        color: Colors.black
                    ),
                    maxLines: isShowMore ? 3 : null,
                    overflow: TextOverflow.fade,
                  ),
                ),
                TextButton(
                    onPressed: () {
                      setState(() {
                        isShowMore = !isShowMore;
                      });
                    },
                    child: Text(
                      isShowMore ? "Show more" : "Show less",
                      style: const TextStyle(
                          fontSize: 18,
                          color: Colors.black
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
