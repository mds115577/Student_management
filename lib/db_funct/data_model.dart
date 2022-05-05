import 'package:hive_flutter/adapters.dart';
part 'data_model.g.dart';

@HiveType(typeId: 1)
class Stud_model {
  @HiveField(0)
  int? id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String age;
  @HiveField(3)
  final String regnum;
  @HiveField(4)
  final String class1;
  @HiveField(5)
  final String img;
  Stud_model(
      {required this.age,
      required this.regnum,
      required this.class1,
      required this.name,
      required this.img,
      this.id});
}
