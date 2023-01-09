import 'package:flutter/material.dart';
import 'package:hotelapp/Utils/global.dart';
import '../../../Services/dishDB.dart';
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
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: FutureBuilder(
          future: DishDBProvider.db.getAllDish(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.data != null) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Food Menu',
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
    );
  }
}
