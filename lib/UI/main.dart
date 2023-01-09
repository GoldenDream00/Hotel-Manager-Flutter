import 'package:flutter/material.dart';
import 'package:hotelapp/UI/Admin/home.dart';
import 'package:hotelapp/UI/onboard.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/adminHome',
      routes: {
        '/': (context) => const OnBoard(),
        '/userHome': (context) => const OnBoard(),
        '/adminHome': (context) => const AdminHome(),
      },
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
        fontFamily: "GeneralSans",
      ),
    );
  }
}
