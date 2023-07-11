import 'package:flutter/material.dart';
import 'package:finalprojectfresh/models/Items/items_of_grade1.dart';
import 'package:finalprojectfresh/models/Items/items_of_grade2.dart';
import 'package:finalprojectfresh/models/Items/items_of_grade3.dart';
import 'package:finalprojectfresh/models/Items/items_of_grade4.dart';



class Cart with ChangeNotifier {


  List selectedSubject = [];

  addItemOfGrade1(ItemsGrade1 product) {

    selectedSubject.add(product);
    notifyListeners();
  }
  deleteItemOfGrade1(ItemsGrade1 product) {
    selectedSubject.remove(product);

    notifyListeners();
  }
  addItemOfGrade2(ItemsGrade2 product) {

    selectedSubject.add(product);
    notifyListeners();
  }
  deleteItemOfGrade2(ItemsGrade2 product) {
    selectedSubject.remove(product);

    notifyListeners();
  }
  addItemOfGrade3(ItemsGrade3 product) {

    selectedSubject.add(product);
    notifyListeners();
  }
  deleteItemOfGrade3(ItemsGrade3 product) {
    selectedSubject.remove(product);

    notifyListeners();
  }
  addItemOfGrade4(ItemsGrade4 product) {

    selectedSubject.add(product);
    notifyListeners();
  }
  deleteItemOfGrade4(ItemsGrade4 product) {
    selectedSubject.remove(product);

    notifyListeners();
  }
}