import 'package:flutter/material.dart';
import 'package:hotelapp/Services/userDB.dart';
import 'package:hotelapp/Utils/global.dart';
import '../../../Data/user.dart';
import '../../../Data/room.dart';
import '../../../Services/roomDB.dart';

class Account extends StatefulWidget {
  final User user;
  const Account({super.key, required this.user});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
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
          future: UserDBProvider.db.getUser(widget.user.id!),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.data != null) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    snapshot.data.name,
                    style: const TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 24),
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
}
