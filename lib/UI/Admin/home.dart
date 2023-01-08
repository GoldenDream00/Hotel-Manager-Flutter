import 'package:flutter/material.dart';
import 'package:hotelapp/UI/Admin/room.dart';
import '../../Services/roomDB.dart';
import '../../Utils/global.dart';
import 'Room/newDialog.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 72,
        backgroundColor: darkGreen2,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.power_settings_new, color: Colors.white),
            onPressed: () => Navigator.of(context)
                .pushNamedAndRemoveUntil('/', ModalRoute.withName('/')),
          ),
        ],
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
            label: 'Rooms',
            backgroundColor: darkGreen1,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.food_bank_outlined),
            label: 'Food Menu',
            backgroundColor: darkGreen1,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.people_outlined),
            label: 'Employees',
            backgroundColor: darkGreen1,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.room_service_outlined),
            label: 'Orders',
            backgroundColor: darkGreen1,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white54,
        onTap: _onItemTapped,
      ),
    );
  }

  // ignore: prefer_final_fields
  late List<Widget> _widgetOptions = <Widget>[
    Room(),
    const Text('Index 1: Business', style: optionStyle),
    const Text('Index 2: School', style: optionStyle),
    const Text('Index 3: Settings', style: optionStyle),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
