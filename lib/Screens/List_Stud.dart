import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_manag/Screens/Stud_update.dart';
import 'package:student_manag/db_funct/database.dart';
import 'package:student_manag/db_funct/data_model.dart';
import 'package:student_manag/Screens/Add.dart';
import 'package:student_manag/Screens/Search_stud.dart';
import 'package:student_manag/Screens/Stud_Prof.dart';

import '../db_funct/database.dart';

class ListStud extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables

  var images;
  Stud_model? data;
  ListStud({Key? key}) : super(key: key);
  final s = Cont();
  @override
  Widget build(BuildContext context) {
    s.getAllstud();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 128, 189, 63),
        title: const Center(child: Text('Home')),
        actions: [
          IconButton(
              onPressed: () {
                s.searchData.clear();
                Get.to(SearchStud());
              },
              icon: const Icon(Icons.search))
        ],
      ),
      body: SafeArea(child: Obx(() {
        return ListView.separated(
          itemBuilder: (ctx, index) {
            final data = studentListNotifier[index];
            final encoding = data.img;
            images = const Base64Decoder().convert(encoding);
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                color: const Color.fromARGB(168, 186, 204, 156),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: MemoryImage(images),
                    radius: 30,
                  ),
                  title: Text('Name : ${data.name}'),
                  subtitle: Text('RegNo : ${data.regnum}'),
                  trailing: Wrap(
                    children: [
                      IconButton(
                        onPressed: () {
                          Get.to(Stud_update(
                            data: data,
                            editor: true,
                          ));
                        },
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.lightBlue,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Get.defaultDialog(
                              title: 'Alert',
                              middleText: 'Do You Want Delete the Data',
                              titleStyle: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                              textConfirm: 'Yes',
                              textCancel: 'No',
                              onConfirm: () {
                                if (data.id != null) {
                                  s.deletestudent(data.id!);
                                  Get.back();
                                }
                              },
                              onCancel: () {
                                Get.back();
                              },
                              confirmTextColor: Colors.white);
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    Get.to(StudProf(data: data));
                  },
                ),
              ),
            );
          },
          separatorBuilder: (ctx, index) {
            return const Divider();
          },
          itemCount: studentListNotifier.length,
        );
      })),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          img = '';
          Get.off(Add(
            data: data,
          ));
        },
        child: const Icon(Icons.add),
        backgroundColor: const Color.fromARGB(255, 128, 189, 63),
      ),
    );
  }
}
