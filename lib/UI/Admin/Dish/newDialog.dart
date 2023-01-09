import 'package:flutter/material.dart';
import 'package:hotelapp/Utils/global.dart';
import '../../../Data/dish.dart';
import '../../../Services/dishDB.dart';

class NewDishForm extends StatefulWidget {
  const NewDishForm({super.key});

  @override
  NewDishFormState createState() => NewDishFormState();
}

class NewDishFormState extends State<NewDishForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController numController = TextEditingController();
  TextEditingController photoController = TextEditingController();
  String dropdownValue = type.first;

  static const List<String> type = <String>[
    'Drinks',
    'Veg',
    'Non-Veg',
    'Snack'
  ];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: darkGreen1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
      content: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          width: 300,
          padding: EdgeInsets.symmetric(vertical: 24),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Text(
                  "New Dish",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 32),
                TextFormField(
                  controller: nameController,
                  style: formTextDecoration,
                  cursorColor: Colors.lightGreen,
                  decoration: formFieldDecoration("Dish Name"),
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return "*This is a required Field";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: numController,
                  style: formTextDecoration,
                  keyboardType: TextInputType.number,
                  cursorColor: Colors.lightGreen,
                  decoration: formFieldDecoration("Stock"),
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return "*This is a required Field";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: photoController,
                  style: formTextDecoration,
                  cursorColor: Colors.lightGreen,
                  decoration: formFieldDecoration("Photo URL"),
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return "*This is a required Field";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white12,
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                  child: DropdownButtonFormField(
                    value: dropdownValue,
                    dropdownColor: darkGreen2,
                    decoration: const InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
                    ),
                    icon: const Icon(Icons.arrow_drop_down),
                    style: const TextStyle(color: Colors.white),
                    onChanged: (String? value) {
                      setState(() {
                        dropdownValue = value!;
                      });
                    },
                    items: type.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: formTextDecoration,
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 40),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(shape: const StadiumBorder()),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        onPressedCreate();
                      }
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Text(
                        "Create Dish",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
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
      fillColor: Colors.white10,
    );
  }

  onPressedCreate() async {
    Dish entry = Dish();
    entry.name = nameController.text;
    entry.type = dropdownValue;
    entry.num = int.parse(numController.text);
    entry.photo = photoController.text;

    var db = DishDBProvider.db;
    db.newDish(entry);
    List<Dish> temp = await db.getAllDish();
    print(temp.length);

    Navigator.pop(context);
  }
}
