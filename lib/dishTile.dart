import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'Data/dish.dart';
import 'Utils/global.dart';

typedef updateCallback = void Function(BuildContext context, Dish entry);

class DishTile extends StatefulWidget {
  final Dish entry;
  DishTile({super.key, required this.entry});

  @override
  DishTileState createState() => DishTileState();
}

class DishTileState extends State<DishTile> {
  double diameter = 28;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        color: darkGreen1,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Container(
                width: 64,
                height: 64,
                child: ClipOval(
                  child: Image.file(
                    File(
                      widget.entry.photo,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.entry.name,
                    style: textDecoration,
                  ),
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: const Size(50, 30),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        alignment: Alignment.centerLeft),
                    child: const Text("View Model"),
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  var textDecoration = const TextStyle(
    fontSize: 18,
    color: Colors.white,
    fontWeight: FontWeight.w600,
  );

  var subTextDecoration = const TextStyle(
    fontSize: 14,
    color: Colors.white70,
    fontWeight: FontWeight.w400,
  );
}
