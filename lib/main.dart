import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:student_manag/db_funct/data_model.dart';
import 'package:student_manag/db_funct/database.dart';
import 'package:student_manag/Screens/List_Stud.dart';

Future<void> main() async {
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(StudmodelAdapter().typeId)) {
    Hive.registerAdapter(StudmodelAdapter());
  }
  await getAllstud();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.lightGreen),
      debugShowCheckedModeBanner: false,
      home: ListStud(),
    );
  }
}
