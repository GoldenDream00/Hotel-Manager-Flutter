import 'package:flutter/material.dart';
import '../../Utils/global.dart';
import 'Account/account.dart';
import 'Dish/dish.dart';
import 'Room/room.dart';

class UserHome extends StatefulWidget {
  const UserHome({super.key});

  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  var _selectedIndex = 0, args;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white);

  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context)!.settings.arguments as UserArguments;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40,
        backgroundColor: darkGreen2,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: darkGreen2,
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(Icons.bed_outlined),
            label: 'Bookings',
            backgroundColor: darkGreen1,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.food_bank_outlined),
            label: 'Food Menu',
            backgroundColor: darkGreen1,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.account_circle_outlined),
            label: 'Account',
            backgroundColor: darkGreen1,
          ),
        ],
        currentIndex: _selectedIndex,
        backgroundColor: darkGreen1,
        selectedItemColor: Colors.lightGreen,
        unselectedItemColor: Colors.white54,
        onTap: _onItemTapped,
      ),
    );
  }

  // ignore: prefer_final_fields
  late List<Widget> _widgetOptions = <Widget>[
    RoomPage(user: args.entry),
    const Dish(),
    Account(user: args.entry),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
