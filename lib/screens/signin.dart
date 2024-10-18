import 'package:crud/screens/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  State<Signin> createState() => _SigninState();
}

final userkey = 'userkey';
final passKey = 'passkey';
final isLoggedIn = 'isLogged';

class _SigninState extends State<Signin> {
  final TextEditingController usernameCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Card(
          shadowColor: Colors.black,
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.lock,
                  size: 100,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: usernameCtrl,
                  decoration: InputDecoration(
                      labelText: "Username",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                    controller: passwordCtrl,
                    decoration: InputDecoration(
                        labelText: "Password",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)))),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    onPressed: () {
                      checkSignin();
                    },
                    child: const Text('Sign in'))
              ],
            ),
          ),
        ),
      ),
    );
  }

  void checkSignin() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final username = usernameCtrl.text;
    final password = passwordCtrl.text;
    if (username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("fill all the feild")));
    } else {
      pref.setString(userkey, username);
      pref.setString(passKey, password);
      pref.setBool(isLoggedIn, true);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Homescreen()));
    }
  }
}
