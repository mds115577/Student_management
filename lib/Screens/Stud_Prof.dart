import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:student_manag/Screens/Stud_update.dart';
import 'package:student_manag/db_funct/data_model.dart';

class StudProf extends StatelessWidget {
  final Stud_model data;

  const StudProf({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var imag = const Base64Decoder().convert(data.img);
    return Scaffold(
      backgroundColor: const Color.fromARGB(166, 110, 166, 5),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 128, 189, 63),
        title: Padding(
          padding: const EdgeInsets.only(left: 78.0),
          child: Text(
            data.name.toString().toUpperCase(),
            style: const TextStyle(fontSize: 30),
          ),
        ),
      ),
      body: SafeArea(
          child: Padding(
        padding:
            const EdgeInsets.only(top: 48.0, bottom: 50, right: 20, left: 20),
        child: Card(
          color: const Color.fromARGB(255, 248, 248, 244),
          elevation: 70,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          child: Padding(
            padding: const EdgeInsets.only(top: 38.0),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 14.0, bottom: 40),
                  child: Text(
                    'Profile Details',
                    style: TextStyle(
                        color: Color.fromARGB(185, 255, 0, 0),
                        fontSize: 50,
                        fontWeight: FontWeight.w300),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 38.0),
                  child: CircleAvatar(
                    backgroundImage: MemoryImage(imag),
                    radius: 70,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 58.0),
                  child: Row(
                    children: [
                      const Text(
                        'Name : ',
                        style: TextStyle(fontSize: 30),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      Text(
                        data.name,
                        style: const TextStyle(
                            fontSize: 30, fontWeight: FontWeight.w300),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 58.0, top: 10),
                  child: Row(
                    children: [
                      const Text(
                        'Regnum :',
                        style: TextStyle(fontSize: 30),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      Text(data.regnum,
                          style: const TextStyle(
                              fontSize: 30, fontWeight: FontWeight.w300))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 58.0, top: 10),
                  child: Row(
                    children: [
                      const Text(
                        'Age :',
                        style: TextStyle(fontSize: 30),
                      ),
                      const SizedBox(
                        width: 80,
                      ),
                      Text(
                        data.age,
                        style: const TextStyle(
                            fontSize: 30, fontWeight: FontWeight.w300),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, left: 58),
                  child: Row(
                    children: [
                      const Text(
                        'Class : ',
                        style: TextStyle(fontSize: 30),
                      ),
                      const SizedBox(
                        width: 60,
                      ),
                      Text(
                        data.class1,
                        style: const TextStyle(
                            fontSize: 30, fontWeight: FontWeight.w300),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
