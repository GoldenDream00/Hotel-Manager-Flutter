import 'package:flutter/material.dart';
import 'package:hotelapp/Data/room.dart' as data;
import 'package:hotelapp/Utils/global.dart';
import '../../../Services/roomDB.dart';
import 'newDialog.dart';
import 'roomTile.dart';
import 'updateDialog.dart';

class Room extends StatefulWidget {
  const Room({super.key});

  @override
  State<Room> createState() => _RoomState();
}

class _RoomState extends State<Room> {
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
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Rooms',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      )),
                  const SizedBox(height: 24),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return RoomTile(
                        entry: snapshot.data[index],
                        updateRoomDialog: updateRoomDialog,
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
        return NewRoomForm();
      },
    ).then((value) => setState(() {}));
  }

  updateRoomDialog(BuildContext context, data.Room entry) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return UpdateRoomForm(entry: entry);
      },
    ).then((value) => setState(() {}));
  }
}
