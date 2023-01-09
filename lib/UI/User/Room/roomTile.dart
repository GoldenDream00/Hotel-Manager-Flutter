import 'package:flutter/material.dart';
import '../../../Data/room.dart';
import '../../../Data/user.dart';
import '../../../Utils/global.dart';
import 'roomDetail.dart';

class RoomTile extends StatefulWidget {
  final String name;
  final String description;
  final int num;
  final User user;
  RoomTile(
      {super.key,
      required this.name,
      required this.num,
      required this.user,
      required this.description});

  @override
  RoomTileState createState() => RoomTileState();
}

class RoomTileState extends State<RoomTile> {
  double diameter = 28;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: darkGreen1,
        borderRadius: BorderRadius.circular(32),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 160,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(32),
                bottom: Radius.circular(0),
              ),
              image: DecorationImage(
                image: AssetImage("assets/${widget.name}.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${widget.name} Rooms",
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Vacant: ${widget.num.toString()}",
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 92,
                  child: ElevatedButton(
                    onPressed: () => moveToRoomDetail(context),
                    style: ElevatedButton.styleFrom(
                        shape: const StadiumBorder(), elevation: 0),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Text(
                        "Book",
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
        ],
      ),
    );
  }

  moveToRoomDetail(BuildContext context) {
    return Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RoomDetail(
            user: widget.user,
            name: widget.name,
            num: widget.num,
            description: widget.description,
          ),
        )).then((value) => setState(() {}));
  }
}
