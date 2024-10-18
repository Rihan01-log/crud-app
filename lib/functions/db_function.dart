import 'package:crud/models/model.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

ValueNotifier<List<StudentModel>> studentListNotifier = ValueNotifier([]);

Future<void> addStudent(StudentModel value) async {
  final studentDB = await Hive.openBox<StudentModel>('database');
  await studentDB.add(value);
  getStudent();
}

Future<void> getStudent() async {
  final studentDB = await Hive.openBox<StudentModel>('database');
  studentListNotifier.value.clear();
  studentListNotifier.value.addAll(studentDB.values);
  studentListNotifier.notifyListeners();
}

Future<void> editStudent(int index, StudentModel value) async {
  final studentDB = await Hive.openBox<StudentModel>('database');
  await studentDB.putAt(index, value);
  getStudent();
}

Future<void> deleteStudent(int index) async {
  final studentDB = await Hive.openBox<StudentModel>('database');
  await studentDB.deleteAt(index);
  getStudent();
}
