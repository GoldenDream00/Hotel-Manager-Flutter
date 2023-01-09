// ignore_for_file: unnecessary_const

import 'package:flutter/material.dart';
import 'package:hotelapp/Services/userDB.dart';
import 'package:hotelapp/UI/User/Account/editProfile.dart';
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
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        vertical: 24, horizontal: 24),
                    decoration: BoxDecoration(
                        color: darkGreen1,
                        borderRadius: BorderRadius.circular(32)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "ABOUT ME",
                          style: TextStyle(
                            fontSize: 12,
                            letterSpacing: 2,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          snapshot.data.name,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: Colors.lightGreenAccent,
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Divider(color: Colors.white70),
                        detailWidget("Phone", snapshot.data.phone),
                        const Divider(color: Colors.white54),
                        detailWidget("Email", snapshot.data.email),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () => moveToEdit(context),
                        style: ElevatedButton.styleFrom(
                          shape: const StadiumBorder(),
                          backgroundColor: darkGreen1,
                          elevation: 0,
                        ),
                        child: buttonContent("Edit Profile", Icons.edit)),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () => logOut(context),
                        style: ElevatedButton.styleFrom(
                          shape: const StadiumBorder(),
                          backgroundColor: darkGreen1,
                          elevation: 0,
                        ),
                        child: buttonContent(
                            "Log Out", Icons.power_settings_new_outlined)),
                  ),
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

  detailWidget(String fieldName, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            "$fieldName: ",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  buttonContent(String value, IconData icon) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 20,
          ),
          const SizedBox(width: 16),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  moveToEdit(BuildContext context) {
    return Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => UserEdit(
            user: widget.user,
          ),
        )).then((value) => setState(() {}));
  }

  logOut(BuildContext context) {
    return Navigator.of(context)
        .pushNamedAndRemoveUntil('/', ModalRoute.withName('/'));
  }
}
