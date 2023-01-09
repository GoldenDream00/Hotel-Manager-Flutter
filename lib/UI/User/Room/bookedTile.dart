import 'package:flutter/material.dart';
import '../../../Data/room.dart';
import '../../../Data/user.dart';
import '../../../Utils/global.dart';
import 'roomDetail.dart';

typedef updateCallback = void Function(BuildContext context, Room entry);

class BookedTile extends StatefulWidget {
  final Room entry;
  final updateCallback deleteRoomDialog;
  BookedTile({
    super.key,
    required this.entry,
    required this.deleteRoomDialog,
  });

  @override
  BookedTileState createState() => BookedTileState();
}

class BookedTileState extends State<BookedTile> {
  double diameter = 28;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      margin: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: darkGreen1,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.horizontal(
                  left: Radius.circular(100),
                  right: Radius.circular(0),
                ),
                image: DecorationImage(
                  image: AssetImage("assets/${widget.entry.type}.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 28),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${widget.entry.type} Room",
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Room: ${widget.entry.name}",
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            padding: EdgeInsets.zero,
            onPressed: () => widget.deleteRoomDialog(context, widget.entry),
            icon: const Icon(
              Icons.delete_outline,
              color: Colors.red,
              size: 20,
            ),
          ),
          const SizedBox(width: 32),
        ],
      ),
    );
  }
}
