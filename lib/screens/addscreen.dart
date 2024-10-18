import 'dart:io';

import 'package:crud/functions/db_function.dart';
import 'package:crud/models/model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Addscreen extends StatefulWidget {
  const Addscreen({super.key});

  @override
  State<Addscreen> createState() => _AddscreenState();
}

class _AddscreenState extends State<Addscreen> {
  File? image;
  final TextEditingController name = TextEditingController();
  final TextEditingController age = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController cls = TextEditingController();
  final List<StudentModel> students = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Card(
            margin: const EdgeInsets.all(20),
            color: Colors.yellow,
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  image != null
                      ? CircleAvatar(
                          backgroundImage: FileImage(image!),
                          radius: 60,
                        )
                      : const CircleAvatar(
                          radius: 60,
                          backgroundImage:
                              AssetImage("assets/Unknown_person.jpg"),
                        ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        pickImage();
                      },
                      child: const Text('Image')),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: name,
                    decoration: InputDecoration(
                      labelText: 'Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: age,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Age',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: cls,
                    decoration: InputDecoration(
                      labelText: 'Class',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: address,
                    decoration: InputDecoration(
                        labelText: 'Address',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20))),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      addStudentClick();
                    },
                    child: const Text('Add'),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void addStudentClick() {
    if (name .text.isEmpty ||
        age.text.isEmpty ||
        address.text.isEmpty ||
        cls.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Type something'),
        ),
      );
      return;
    }

    final student = StudentModel(
        name: name.text,
        age: age.text,
        address: address.text,
        cls: cls.text,
        imagePath: image?.path ?? '');
    addStudent(student);
    Navigator.pop(context);
  }

  Future<void> pickImage() async {
    final returnimage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnimage == null) {
      return;
    }
    setState(() {
      image = File(returnimage.path);
    });
  }
}
