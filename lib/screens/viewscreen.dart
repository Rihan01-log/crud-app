import 'dart:io';

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Viewscreen extends StatelessWidget {
  String name;
  String age;
  String cls;
  String address;
  dynamic imagePath;
  Viewscreen(
      {super.key,
      required this.name,
      required this.age,
      required this.cls,
      required this.address,
      required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Card(
          margin: const EdgeInsets.all(50),
          child: Padding(
            padding: const EdgeInsets.all(100),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 100,
                  backgroundImage: FileImage(File(imagePath)),
                ),
                const SizedBox(
                  height: 10,
                ),
                Title(
                  color: const Color.fromARGB(255, 0, 0, 0),
                  child: Text(
                    'Name:$name',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Title(
                  color: const Color.fromARGB(255, 0, 0, 0),
                  child: Text(
                    "Age:$age",
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Title(
                  color: const Color.fromARGB(255, 0, 0, 0),
                  child: Text(
                    'class:$cls',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Title(
                    color: const Color.fromARGB(255, 0, 0, 0),
                    child: Text(
                      'addres: $address',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
