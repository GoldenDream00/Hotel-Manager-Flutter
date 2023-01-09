import 'package:flutter/material.dart';
import 'package:hotelapp/Utils/global.dart';
import '../../../Data/user.dart';
import '../../../Data/room.dart';
import '../../../Services/roomDB.dart';
import 'roomTile.dart';

class RoomPage extends StatefulWidget {
  final User user;
  const RoomPage({super.key, required this.user});

  @override
  State<RoomPage> createState() => _RoomPageState();
}

class _RoomPageState extends State<RoomPage> {
  Map<String, int> roomType = {
    "Single": 0,
    "Double": 0,
    "Suite": 0,
    "Luxury": 0,
  };

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
          future: RoomDBProvider.db.getAllRoom(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.data != null) {
              updateRoomTypes(snapshot.data);
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Your Rooms",
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 120),
                  const Text(
                    "Explore",
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 24),
                  RoomTile(name: "Single", num: roomType["Single"]!),
                  RoomTile(name: "Double", num: roomType["Double"]!),
                  RoomTile(name: "Suite", num: roomType["Suite"]!),
                  RoomTile(name: "Luxury", num: roomType["Luxury"]!),
                  const SizedBox(height: 100),
                ],
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }

  updateRoomTypes(List<Room> data) {
    for (int i = 0; i < data.length; i++) {
      roomType[data[i].type] = roomType[data[i].type]! + 1;
    }
  }
}
