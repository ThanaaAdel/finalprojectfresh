import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../add_post_event_page/screens/add_post_event_page.dart';
import '../../post_design_event_page/screens/information_of_event_post.dart';
class Events extends StatefulWidget {
  const Events({super.key});
  @override
  State<Events> createState() => _EventsState();
}
class _EventsState extends State<Events> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 218, 216, 216),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueGrey,
          onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    const AddPostEvent(),
              ),
            );
          },
          child: const Icon(Icons.add,
            color: Colors.white,
          )),
      appBar:

      MediaQuery.of(context).size.width >600 ?null : AppBar(

        title: const Center(
          child: Text("Events",
            style: TextStyle(
                color:   Colors.white,
                fontFamily: "myfont",
              fontSize: 25
            ),
          ),
        ),
        backgroundColor: Colors.blueGrey,

      ),
      body:
      StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('postevent')
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
              return InformationOfEventPost(
                dataFromDB: data,
              );
            }).toList(),
          );
        },
      )

      // backgroundColor:
      // MediaQuery.of(context).size.width > 600 ? secondaryColor2 : Colors.white,

    );
  }
}
