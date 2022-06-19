import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:provider/provider.dart';
import 'package:student_manag/db_funct/data_model.dart';
import 'package:student_manag/db_funct/database.dart';
import 'package:student_manag/Screens/List_Stud.dart';

class Stud_update extends StatelessWidget {
  final Stud_model data;
  bool? editor;
  final _nameformController = TextEditingController();
  final _ageformController = TextEditingController();
  final _class1formController = TextEditingController();
  final _regnumformController = TextEditingController();

  Stud_update({Key? key, this.editor, required this.data}) : super(key: key);
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    _nameformController.text = data.name;
    _ageformController.text = data.age;
    _class1formController.text = data.class1;
    _regnumformController.text = data.regnum;
    final Cont _cont = Get.put(Cont());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 128, 189, 63),
        title: Text(data.name),
      ),
      body: SafeArea(
          child: Form(
        key: _formkey,
        child: ListView(
          children: [
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                const Text(
                  'Edit Your Details',
                  style: TextStyle(fontSize: 30),
                ),
              ],
            ),
            GetBuilder<Cont>(builder: (cont) {
              if (editor == true) {
                img = data.img;
                editor = false;
              }
              return CircleAvatar(
                radius: 60,
                backgroundImage: MemoryImage(
                  const Base64Decoder().convert(img),
                ),
              );
            }),
            IconButton(
                onPressed: () async {
                  _cont.pickimage();
                },
                icon: const Icon(Icons.add_a_photo)),
            Padding(
              padding: const EdgeInsets.only(top: 18.0, left: 20, right: 20),
              child: TextFormField(
                controller: _nameformController,
                decoration: const InputDecoration(
                  label: Text('Name'),
                  border: OutlineInputBorder(),
                ),
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
              padding: const EdgeInsets.only(top: 18.0, left: 20, right: 20),
              child: TextFormField(
                controller: _ageformController,
                decoration: const InputDecoration(
                  label: Text('Age'),
                  border: OutlineInputBorder(),
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
              padding: const EdgeInsets.only(top: 18.0, left: 20, right: 20),
              child: TextFormField(
                maxLength: 2,
                controller: _class1formController,
                decoration: const InputDecoration(
                  label: Text('Class'),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (!RegExp(r'^[0-9][){0-2}]*$').hasMatch(value!) ||
                      value.isEmpty ||
                      value.length > 12) {
                    return 'please enter valid Class';
                  } else {
                    return null;
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 18.0, left: 20, right: 20),
              child: TextFormField(
                controller: _regnumformController,
                decoration: const InputDecoration(
                  label: Text('RegNum'),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (!RegExp(r'^[0-9][){0-9}]*$').hasMatch(value!) ||
                      value.isEmpty) {
                    return 'please enter valid Regnum';
                  } else {
                    return null;
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        primary: const Color.fromARGB(255, 128, 189, 63),
                      ),
                      onPressed: () {
                        if (_formkey.currentState!.validate()) {
                          update(context);
                        }
                      },
                      icon: const Icon(Icons.update),
                      label: const Text('Update')),
                ],
              ),
            )
          ],
        ),
      )),
    );
  }

  update(BuildContext context) {
    final _name = _nameformController.text;
    final _age = _ageformController.text;
    final _class1 = _class1formController.text;
    final _reg = _regnumformController.text;
    if (_name.isEmpty || _age.isEmpty || _class1.isEmpty || _reg.isEmpty) {
      return ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.red,
        content: Text('Please Enter Valid Datas'),
      ));
    } else {
      final _student = Stud_model(
          age: _age,
          regnum: _reg,
          class1: _class1,
          name: _name,
          id: data.id,
          img: img);
      context.read<Counter>().UpdateStudent(_student);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Color.fromARGB(255, 72, 202, 77),
        content: Text('Data Entered SuccessFully'),
      ));
    }
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => ListStud()), (route) => false);
  }
}
