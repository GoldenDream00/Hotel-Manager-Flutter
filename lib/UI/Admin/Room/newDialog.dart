import 'package:flutter/material.dart';
import 'package:hotelapp/Data/room.dart';
import 'package:hotelapp/Utils/global.dart';

import '../../../Services/roomDB.dart';

class NewRoomForm extends StatefulWidget {
  VoidCallback? listUpdator;
  NewRoomForm({Key? key, listUpdator}) : super(key: key);

  @override
  NewRoomFormState createState() => NewRoomFormState();
}

class NewRoomFormState extends State<NewRoomForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();

  static const List<String> type = <String>[
    'Single',
    'Double',
    'Suite',
    'Luxury'
  ];
  String dropdownValue = type.first;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        width: 300,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Text(
                "New Room",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: nameController,
                style: formTextDecoration,
                cursorColor: Colors.lightGreen,
                decoration: formFieldDecoration("Room No."),
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return "*This is a required Field";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField(
                value: dropdownValue,
                decoration: InputDecoration(
                  fillColor: Colors.white38,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100.0)),
                ),
                dropdownColor: Colors.black,
                icon: const Icon(Icons.arrow_drop_down),
                elevation: 16,
                style: const TextStyle(color: Colors.white),
                onChanged: (String? value) {
                  setState(() {
                    dropdownValue = value!;
                  });
                },
                items: type.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                      value: value, child: Text(value));
                }).toList(),
              ),
              const SizedBox(height: 40),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(shape: const StadiumBorder()),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      onPressedCreate();
                    }
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Text(
                      "Create Room",
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

  typeSelectMenu() {}

  onPressedCreate() async {
    Room entry = Room();
    entry.name = nameController.text;
    entry.type = dropdownValue;
    entry.occupied = 0;

    var db = RoomDBProvider.db;
    db.newRoom(entry);
    List<Room> temp = await db.getAllRoom();
    print(temp.length);
    widget.listUpdator!();

    // ignore: use_build_context_synchronously
    Navigator.pop(context);
  }
}
