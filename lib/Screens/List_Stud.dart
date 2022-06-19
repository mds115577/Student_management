import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 128, 189, 63),
        title: const Center(child: Text('Home')),
        actions: [
          IconButton(
              onPressed: () {
                context.read<Counter>().searchData.clear();
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => SearchStud()));
              },
              icon: const Icon(Icons.search))
        ],
      ),
      body: SafeArea(
        child: Consumer<Counter>(
          builder: (context, datas, _) {
            return ListView.separated(
              itemBuilder: (context, index) {
                final data = datas.studentListNotifier[index];
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
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: ((context) =>
                                      Stud_update(data: data, editor: true)),
                                ),
                              );
                            },
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.lightBlue,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              if (data.id != null) {
                                context.read<Counter>().deletestudent(index);
                              }
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctx1) => StudProf(
                              data: data,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
              separatorBuilder: (ctx, index) {
                return const Divider();
              },
              itemCount: datas.studentListNotifier.length,
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          img = '';
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: ((context) => Add(
                    data: data,
                  )),
            ),
          );
        },
        child: const Icon(Icons.add),
        backgroundColor: const Color.fromARGB(255, 128, 189, 63),
      ),
    );
  }
}
