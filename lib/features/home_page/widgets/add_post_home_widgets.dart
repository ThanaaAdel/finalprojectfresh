import 'package:flutter/material.dart';

import '../../add_post_home_page/screens/add_post_home.dart';
import '../../zoom/common/join_screen.dart';
class AddPostHomeWidgets extends StatelessWidget {
  const AddPostHomeWidgets({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          CircleAvatar(
            radius: 32,
            backgroundColor: Colors.blueGrey,
            child:IconButton(onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const JoinScreen(),
                ),);
            }, icon: const Icon(Icons.video_camera_back_rounded ,color: Colors.white,),),
          ),
          const SizedBox(
            height: 15,
          ),
          CircleAvatar(
            radius: 32,
            backgroundColor: Colors.blueGrey,
            child:IconButton(onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddPostHome(),
                ),);
            }, icon: const Icon(Icons.add ,color: Colors.white,),),
          )
        ]
    );
  }
}
