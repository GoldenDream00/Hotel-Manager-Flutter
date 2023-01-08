import 'package:flutter/material.dart';
import 'package:hotelapp/Utils/global.dart';
import '../../Services/roomDB.dart';
import 'Room/newDialog.dart';
import 'Room/roomTile.dart';

class Room extends StatefulWidget {
  const Room({super.key});

  @override
  State<Room> createState() => _RoomState();
}

class _RoomState extends State<Room> {
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: RoomDBProvider.db.getAllRoom(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.data != null) {
            return ListView(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              children: [
                const Text('Rooms', style: optionStyle),
                const SizedBox(height: 24),
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  reverse: true,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return RoomTile(
                      entry: snapshot.data?[index],
                      listUpdator: () => listUpdator(),
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: customFAB(context),
    );
  }

  customFAB(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => newTodoDialog(context),
      backgroundColor: Colors.lightGreen,
      child: const Icon(Icons.add),
    );
  }

  newTodoDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return NewRoomForm(
          listUpdator: () => listUpdator(),
        );
      },
    );
  }

  listUpdator() {
    setState(() {
      RoomDBProvider.db.getAllRoom();
    });
  }
}
