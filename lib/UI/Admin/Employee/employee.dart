import 'package:flutter/material.dart';
import 'package:hotelapp/Data/employee.dart' as data;
import 'package:hotelapp/Utils/global.dart';
import '../../../Services/employeeDB.dart';
import 'employeeTile.dart';
import 'newDialog.dart';
import 'updateDialog.dart';

class Employee extends StatefulWidget {
  const Employee({super.key});

  @override
  State<Employee> createState() => _EmployeeState();
}

class _EmployeeState extends State<Employee> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkGreen2,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: FutureBuilder(
          future: EmployeeDBProvider.db.getAllEmployee(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.data != null) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Employees',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: const StadiumBorder()),
                      onPressed: () {
                        EmployeeDBProvider.db.resetAttendance();
                        listRefresh();
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Text(
                          "Reset Attendance",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return EmployeeTile(
                        entry: snapshot.data[index],
                        updateEmployeeDialog: updateEmployeeDialog,
                        updateAttendance: updateAttendance,
                      );
                    },
                  ),
                  const SizedBox(height: 140),
                ],
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: customFAB(context),
    );
  }

  customFAB(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => newRoomDialog(context),
      backgroundColor: Colors.lightGreen,
      child: const Icon(Icons.add),
    );
  }

  newRoomDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return NewEmployeeForm();
      },
    ).then((value) => setState(() {}));
  }

  updateEmployeeDialog(BuildContext context, data.Employee entry) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return UpdateEmployeeForm(entry: entry);
      },
    ).then((value) => setState(() {}));
  }

  updateAttendance(data.Employee entry) {
    setState(() {
      entry.present = entry.present == 1 ? 0 : 1;
      EmployeeDBProvider.db.updateEmployee(entry);
    });
  }

  listRefresh() {
    setState(() {});
  }
}
