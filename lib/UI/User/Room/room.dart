import 'package:flutter/material.dart';
import 'package:hotelapp/Utils/global.dart';
import '../../../Data/user.dart';
import '../../../Data/room.dart';
import '../../../Services/roomDB.dart';
import 'bookedTile.dart';
import 'roomTile.dart';

class RoomPage extends StatefulWidget {
  final User user;
  const RoomPage({super.key, required this.user});

  @override
  State<RoomPage> createState() => _RoomPageState();
}

class _RoomPageState extends State<RoomPage> {
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
        child: Column(
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
            const SizedBox(height: 16),
            FutureBuilder(
              future: RoomDBProvider.db.searchRoom(widget.user.id!),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.data != null) {
                  if (snapshot.data.length != 0) {
                    return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return BookedTile(
                          entry: snapshot.data[index],
                          deleteRoomDialog: deleteRoomDialog,
                        );
                      },
                    );
                  } else {
                    return Center(
                      child: Column(
                        children: const [
                          SizedBox(height: 16),
                          Icon(
                            Icons.upcoming_outlined,
                            size: 72,
                            color: Colors.white30,
                          ),
                          SizedBox(height: 8),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 40.0),
                            child: Text(
                              "No booked rooms! Explore AGDA's hotel rooms below.",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white30,
                                height: 1.5,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          SizedBox(height: 8),
                        ],
                      ),
                    );
                  }
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
            const SizedBox(height: 32),
            const Text(
              "Explore",
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 24),
            FutureBuilder(
              future: RoomDBProvider.db.getAllRoom(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.data != null) {
                  updateRoomTypes(snapshot.data);
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RoomTile(
                        name: "Single",
                        num: roomVacancy["Single"]!,
                        description: roomDesc["Single"]!,
                        user: widget.user,
                      ),
                      RoomTile(
                        name: "Double",
                        num: roomVacancy["Double"]!,
                        description: roomDesc["Double"]!,
                        user: widget.user,
                      ),
                      RoomTile(
                        name: "Suite",
                        num: roomVacancy["Suite"]!,
                        description: roomDesc["Suite"]!,
                        user: widget.user,
                      ),
                      RoomTile(
                        name: "Luxury",
                        num: roomVacancy["Luxury"]!,
                        description: roomDesc["Luxury"]!,
                        user: widget.user,
                      ),
                      const SizedBox(height: 100),
                    ],
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            )
          ],
        ),
      ),
    );
  }

  deleteRoomDialog(BuildContext context, Room entry) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: darkGreen1,
          title: const Text(
            "Cancel Room",
            style: TextStyle(color: Colors.white),
          ),
          content: const Text(
            "Are you sure you want to evacuate this room?",
            style: TextStyle(color: Colors.white),
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
          actions: <Widget>[
            TextButton(
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text('Continue'),
              ),
              onPressed: () {
                entry.cid = -1;
                entry.occupied = 0;
                RoomDBProvider.db.updateRoom(entry);
                Navigator.pop(context);
              },
            ),
          ],
        );
        // return UpdateRoomForm(entry: entry);
      },
    ).then((value) => setState(() {}));
  }

  updateRoomTypes(List<Room> data) {
    roomVacancy["Single"] = 0;
    roomVacancy["Double"] = 0;
    roomVacancy["Suite"] = 0;
    roomVacancy["Luxury"] = 0;
    for (int i = 0; i < data.length; i++) {
      if (data[i].occupied == 0) {
        roomVacancy[data[i].type] = roomVacancy[data[i].type]! + 1;
      }
    }
  }

  Map<String, int> roomVacancy = {
    "Single": 0,
    "Double": 0,
    "Suite": 0,
    "Luxury": 0,
  };

  Map<String, String> roomDesc = {
    "Single":
        "For those lone adventurors of the world! Whether it's to take a break from work, to doing work until your break ends, AGDA provides cheap and comforting Single Bed Room options that don't dissapoint you.",
    "Double":
        "Room with double beds for people with double the hearts. AGDA's premium double bedrooms are sure to satisfy you and your dear ones, with friendlier seating rooms and two large beds.",
    "Suite":
        "Wanna plan a party? Or perhaps have a conference? Our Suite Rooms are perfect for all those. Experience togetherness and happiness with AGDA and we rest assure you our greatest service.",
    "Luxury":
        "Not every day must be as special as your Vacation days with your family or friends. But your every vacation will be guarenteed to be special with AGDA's luxurious suite of Luxury Rooms.",
  };
}
