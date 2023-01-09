import 'package:flutter/material.dart';
import 'package:hotelapp/Utils/global.dart';
import '../../../Data/employee.dart';
import '../../../Services/employeeDB.dart';

class UpdateEmployeeForm extends StatefulWidget {
  UpdateEmployeeForm({super.key, required this.entry});
  final Employee entry;

  @override
  UpdateEmployeeFormState createState() => UpdateEmployeeFormState();
}

class UpdateEmployeeFormState extends State<UpdateEmployeeForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  var db = EmployeeDBProvider.db;

  @override
  void initState() {
    super.initState();
    nameController.text = widget.entry.name;
    phoneController.text = widget.entry.phone;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: darkGreen1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
      content: Container(
        width: 300,
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Edit Employee",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Colors.white,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete_outline),
                      onPressed: () => onPressedDelete(),
                      color: Colors.red,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              TextFormField(
                controller: nameController,
                style: formTextDecoration,
                cursorColor: Colors.lightGreen,
                decoration: formFieldDecoration("Employee Name"),
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
                keyboardType: TextInputType.number,
                style: formTextDecoration,
                cursorColor: Colors.lightGreen,
                decoration: formFieldDecoration("Phone No."),
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return "*This is a required Field";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 40),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(shape: const StadiumBorder()),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      onPressedUpdate();
                    }
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Text(
                      "Update Employee",
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

  onPressedCancel() {
    Navigator.pop(context);
  }

  onPressedUpdate() async {
    widget.entry.name = nameController.text;
    widget.entry.phone = phoneController.text;

    db.updateEmployee(widget.entry);
    Navigator.pop(context);
  }

  onPressedDelete() async {
    db.deleteEmployee(widget.entry.id!.toInt());
    Navigator.pop(context);
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
}
