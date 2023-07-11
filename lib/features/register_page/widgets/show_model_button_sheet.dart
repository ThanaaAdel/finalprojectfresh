import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' show basename;

class ShowModelButtomSheet extends StatefulWidget {
  const ShowModelButtomSheet({Key? key}) : super(key: key);

  @override
  State<ShowModelButtomSheet> createState() => _ShowModelButtomSheetState();
}

class _ShowModelButtomSheetState extends State<ShowModelButtomSheet> {
  Uint8List? imgPath;

  String? imgName;

  @override
  Widget build(BuildContext context) {

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
            // print(imgName);
          });
        } else {
          // print("NO img selected");
        }
      } catch (e) {
        // print("Error => $e");
      }
    }
    return   Container(
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
  }
}