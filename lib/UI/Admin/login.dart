import 'package:flutter/material.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
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
        backgroundColor: const Color.fromARGB(255, 31, 42, 27),
        elevation: 0,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: const Color.fromARGB(255, 31, 42, 27),
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
                  "as Manager",
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
                  decoration: formFieldDecoration("Username"),
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
    var name = userController.text;
    var pass = passController.text;

    if (pass == "root" && name == "admin") {
      msg = "";
      print("Success :D");
    } else {
      setState(() {
        msg = "Username or password is incorrect";
      });
    }
  }
}
