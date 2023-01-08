import 'package:flutter/material.dart';
import 'package:hotelapp/Data/room.dart';
import 'package:hotelapp/Utils/global.dart';

class RoomTile extends StatefulWidget {
  VoidCallback? listUpdator;
  Room? entry;
  RoomTile({Key? key, entry, listUpdator}) : super(key: key);

  @override
  RoomTileState createState() => RoomTileState();
}

class RoomTileState extends State<RoomTile> {
  double diameter = 28;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      color: darkGreen1,
      child: ElevatedButton(
        onPressed: () {
          // showDialog(
          //   context: context,
          //   child: UpdateTodoForm(
          //     entry: widget.entry,
          //     listUpdator: widget.listUpdator,
          //   ),
          // );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 24, top: 22, bottom: 22),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "${widget.entry!.name}",
                      style: titleStyle(),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      "${widget.entry!.type}",
                      style: bodyStyle(),
                    ),
                  ],
                ),
              ),
            ),
            widget.entry!.occupied == 1 ? circleOn() : circleOff(),
          ],
        ),
      ),
    );
  }

  titleStyle() {
    return const TextStyle(
        fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600);
  }

  bodyStyle() {
    return const TextStyle(
        fontSize: 16,
        color: Colors.white70,
        height: 1.5,
        fontWeight: FontWeight.w400);
  }

  circleOn() {
    return const Padding(
      padding: EdgeInsets.all(7),
      child: Icon(
        Icons.task_alt,
        color: Colors.lightGreen,
      ),
    );
  }

  circleOff() {
    return const Padding(
      padding: EdgeInsets.all(7),
      child: Icon(
        Icons.circle_outlined,
        color: Colors.white70,
      ),
    );
  }
}
