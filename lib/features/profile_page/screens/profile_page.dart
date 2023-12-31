
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:finalprojectfresh/shared/colors.dart';


class Profile extends StatefulWidget {
  final String uid;
  const Profile({Key? key, required this.uid}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Map userDate = {};
  late int followers;
  late int following ;
   bool isLoading = true;
   int postCount = 0;
   bool isFollow = true;
   getData() async {
     // Get data from DB

     setState(() {
       isLoading = true;
     });
     try {
       DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
           .instance
           .collection('users')
           .doc(widget.uid,)
           .get();

       userDate = snapshot.data()!;
       followers = userDate["followers"].length;
       following = userDate["following"].length;
       var snapShotPost = await  FirebaseFirestore.instance
           .collection('posts')
           .where("uid",
           isEqualTo: widget.uid,)
           .get();
       postCount = snapShotPost.docs.length;
       isFollow = userDate["followers"]
           .contains(FirebaseAuth.instance.currentUser!.uid);

     } catch (e) {
       // print(e.toString());
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

    final double widthScreen = MediaQuery.of(context).size.width;
    return  isLoading
        ? const Center(
        child: CircularProgressIndicator(
          color: Colors.white,
        )):Scaffold(
      backgroundColor: const Color.fromARGB(255, 218, 216, 216),
      appBar: AppBar(
        backgroundColor: appbarbluegray,
        title: Center(child: Text(userDate["username"],
          style: const TextStyle(color:Colors.white,fontFamily: "myfont"),)),
      ),
      body:
      Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height/33,
          ),
          Row(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 22),
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromARGB(125, 78, 91, 110),
                ),
                child: CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(userDate["profileImg"]),
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Text(
                          "$postCount",
                          style: const TextStyle(
                            fontSize: 22,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Text(
                          "Posts",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 17,
                    ),
                    Column(
                      children: [
                        Text(
                       followers.toString(),

                          style: const TextStyle(
                            fontSize: 22,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Text(
                          "Followers",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,

                              color: Colors.black),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 17,
                    ),
                    Column(
                      children: [
                        Text(
                      following.toString(),
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.black
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Text(
                          "Following",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
          Divider(
            color: Colors.white,
            thickness: widthScreen > 600 ? 0.06 : 0.44,
          ),
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 20 , vertical: 5),
              width: double.infinity,
              child: Text(userDate["title"],
                style: const TextStyle(color: Colors.black , fontSize: 19,fontFamily: "myfont"),)),
          const SizedBox(
            height: 15,
          ),
          Divider(
            color: Colors.white,
            thickness: widthScreen > 600 ? 0.06 : 0.44,
          ),
          const SizedBox(
            height: 9,
          ),

          widget.uid == FirebaseAuth.instance.currentUser!.uid
              ?
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MaterialButton(onPressed: (){} , color: Colors.grey, textColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 35 , vertical: 15)
                ,shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(20.0) ), child: Row(
                children: const [
                  Icon(Icons.edit , color: Colors.white,),
                  Text('Edit Profile',),
                ],
              ),
              ),
              const SizedBox(width: 20,),
              MaterialButton(onPressed: (){} , color: Colors.red, textColor: Colors.white
                ,padding: const EdgeInsets.symmetric(horizontal: 35 , vertical: 15)
                ,shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(20.0) ), child: Row(
                children: const [
                  Icon(Icons.exit_to_app , color: Colors.white,),
                  Text('Log Out',),
                ],
              ),
              ),

            ],
          )
        :
          isFollow?
          ElevatedButton(
            onPressed: () async{
              followers--;
              setState(() {
                isFollow = false;
              });
              await FirebaseFirestore.instance.collection("users").
              doc(widget.uid).update({"followers": FieldValue.arrayRemove([FirebaseAuth.instance.currentUser!.uid])});
              await FirebaseFirestore.instance.collection("users").
              doc(FirebaseAuth.instance.currentUser!.uid).update({"following": FieldValue.arrayRemove([widget.uid])});
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                  const Color.fromARGB(143, 255, 55, 112)),
              padding: MaterialStateProperty.all(
                  const EdgeInsets.symmetric(
                      vertical: 9, horizontal: 66)),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7),
                ),
              ),
            ),
            child: const Text(
              "unfollow",
              style: TextStyle(fontSize: 17),
            ),
          ):
         ElevatedButton(
    onPressed: () async {
      followers++;
      setState(() {
        isFollow = true;
      });
      await FirebaseFirestore.instance.collection("users").
      doc(widget.uid).update({"followers": FieldValue.arrayUnion([FirebaseAuth.instance.currentUser!.uid])});
      await FirebaseFirestore.instance.collection("users").
      doc(FirebaseAuth.instance.currentUser!.uid).update({"following": FieldValue.arrayUnion([widget.uid])});
    },
    style: ButtonStyle(
     //backgroundColor: MaterialStateProperty.all(Color.fromARGB(0, 90, 103, 223)),
    padding: MaterialStateProperty.all(
    const EdgeInsets.symmetric(
    vertical: 9, horizontal: 77)),
    shape: MaterialStateProperty.all(
    RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(7),
    ),
    ),
    ),  child: const Text(
           "Follow",
           style: TextStyle(fontSize: 17),
         ),
         ),

          const SizedBox(
            height: 9,
          ),
          Divider(
            color: Colors.white,
            thickness: widthScreen > 600 ? 0.06 : 0.44,
          ),
          const SizedBox(
            height: 19,
          ),
          FutureBuilder(
            future: FirebaseFirestore.instance
                .collection('posts')
                .where("uid",
                isEqualTo: widget.uid,)
                .get(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasError) {
                return const Text("Something went wrong");
              }

              if (snapshot.connectionState == ConnectionState.done) {
                return Expanded(
                  child: Padding(
                    padding: widthScreen > 600
                        ? const EdgeInsets.all(66.0)
                        : const EdgeInsets.all(3.0),
                    child: GridView.builder(
                        gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 3 / 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10),
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (BuildContext context, int index) {
                          postCount = snapshot.data!.docs.length;
                          return ClipRRect(

                            borderRadius: BorderRadius.circular(4),
                            child: Image.network(
                              // snapshot.data!.docs  = [  {"imgPost": 000000000}, {"imgPost": 0000000}    ]

                              snapshot.data!.docs[index]["imgPost"],
                              loadingBuilder: (context, child, progress){
                                return progress == null
                                    ? child
                                    : const Center(child: CircularProgressIndicator());
                              },

                              // "https://cdn1-m.alittihad.ae/store/archive/image/2021/10/22/6266a092-72dd-4a2f-82a4-d22ed9d2cc59.jpg?width=1300",
                              // height: 333,
                              // width: 100,

                              fit: BoxFit.cover,
                            ),
                          );
                        }),
                  ),
                );
              }

              return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ));
            },
          )
        ],
      ),
    );
  }
}
