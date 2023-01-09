import 'package:flutter/material.dart';
import 'package:hotelapp/Data/room.dart';
import 'package:hotelapp/Utils/global.dart';

typedef updateCallback = void Function(BuildContext context, Room entry);

class RoomTile extends StatefulWidget {
  final Room entry;
  final updateCallback updateRoomDialog;
  RoomTile({super.key, required this.entry, required this.updateRoomDialog});

  @override
  RoomTileState createState() => RoomTileState();
}

class RoomTileState extends State<RoomTile> {
  double diameter = 28;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: BoxDecoration(
        color: darkGreen1,
        borderRadius: BorderRadius.circular(32),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          widget.entry.occupied == 1 ? circleOn() : circleOff(),
          Text(
            widget.entry.name,
            style: textDecoration,
          ),
          Text(
            widget.entry.type,
            style: textDecoration,
          ),
          IconButton(
              padding: EdgeInsets.zero,
              onPressed: () => widget.updateRoomDialog(context, widget.entry),
              icon: const Icon(
                Icons.edit_outlined,
                color: Colors.lightGreen,
                size: 20,
              ))
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
      Icons.check_box_rounded,
      color: Colors.lightGreen,
      size: 20,
    );
  }

  circleOff() {
    return const Icon(
      Icons.remove,
      color: Colors.white54,
      size: 20,
    );
  }
}
