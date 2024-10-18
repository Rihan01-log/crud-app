import 'package:hive/hive.dart';
part 'model.g.dart';

@HiveType(typeId: 0)
class StudentModel {
  @HiveField(0)
  String name;

  @HiveField(1)
  String age;
  @HiveField(2)
  String address;
  @HiveField(3)
  String cls;
  @HiveField(4)
  String? imagePath;
  StudentModel(
      {required this.name,
      required this.age,
      required this.address,
      required this.cls,
      required this.imagePath});
}
