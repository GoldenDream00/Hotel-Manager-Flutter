import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hotelapp/Utils/global.dart';
import 'package:image_picker/image_picker.dart';
import 'Data/dish.dart';
import 'Services/api.dart';
import 'Services/dishDB.dart';

class NewDishForm extends StatefulWidget {
  const NewDishForm({super.key});

  @override
  NewDishFormState createState() => NewDishFormState();
}

class NewDishFormState extends State<NewDishForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  var isLoading = false;
  var file, imagePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkGreen2,
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 0,
        backgroundColor: darkGreen2,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 24, horizontal: 24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Create \n3D Model",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 40,
                    height: 1.25,
                    color: Colors.white,
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(height: 32),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(32.0),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          elevation: MaterialStateProperty.all<double>(0),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(darkGreen1),
                          padding: MaterialStateProperty.all<EdgeInsets>(
                              const EdgeInsets.all(0)),
                        ),
                        onPressed: () {
                          pickImage();
                        },
                        child: Container(
                          height: 300,
                          width: double.infinity,
                          child: file == null
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Icon(
                                      Icons.add_circle_outline,
                                      color: Colors.lightGreen,
                                      size: 64,
                                    ),
                                    SizedBox(height: 12),
                                    Text(
                                      "Pick Image",
                                      style: TextStyle(
                                          color: Colors.lightGreen,
                                          fontSize: 16),
                                    )
                                  ],
                                )
                              : Image.file(
                                  file,
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    TextFormField(
                      controller: nameController,
                      style: formTextDecoration,
                      cursorColor: Colors.lightGreen,
                      decoration: formFieldDecoration("Model Name"),
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return "*This is a required Field";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    const SizedBox(height: 40),
                    Container(
                      width: double.infinity,
                      height: 64,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: const StadiumBorder()),
                        onPressed: () {
                          if (_formKey.currentState!.validate() &&
                              isLoading == false) {
                            onPressedCreate();
                          }
                        },
                        child: !isLoading
                            ? const Text(
                                "Remove Background",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              )
                            : Container(
                                height: 24,
                                width: 24,
                                child: const CircularProgressIndicator(
                                  color: Colors.black,
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
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
      fillColor: darkGreen1,
    );
  }

  onPressedCreate() async {
    setState(() {
      isLoading = true;
    });

    Dish entry = Dish();
    entry.name = nameController.text;
    entry.photo = imagePath;

    var db = DishDBProvider.db;
    db.newDish(entry);

    tempImg = null;
    tempImg = await Api.removebg(imagePath);

    setState(() {
      isLoading = false;
    });

    if (tempImg != null) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => GenerateModel()));
    }
  }

  Future pickImage() async {
    final XFile? pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        file = File(pickedFile.path);
        imagePath = file.path;
        print(imagePath);
      });
    }
  }
}

class GenerateModel extends StatefulWidget {
  const GenerateModel({super.key});

  @override
  State<GenerateModel> createState() => _GenerateModelState();
}

class _GenerateModelState extends State<GenerateModel> {
  var isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkGreen2,
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 0,
        backgroundColor: darkGreen2,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 24, horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "View Image",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 40,
                  height: 1.25,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 24),
              Container(
                height: 300,
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(32.0),
                  child: Image.memory(tempImg, fit: BoxFit.cover,),
                ),
              ),
              const SizedBox(height: 36),
              Container(
                width: double.infinity,
                height: 64,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(shape: const StadiumBorder()),
                  onPressed: () {
                    if (isLoading == false) {
                      onPressedGenerate();
                    }
                  },
                  child: !isLoading
                      ? const Text(
                          "Generate 3D Model",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      : Container(
                          height: 24,
                          width: 24,
                          child: const CircularProgressIndicator(
                            color: Colors.black,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  onPressedGenerate() async {
    setState(() {
      isLoading = true;
    });

    await Future<void>.delayed(const Duration(seconds: 2));

    setState(() {
      isLoading = false;
    });

    Navigator.of(context)
        .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
  }
}
