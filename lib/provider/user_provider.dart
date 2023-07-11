





import 'package:flutter/material.dart';
import 'package:finalprojectfresh/firebase_services/auth.dart';
import 'package:finalprojectfresh/models/Items/items_of_grade1.dart';
import 'package:finalprojectfresh/models/Items/items_of_grade2.dart';
import 'package:finalprojectfresh/models/Items/items_of_grade3.dart';
import 'package:finalprojectfresh/models/Items/items_of_grade4.dart';
import 'package:finalprojectfresh/models/users.dart';



class UserProvider with ChangeNotifier {

  List selectedSubject = [];
  UserDate? _userData;
  UserDate? get getUser => _userData;
  addItemsGrade1(ItemsGrade1 product) {
    selectedSubject.add(product);
    notifyListeners();
  }
  deleteItemsGrade1(ItemsGrade1 product) {
    selectedSubject.remove(product);
    notifyListeners();
  }
  addItemsGrade2(ItemsGrade2 product) {
    selectedSubject.add(product);
    notifyListeners();
  }
  deleteItemsGrade2(ItemsGrade2 product) {
    selectedSubject.remove(product);
    notifyListeners();
  }
  addItemsGrade3(ItemsGrade3 product) {
    selectedSubject.add(product);
    notifyListeners();
  }
  deleteItemsGrade3(ItemsGrade3 product) {
    selectedSubject.remove(product);
    notifyListeners();
  }
  addItemsGrade4(ItemsGrade4 product) {
    selectedSubject.add(product);
    notifyListeners();
  }
  deleteItemsGrade4(ItemsGrade4 product) {
    selectedSubject.remove(product);
    notifyListeners();
  }


  refreshUser() async {
    UserDate userData = await AuthMethods().getUserDetails();
    _userData = userData;
    notifyListeners();
  }
}