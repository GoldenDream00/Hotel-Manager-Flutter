import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hotelapp/Data/employee.dart';
import 'package:hotelapp/Utils/global.dart';

import '../../../Services/employeeDB.dart';

typedef updateDialogCallback = void Function(
    BuildContext context, Employee entry);
typedef updateAttendanceCallback = void Function(Employee entry);

class EmployeeTile extends StatefulWidget {
  final Employee entry;
  final updateDialogCallback updateEmployeeDialog;
  final updateAttendanceCallback updateAttendance;
  EmployeeTile({
    super.key,
    required this.entry,
    required this.updateEmployeeDialog,
    required this.updateAttendance,
  });

  @override
  EmployeeTileState createState() => EmployeeTileState();
}

class EmployeeTileState extends State<EmployeeTile> {
  double diameter = 28;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: darkGreen1,
        borderRadius: BorderRadius.circular(32),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              IconButton(
                icon: widget.entry.present == 1 ? circleOn() : circleOff(),
                onPressed: () => widget.updateAttendance(widget.entry),
              ),
              const SizedBox(width: 8),
              Text(
                widget.entry.name,
                style: textDecoration,
              ),
            ],
          ),
          Row(
            children: [
              Text(
                widget.entry.phone,
                style: textDecoration,
              ),
              const SizedBox(width: 8),
              IconButton(
                padding: EdgeInsets.zero,
                onPressed: () =>
                    widget.updateEmployeeDialog(context, widget.entry),
                icon: const Icon(
                  Icons.edit_outlined,
                  color: Colors.lightGreen,
                  size: 20,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  var textDecoration = const TextStyle(
    fontSize: 16,
    color: Colors.white,
    fontWeight: FontWeight.w500,
  );

  circleOn() {
    return const Icon(
      Icons.check_circle,
      color: Colors.lightGreen,
      size: 20,
    );
  }

  circleOff() {
    return const Icon(
      Icons.circle_outlined,
      color: Colors.white70,
      size: 20,
    );
  }
}
