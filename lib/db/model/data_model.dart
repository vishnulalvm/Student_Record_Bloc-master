import 'package:hive_flutter/adapters.dart';
import 'package:hive/hive.dart';
part 'data_model.g.dart';

@HiveType(typeId: 1)
class StudentModel {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String name;
  @HiveField(2)
  int age;
  @HiveField(3)
  String email;
  @HiveField(4)
  int contact;
  @HiveField(5)
  String? imagePath;
  StudentModel({
    required this.name,
    required this.age,
    required this.email,
    required this.contact,
    this.imagePath,
    this.id,
  });
}
