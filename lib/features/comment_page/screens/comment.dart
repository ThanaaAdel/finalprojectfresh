
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:finalprojectfresh/firebase_services/firestore.dart';
import 'package:finalprojectfresh/provider/user_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';



class CommentsScreen extends StatefulWidget {
  final Map data;
  final bool showTextField ;

   const CommentsScreen({Key? key, required this.data,required this.showTextField}) : super(key: key);

  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {

  @override
  Widget build(BuildContext context) {
    final allDataFromDB = Provider.of<UserProvider>(context).getUser;
    final commentController = TextEditingController();
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 218, 216, 216),
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: const Text(
          'Comments',
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('posts')
                .doc(widget.data["postId"])
                .collection("comments").orderBy("dataPublished")
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return const Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator(
                  color: Colors.white,
                );
              }

              return Expanded(
                child: ListView(
                  children:
                  snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(right: 12),
                                  padding: const EdgeInsets.all(5),
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color.fromARGB(125, 78, 91, 110),
                                  ),
                                  child: CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        data["profilePic"]
                                      // "https://cdn1-m.zahratalkhaleej.ae/store/archive/image/2020/11/4/813126b3-4c9d-4a7b-b8d9-83f46749fa26.jpg?format=jpg&preset=w1900"

                                    ),
                                    radius: 26,
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(data["username"],
                                            style: const TextStyle(
                                              color:Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 17)),
                                        const SizedBox(
                                          width: 11,
                                        ),
                                        Text(data["textComment"],
                                            style: const TextStyle
                                              (fontSize: 16,        color:Colors.black,))
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                        DateFormat('MMM d, ' 'y').format(
                                            data["dataPublished"].toDate()),
                                        style: const TextStyle(
                                          color:Colors.black,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                        ))
                                  ],
                                ),
                              ],
                            ),
                            IconButton(
                                onPressed: () {}, icon: const Icon(Icons.favorite),        color:Colors.red)
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              );
            },
          ),
          widget.showTextField ?
          Container(
            margin: const EdgeInsets.only(bottom: 12),
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 12),
                  padding: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromARGB(125, 78, 91, 110),
                  ),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(allDataFromDB!.profileImg),
                    radius: 26,
                  ),
                ),
                Expanded(
                  child: TextFormField(
    style: const TextStyle(color: Colors.black),

                      controller: commentController,
                      keyboardType: TextInputType.text,
                      obscureText: false,
                      decoration: InputDecoration(
                          hintText: "Comment as  ${allDataFromDB.username}  ",
                          suffixIcon: IconButton(
                              onPressed: () async {
                                await FirestoreMethods().uploadComment(
                                    commentText: commentController.text,
                                    postId: widget.data["postId"],
                                    profileImg: allDataFromDB.profileImg,
                                    username: allDataFromDB.username,
                                    uid: allDataFromDB.uid);

                                commentController.clear();
                              },
                              icon: const Icon(Icons.send)))),
                ),
              ],
            ),
          ):const Text("")
        ],
      ),
    );
  }
}