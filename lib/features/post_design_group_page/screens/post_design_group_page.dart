import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:finalprojectfresh/firebase_services/firestore.dart';
import 'package:finalprojectfresh/features/comment_page/screens/comment.dart';
import 'package:finalprojectfresh/shared/colors.dart';
import 'package:finalprojectfresh/features/post_design_home_page/widgets/heart_animation.dart';
import 'package:finalprojectfresh/shared/snakbar.dart';
import 'package:intl/intl.dart';

class InformationOfGroupPost extends StatefulWidget {
  final dataFromDB;

  const InformationOfGroupPost({Key? key, required this.dataFromDB}) : super(key: key);

  @override
  State<InformationOfGroupPost> createState() => _InformationOfGroupPostState();
}

class _InformationOfGroupPostState extends State<InformationOfGroupPost> {
  bool showHeart = false;
  bool isLikeAnimating = false;
  int commentCount = 0;
  getCommentCount() async {
    try {
      QuerySnapshot commentdata = await FirebaseFirestore.instance
          .collection("postgroup")
          .doc(widget.dataFromDB["postId"])
          .collection("comments")
          .get();

      setState(() {
        commentCount = commentdata.docs.length;
      });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCommentCount();
  }

  showmodel() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          children: [
            FirebaseAuth.instance.currentUser!.uid == widget.dataFromDB["uid"]
                ? SimpleDialogOption(
              onPressed: () async {
                Navigator.of(context).pop();
                await FirebaseFirestore.instance
                    .collection("postgroup")
                    .doc(widget.dataFromDB["postId"])
                    .delete();
              },
              padding: const EdgeInsets.all(20),
              child: const Text(
                "Delete post",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            )
                : const SimpleDialogOption(
              padding: EdgeInsets.all(20),
              child: Text(
                "Can not delete this post ✋",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            SimpleDialogOption(
              onPressed: () async {
                Navigator.of(context).pop();
              },
              padding: const EdgeInsets.all(20),
              child: const Text(
                "Cancel",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  onClickekonPic() async {
    setState(() {
      isLikeAnimating = true;
    });

    await FirebaseFirestore.instance
        .collection("postgroup")
        .doc(widget.dataFromDB["postId"])
        .update({
      "likes": FieldValue.arrayUnion([FirebaseAuth.instance.currentUser!.uid])
    });
  }

  @override
  Widget build(BuildContext context) {
    final double widthScreen = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
          color: mobileBackgroundColor,
          borderRadius: BorderRadius.circular(12)),
      margin: EdgeInsets.symmetric(
          vertical: 11, horizontal: widthScreen > 600 ? widthScreen / 6 : 0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 13),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(3),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromARGB(125, 78, 91, 110),
                      ),
                      child: CircleAvatar(
                        radius: 33,
                        backgroundImage: NetworkImage(
                          // allDataFromDB!.profileImg
                          widget.dataFromDB["profileImg"],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 17,
                    ),
                    Text(
                      widget.dataFromDB["username"],
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                IconButton(
                    onPressed: () {
                      showmodel();
                    },
                    icon: const Icon(
                      Icons.more_vert,
                      color: Colors.black,
                    )),
              ],
            ),
          ),
          GestureDetector(
            onDoubleTap: () async {
              await onClickekonPic();
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                Row(
                  children: [
                    const SizedBox(
                      width: 9,
                    ),
                    Text(
                      widget.dataFromDB["description"],
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                          fontSize: 20,
                          color: Color.fromARGB(255, 189, 196, 199)),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                  ],
                ),

                Image.network(
                  widget.dataFromDB["imgPost"],
                  loadingBuilder: (context, child, progress) {
                    return progress == null
                        ? child
                        : SizedBox(
                        height: MediaQuery.of(context).size.height * 0.35,
                        child: const Center(
                            child: CircularProgressIndicator()));
                  },
                  fit: BoxFit.cover,
                  height: MediaQuery.of(context).size.height * 0.35,
                  width: double.infinity,
                ),

// Global variable

// widget
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: isLikeAnimating ? 1 : 0,
                  child: LikeAnimation(
                    isAnimating: isLikeAnimating,
                    duration: const Duration(
                      milliseconds: 400,
                    ),
                    onEnd: () {
                      setState(() {
                        isLikeAnimating = false;
                      });
                    },
                    child: const Icon(
                      Icons.favorite,
                      color: Colors.black,
                      size: 111,
                    ),
                  ),
                ),
                showHeart
                    ? const Icon(
                  Icons.favorite,
                  color: Colors.black,
                  size: 177,
                )
                    : const Text("")
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 11),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    LikeAnimation(
                      isAnimating: widget.dataFromDB['likes']
                          .contains(FirebaseAuth.instance.currentUser!.uid),
                      smallLike: true,
                      child: IconButton(
                        onPressed: () async {
                          await FirestoreMethods()
                              .toggleLike(postData: widget.dataFromDB);
                        },
                        icon: widget.dataFromDB['likes'].contains(
                            FirebaseAuth.instance.currentUser!.uid)
                            ? const Icon(
                          Icons.favorite,
                          color: Colors.red,
                        )
                            : const Icon(
                          Icons.favorite_border,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CommentsScreen(
                                data: widget.dataFromDB,
                                showTextField: true,
                              )),
                        );
                      },
                      icon: const Icon(
                        Icons.comment_outlined,
                        color: Colors.black,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        color: Colors.black,
                        Icons.send,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.bookmark_outline,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          Container(
              margin: const EdgeInsets.fromLTRB(10, 0, 0, 10),
              width: double.infinity,
              child: Text(
                " ${widget.dataFromDB["likes"].length} ${widget.dataFromDB["likes"].length > 1 ? "Likes" : "Like"} ",
                textAlign: TextAlign.start,
                style: const TextStyle(
                    fontSize: 18, color: Color.fromARGB(214, 157, 157, 165)),
              )),
          Row(
            children: [
              const SizedBox(
                width: 9,
              ),
              Text(
                widget.dataFromDB["username"],
                textAlign: TextAlign.start,
                style: const TextStyle(
                    fontSize: 20, color: Color.fromARGB(255, 189, 196, 199)),
              ),
              const SizedBox(
                width: 12,
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CommentsScreen(
                      data: widget.dataFromDB,
                      showTextField: false,
                    )),
              );
            },
            child: Container(
                margin: const EdgeInsets.fromLTRB(10, 13, 9, 10),
                width: double.infinity,
                child: Text(
                  "view all $commentCount comments",
                  style: const TextStyle(
                      fontSize: 18, color: Color.fromARGB(214, 157, 157, 165)),
                  textAlign: TextAlign.start,
                )),
          ),
          Container(
              margin: const EdgeInsets.fromLTRB(10, 0, 9, 10),
              width: double.infinity,
              child: Text(
                DateFormat('MMMM d, ' 'y')
                    .format(widget.dataFromDB["datePublished"].toDate()),
                style: const TextStyle(
                    fontSize: 18, color: Color.fromARGB(68, 0, 0, 0)),
                textAlign: TextAlign.start,
              )),
        ],
      ),
    );
  }
}
