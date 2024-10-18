import 'dart:io';

import 'package:crud/functions/db_function.dart';
import 'package:crud/models/model.dart';
import 'package:crud/screens/addscreen.dart';
import 'package:crud/screens/editscreen.dart';
import 'package:crud/screens/login.dart';
import 'package:crud/screens/signin.dart';
import 'package:crud/screens/viewscreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  String search = '';
  List<StudentModel> searchList = [];
  void searchListUpdate() {
    getStudent();
    searchList = studentListNotifier.value
        .where((stdModel) =>
            stdModel.name.toLowerCase().contains(search.toLowerCase()))
        .toList();
  }

  void logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(isLoggedIn, false);

    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const LoginPage()));
  }

  @override
  Widget build(BuildContext context) {
    searchListUpdate();
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              logout();
            },
            icon: const Icon(
              Icons.logout,
            ),
          )
        ],
        backgroundColor: Colors.black,
        title: const Text(
          'STUDENT LIST',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const Addscreen()));
        },
        child: const Icon(
          Icons.add,
          color: Colors.blueAccent,
          size: 36,
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextFormField(
              style: const TextStyle(color: Colors.blue),
              onChanged: (value) {
                setState(() {
                  search = value;
                  searchListUpdate();
                });
              },
              decoration: const InputDecoration(
                labelText: 'Search',
                labelStyle: TextStyle(color: Colors.black),
                suffixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: ValueListenableBuilder<List<StudentModel>>(
              valueListenable: studentListNotifier,
              builder: (context, studentList, child) {
                return search.isNotEmpty
                    ? searchList.isEmpty
                        ? const Center(
                            child: Text('No result found'),
                          )
                        : buildStudentList(
                            searchList,
                          )
                    : buildStudentList(
                        studentList,
                      );
              },
            ),
          )
        ],
      ),
    );
  }

  Widget buildStudentList(
    List<StudentModel> students,
  ) {
    return students.isEmpty
        ? const Center(
            child: Text(
              'No student availabel',
              style: TextStyle(color: Colors.black),
            ),
          )
        : Padding(
            padding: const EdgeInsets.all(15),
            child: Card(
              elevation: 20,
              child: ListView.separated(
                  itemBuilder: (context, index) {
                    final data = students[index];
                    return ListTile(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => Viewscreen(
                              name: data.name,
                              age: data.age,
                              cls: data.cls,
                              address: data.address,
                              imagePath: data.imagePath!,
                            ),
                          ),
                        );
                      },
                      title: Text(data.name),
                      leading: CircleAvatar(
                        backgroundImage:
                            data.imagePath != null && data.imagePath!.isNotEmpty
                                ? FileImage(File(data.imagePath!))
                                : const AssetImage("assets/Unknown_person.jpg"),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Editscreen(
                                      index: index,
                                      name: data.name,
                                      age: data.age,
                                      cls: data.cls,
                                      address: data.address,
                                      imagePath: data.imagePath,
                                    ),
                                  ),
                                );
                              },
                              icon: const Icon(Icons.edit)),
                          IconButton(
                              onPressed: () {
                                setState(() {});
                                deleteStudent(index);
                              },
                              icon: const Icon(Icons.delete))
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Divider(
                      height: 5,
                      thickness: 3,
                    );
                  },
                  itemCount: students.length),
            ),
          );
  }
}
