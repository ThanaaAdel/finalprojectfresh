 import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:finalprojectfresh/models/Widgets.dart';
class SettingList extends StatefulWidget {
  const SettingList({Key? key}) : super(key: key);

  @override
  _SettingListState createState() => _SettingListState();
}

class _SettingListState extends State<SettingList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('App Settings Example App'),
        backgroundColor: Colors.blueGrey,

      ),
      body: buildSettin(),
    );
  }
}
