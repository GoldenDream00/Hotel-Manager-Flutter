import 'package:flutter/material.dart';
import 'package:hotelapp/Data/room.dart';
import 'package:hotelapp/Utils/global.dart';
import '../../../Services/roomDB.dart';

class NewRoomForm extends StatefulWidget {
  const NewRoomForm({super.key});

  @override
  NewRoomFormState createState() => NewRoomFormState();
}

class NewRoomFormState extends State<NewRoomForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  String dropdownValue = type.first;

  static const List<String> type = <String>[
    'Single',
    'Double',
    'Suite',
    'Luxury'
  ];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: darkGreen1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
      content: Container(
        width: 300,
        padding: EdgeInsets.symmetric(vertical: 24),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Text(
                "New Room",
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
                decoration: formFieldDecoration("Room No."),
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

  onPressedCreate() async {
    Room entry = Room();
    entry.name = nameController.text;
    entry.type = dropdownValue;
    entry.occupied = 0;
    entry.cid = -1;

    var db = RoomDBProvider.db;
    db.newRoom(entry);
    List<Room> temp = await db.getAllRoom();
    print(temp.length);

    Navigator.pop(context);
  }
}
