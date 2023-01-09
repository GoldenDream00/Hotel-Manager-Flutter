import 'package:flutter/material.dart';

import '../../Data/user.dart';
import '../../Services/userDB.dart';
import '../../Utils/global.dart';
import 'signup.dart';

class UserLogin extends StatefulWidget {
  const UserLogin({super.key});

  @override
  State<UserLogin> createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController userController = TextEditingController();
  TextEditingController passController = TextEditingController();
  String msg = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: darkGreen1,
        elevation: 0,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: darkGreen1,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 64),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Log In",
                  style: TextStyle(
                    fontSize: 48,
                    height: 1.1,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "as Customer",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 32),
                TextFormField(
                  controller: userController,
                  style: formTextDecoration,
                  cursorColor: Colors.lightGreen,
                  decoration: formFieldDecoration("Full Name"),
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return "*This is a required Field";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: passController,
                  keyboardType: TextInputType.multiline,
                  obscureText: true,
                  style: formTextDecoration,
                  decoration: formFieldDecoration("Password"),
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return "*This is a required Field";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                msg != "" ? errorWidget() : const Center(),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        onPressedSubmit();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        shape: const StadiumBorder(), elevation: 0),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Text(
                        "Submit",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 80),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () => moveToUserSignUp(context),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(
                        color: Colors.lightGreen,
                        width: 2,
                      ),
                      shape: const StadiumBorder(),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Text(
                        "Create an Account",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  var formTextDecoration = const TextStyle(
    fontSize: 16,
    color: Colors.white,
    fontWeight: FontWeight.w500,
  );

  formFieldDecoration(String labelText) {
    return InputDecoration(
      labelText: labelText,
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(100.0)),
      labelStyle: const TextStyle(
        color: Colors.white60,
      ),
      filled: true,
      focusColor: Colors.lightGreen,
      fillColor: Colors.white10,
    );
  }

  Widget errorWidget() {
    return Center(
      child: Text(
        msg,
        style: const TextStyle(
          color: Colors.red,
          fontSize: 16,
        ),
      ),
    );
  }

  void onPressedSubmit() async {
    var db = UserDBProvider.db;
    var name = userController.text;
    var pass = passController.text;

    User entry = await db.searchuser(name);
    if (pass == entry.password) {
      msg = "";
      Navigator.pushNamed(context, '/userHome',
          arguments: UserArguments(entry));
    } else {
      setState(() {
        msg = "Username or password is incorrect";
      });
    }
  }

  moveToUserSignUp(BuildContext context) {
    return Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const UserSignUp()),
    );
  }
}
