import 'package:flutter/material.dart';
import 'package:hotelapp/Utils/global.dart';
import '../../../Data/room.dart';
import '../../../Data/user.dart';
import '../../../Services/roomDB.dart';

class RoomDetail extends StatefulWidget {
  final User user;
  final String name;
  final String description;
  final int num;
  const RoomDetail(
      {super.key,
      required this.user,
      required this.name,
      required this.num,
      required this.description});

  @override
  State<RoomDetail> createState() => _RoomDetailState();
}

class _RoomDetailState extends State<RoomDetail> {
  String dialogTitle = "";
  String dialogDesc = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkGreen2,
      appBar: AppBar(
        toolbarHeight: 64,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: darkGreen2,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Container(
              height: 400,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(32),
                image: DecorationImage(
                  image: AssetImage("assets/${widget.name}.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 32),
            Text(
              "${widget.name} Rooms",
              style: const TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Colors.lightGreen,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "VACANCIES: ${widget.num}",
              style: const TextStyle(
                fontSize: 16,
                letterSpacing: 2,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              widget.description,
              style: const TextStyle(
                color: Colors.white70,
                height: 1.6,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => bookRoom(),
                style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(), elevation: 0),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                    "Book Room",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }

  bookRoom() async {
    var db = RoomDBProvider.db;
    List<Room> temp = await db.findRoomsofType(widget.name);

    if (temp.isEmpty) {
      dialogTitle = "No Vacant Rooms";
      dialogDesc =
          "There are no vacant rooms for the selected type. Please try again later.";
    } else {
      Room bookedRoom = temp[0];
      bookedRoom.cid = widget.user.id!;
      bookedRoom.occupied = 1;
      db.updateRoom(bookedRoom);

      dialogTitle = "Room Booked";
      dialogDesc =
          "Room No. ${bookedRoom.name} was successfully booked. Hope you have a great time.";
    }

    finishDialog();
  }

  Future<void> finishDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: darkGreen1,
          title: Text(dialogTitle, style: const TextStyle(color: Colors.white)),
          content:
              Text(dialogDesc, style: const TextStyle(color: Colors.white)),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
          actions: <Widget>[
            TextButton(
              child: const Text('Continue'),
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    '/userHome', ModalRoute.withName('/'),
                    arguments: UserArguments(widget.user));
              },
            ),
          ],
        );
      },
    );
  }
}
