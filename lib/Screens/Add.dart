import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_manag/db_funct/data_model.dart';
import 'package:student_manag/db_funct/database.dart';
import 'package:student_manag/Screens/List_Stud.dart';

class Add extends StatelessWidget {
  final Stud_model? data;
  Add({Key? key, this.data}) : super(key: key);

  final _namecontroller = TextEditingController();
  final _agecontroller = TextEditingController();
  final _classcontroller = TextEditingController();
  final _Regcontroller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    if (data != null) {
      _namecontroller.text = data!.name;
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 128, 189, 63),
        title: const Text(
          'Profile Data',
          style: TextStyle(fontSize: 30),
        ),
      ),
      body: Form(
        key: _formKey,
        child: SafeArea(
            child: ListView(
          children: [
            Consumer<Counter>(builder: (context, datas, _) {
              return Padding(
                padding: const EdgeInsets.only(top: 38.0),
                child: Column(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(60),
                        image: const DecorationImage(
                          image: AssetImage('assets/images/avatar.png'),
                        ),
                      ),
                      child: img.trim().isNotEmpty
                          ? CircleAvatar(
                              backgroundImage: MemoryImage(
                                const Base64Decoder().convert(img),
                              ),
                            )
                          : Container(),
                    ),
                  ],
                ),
              );
            }),
            IconButton(
                onPressed: () async {
                  context.read<Counter>().pickimage();
                },
                icon: const Icon(Icons.add_a_photo)),
            Padding(
              padding: const EdgeInsets.only(top: 50.0, bottom: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: const BoxDecoration(boxShadow: [
                      BoxShadow(
                          color: Color.fromARGB(171, 246, 239, 239),
                          offset: Offset.zero,
                          blurRadius: 10),
                    ]),
                    child: const Text('Enter the Data',
                        style: TextStyle(
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 128, 189, 63))),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 25.0, left: 25, bottom: 25),
              child: TextFormField(
                controller: _namecontroller,
                decoration: InputDecoration(
                    label: const Text('Student Name'),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
                validator: (value) {
                  if (!RegExp(r'^[a-z A-Z]+$').hasMatch(value!) ||
                      value.length < 3) {
                    return 'please enter valid username';
                  } else {
                    return null;
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 25.0, left: 25, bottom: 25),
              child: TextFormField(
                controller: _agecontroller,
                decoration: InputDecoration(
                  label: const Text('Age'),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                validator: (value) {
                  if (RegExp(r'^[0-9][)]*$').hasMatch(value!) ||
                      value.length > 3 ||
                      value.isEmpty) {
                    return 'please enter valid Age';
                  } else {
                    return null;
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 25.0, left: 25, bottom: 25),
              child: TextFormField(
                controller: _classcontroller,
                decoration: InputDecoration(
                    label: const Text('Class'),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
                validator: (value) {
                  if (!RegExp(r'^[0-9][){0-2}]*$').hasMatch(value!) ||
                      value.isEmpty) {
                    return 'please enter valid Class';
                  } else {
                    return null;
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 25.0, left: 25, bottom: 25),
              child: TextFormField(
                controller: _Regcontroller,
                decoration: InputDecoration(
                    label: const Text('RegNum'),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
                validator: (value) {
                  if (!RegExp(r'^[0-9][){0-5}]*$').hasMatch(value!) ||
                      value.isEmpty) {
                    return 'please enter valid Regnum';
                  } else {
                    return null;
                  }
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: const Color.fromARGB(255, 128, 189, 63)),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      checkLogin(context);
                    }
                  },
                  child: const Text('ADD'),
                ),
              ],
            )
          ],
        )),
      ),
    );
  }

  checkLogin(BuildContext context) {
    final _name = _namecontroller.text;
    final _age = _agecontroller.text;
    final _class1 = _classcontroller.text;
    final _reg = _Regcontroller.text;

    final _student = Stud_model(
        age: _age, regnum: _reg, class1: _class1, name: _name, img: img);
    context.read<Counter>().addStudent(_student);
    context.read<Counter>().studentListNotifier.clear();
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      backgroundColor: Color.fromARGB(255, 72, 202, 77),
      content: Text('Data Entered SuccessFully'),
    ));

    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => ListStud()), (route) => false);
  }
}
