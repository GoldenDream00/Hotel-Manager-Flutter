import 'package:flutter/material.dart';
import 'package:hotelapp/UI/Admin/home.dart';
import 'package:hotelapp/UI/User/home.dart';
import 'package:hotelapp/UI/onboard.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const OnBoard(),
        '/adminHome': (context) => const AdminHome(),
        '/userHome': (context) => const UserHome(),
      },
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
        fontFamily: "GeneralSans",
      ),
    );
  }
}
