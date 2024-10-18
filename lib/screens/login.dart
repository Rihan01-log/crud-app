import 'package:crud/screens/homescreen.dart';
import 'package:crud/screens/signin.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  String message = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.lock,
                  size: 100,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: username,
                  decoration: InputDecoration(
                      labelText: "Username",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: password,
                  decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    checkLog();
                  },
                  child: const Text('Login'),
                ),
                const SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => const Signin()));
                  },
                  child: const Text('Are you new here?Register now'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void checkLog() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final storedUsername = prefs.getString(userkey);
    final storedPass = prefs.getString(passKey);
    final usrname = username.text;
    final pass = password.text;
    if (storedUsername == usrname && storedPass == pass) {
      prefs.setBool(isLoggedIn, true);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (ctx) => const Homescreen()));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Please Register')));
    }
  }
}
