import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_manag/db_funct/data_model.dart';

ValueNotifier<List<Stud_model>> studentListNotifier = ValueNotifier([]);
RxList<Stud_model> searchData = <Stud_model>[].obs;
Future<void> addStudent(Stud_model value) async {
  final studentDB = await Hive.openBox<Stud_model>('student_db');
  final _id = await studentDB.add(value);
  value.id = _id;
  studentDB.put(value.id, value);
  studentListNotifier.value.add(value);
  studentListNotifier.notifyListeners();
}

Future<void> getAllstud([String? value]) async {
  final studentDB = await Hive.openBox<Stud_model>('student_db');
  studentListNotifier.value.clear();
  studentListNotifier.value.addAll(studentDB.values);
  studentListNotifier.notifyListeners();
}

Future<void> deletestudent(int index) async {
  final studentDB = await Hive.openBox<Stud_model>('student_db');
  await studentDB.deleteAt(index);
  getAllstud();
}

Future<void> UpdateStudent(Stud_model value) async {
  final studentDB = await Hive.openBox<Stud_model>('student_db');
  await studentDB.put(value.id, value);
  getAllstud();
}

getSearchResult(String value) {
  searchData.clear();
  for (var index in studentListNotifier.value) {
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
    }
  }
}

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
