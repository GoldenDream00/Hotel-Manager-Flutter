import 'package:flutter/material.dart';
import '../../../Data/user.dart';
import '../../../Services/userDB.dart';
import '../../../Utils/global.dart';

class UserEdit extends StatefulWidget {
  final User user;
  const UserEdit({super.key, required this.user});

  @override
  State<UserEdit> createState() => _UserEditState();
}

class _UserEditState extends State<UserEdit> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController userController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    userController.text = widget.user.name;
    passController.text = widget.user.password;
    phoneController.text = widget.user.phone;
    emailController.text = widget.user.email;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90,
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
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Edit \nProfile",
                  style: TextStyle(
                    fontSize: 48,
                    height: 1.1,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 40),
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
                TextFormField(
                  controller: phoneController,
                  style: formTextDecoration,
                  keyboardType: TextInputType.number,
                  cursorColor: Colors.lightGreen,
                  decoration: formFieldDecoration("Phone Number"),
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return "*This is a required Field";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: emailController,
                  style: formTextDecoration,
                  keyboardType: TextInputType.emailAddress,
                  cursorColor: Colors.lightGreen,
                  decoration: formFieldDecoration("Email"),
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return "*This is a required Field";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 32),
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
                const SizedBox(height: 64),
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

  void onPressedSubmit() async {
    widget.user.name = userController.text;
    widget.user.password = passController.text;
    widget.user.phone = phoneController.text;
    widget.user.email = emailController.text;

    var db = UserDBProvider.db;
    db.updateUser(widget.user);

    // ignore: use_build_context_synchronously
    Navigator.of(context).pop();
  }
}
