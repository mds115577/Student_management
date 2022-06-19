import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_manag/db_funct/data_model.dart';

File? image;
String img = '';

class Cont extends GetxController {
  pickimage() async {
    final pimage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pimage == null) {
      return;
    } else {
      image = File(pimage.path);
      update();
      final bytes = File(pimage.path).readAsBytesSync();
      img = base64Encode(bytes);
    }
  }
}

class Counter extends ChangeNotifier {
  List<Stud_model> searchData = [];
  List<Stud_model> studentListNotifier = [];
  Future<void> addStudent(Stud_model value) async {
    final studentDB = await Hive.openBox<Stud_model>('student_db');
    final _id = await studentDB.add(value);
    value.id = _id;
    studentDB.put(value.id, value);
    studentListNotifier.addAll(studentDB.values);
    notifyListeners();
  }

  Future<void> getAllstud([String? value]) async {
    final studentDB = await Hive.openBox<Stud_model>('student_db');
    studentListNotifier.clear();
    studentListNotifier.addAll(studentDB.values);
    notifyListeners();
  }

  Future<void> deletestudent(int index) async {
    final studentDB = await Hive.openBox<Stud_model>('student_db');
    await studentDB.deleteAt(index);
    getAllstud();
    notifyListeners();
  }

  Future<void> UpdateStudent(Stud_model value) async {
    final studentDB = await Hive.openBox<Stud_model>('student_db');
    await studentDB.put(value.id, value);
    getAllstud();
    notifyListeners();
  }

  getSearchResult(String value) {
    searchData.clear();
    for (var index in studentListNotifier) {
      if (index.name.toString().toLowerCase().contains(
            value.toLowerCase(),
          )) {
        Stud_model data = Stud_model(
          name: index.name,
          age: index.age,
          regnum: index.regnum,
          class1: index.class1,
          img: index.img,
        );
        searchData.add(data);
        notifyListeners();
      }
    }
  }
}
