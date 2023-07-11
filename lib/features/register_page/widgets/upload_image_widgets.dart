import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
class UploadingImage extends StatefulWidget {
   const UploadingImage({Key? key}) : super(key: key);
  @override
  State<UploadingImage> createState() => _UploadingImageState();
}

class _UploadingImageState extends State<UploadingImage> {
  @override
  Widget build(BuildContext context) {
    Uint8List? imgPath;
    String? imgName;
    uploadImage2Screen(ImageSource source) async {
      Navigator.pop(context);
      final XFile? pickedImg = await ImagePicker().pickImage(source: source);
      try {
        if (pickedImg != null) {
          imgPath = await pickedImg.readAsBytes();
          setState(() {
            imgName = basename(pickedImg.path);
            int random = Random().nextInt(9999999);
            imgName = "$random$imgName";
            print(imgName);
          });
        } else {
          print("NO img selected");
        }
      } catch (e) {
        print("Error => $e");
      }
    }
    showmodel() {
      return showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            padding: const EdgeInsets.all(22),
            height: 170,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () async {
                    await uploadImage2Screen(ImageSource.camera);
                  },
                  child: Row(
                    children: const [
                      Icon(
                        Icons.camera,
                        size: 30,
                      ),
                      SizedBox(
                        width: 11,
                      ),
                      Text(
                        "From Camera",
                        style: TextStyle(fontSize: 20),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 22,
                ),
                GestureDetector(
                  onTap: () {
                    uploadImage2Screen(ImageSource.gallery);
                  },
                  child: Row(
                    children: const [
                      Icon(
                        Icons.photo_outlined,
                        size: 30,
                      ),
                      SizedBox(
                        width: 11,
                      ),
                      Text(
                        "From Gallery",
                        style: TextStyle(fontSize: 20),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      );
    }

    return Stack(
      children: [
        imgPath == null
            ? const CircleAvatar(
          backgroundColor:
          Color.fromARGB(255, 225, 225, 225),
          radius: 71,
          // backgroundImage: AssetImage("assets/img/avatar.png"),
          backgroundImage:
          AssetImage("assets/images/avatar.png"),
        )
            : CircleAvatar(
          radius: 71,
          backgroundImage: MemoryImage(imgPath!),
        ),
        Positioned(
          left: 99,
          bottom: -10,
          child: IconButton(
            onPressed: () {
              showmodel();
            },
            icon: const Icon(Icons.add_a_photo),
            color: const Color.fromARGB(255, 208, 218, 224),
          ),
        ),
      ],
    );
  }
}
