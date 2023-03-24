import 'package:flutter/material.dart';
import 'Utils/global.dart';
import 'package:hotelapp/newDialog.dart';
import 'Services/dishDB.dart';
import 'dishTile.dart';

class Dish extends StatefulWidget {
  const Dish({super.key});

  @override
  State<Dish> createState() => _DishState();
}

class _DishState extends State<Dish> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkGreen2,
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 0,
        backgroundColor: darkGreen2,
      ),
      body: RefreshIndicator(
        onRefresh: refresher,
        child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: FutureBuilder(
          future: DishDBProvider.db.getAllDish(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.data != null) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),
                  const Text('2D to 3D \nConvertor',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w700,
                        height: 1.25,
                        color: Colors.white,
                      )),
                  const SizedBox(height: 24),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return DishTile(
                        entry: snapshot.data[index],
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
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: customFAB(context),
      bottomNavigationBar: const BottomAppBar(
        color: Color.fromARGB(255, 41, 47, 39),
        height: 64,
        shape: CircularNotchedRectangle(),
        notchMargin: 12,
        elevation: 12,
      ),
    );
  }

  Future refresher() async {
    setState(() {
      DishDBProvider.db.getAllDish();
    });
    return Future<void>.delayed(const Duration(seconds: 1));
  }

  customFAB(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => NewDishForm())),
      child: const Icon(
        Icons.add,
        size: 32,
      ),
    );
  }
}
