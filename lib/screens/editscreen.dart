import 'dart:io';

import 'package:crud/functions/db_function.dart';
import 'package:crud/models/model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// ignore: must_be_immutable
class Editscreen extends StatefulWidget {
  int index;
  final String name;
  final String age;
  final String cls;
  final String address;
  dynamic imagePath;
  Editscreen(
      {super.key,
      required this.index,
      required this.name,
      required this.age,
      required this.cls,
      required this.address,
      required this.imagePath});

  @override
  State<Editscreen> createState() => _EditscreenState();
}

class _EditscreenState extends State<Editscreen> {
  File? image;
  TextEditingController name = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController cls = TextEditingController();
  TextEditingController address = TextEditingController();

  @override
  Widget build(BuildContext context) {
    name = TextEditingController(text: widget.name);
    age = TextEditingController(text: widget.age);
    cls = TextEditingController(text: widget.cls);
    address = TextEditingController(text: widget.address);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Center(
              child: Card(
                color: Colors.yellow,
                elevation: 20,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundImage: image != null
                            ? FileImage(image!)
                            : const AssetImage('assets/Unknown_person.jpg'),
                      
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
                        height: 20,
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
                        height: 20,
                      ),
                      TextFormField(
                        controller: age,
                        decoration: InputDecoration(
                          labelText: 'Age',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
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
                        height: 20,
                      ),
                      TextFormField(
                        controller: address,
                        decoration: InputDecoration(
                          labelText: 'Addres',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          addStudentClick();
                          Navigator.pop(context);
                        },
                        child: const Text('Save'),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void addStudentClick() {
    if (name.text.isEmpty ||
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
    final data = StudentModel(
        name: name.text,
        age: age.text,
        address: address.text,
        cls: cls.text,
        imagePath: image?.path ?? '');
    editStudent(widget.index, data);
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
