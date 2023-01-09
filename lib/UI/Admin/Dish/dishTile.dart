import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hotelapp/Data/dish.dart';
import 'package:hotelapp/Utils/global.dart';

typedef updateCallback = void Function(BuildContext context, Dish entry);

class DishTile extends StatefulWidget {
  final Dish entry;
  final updateCallback updateDishDialog;
  DishTile({super.key, required this.entry, required this.updateDishDialog});

  @override
  DishTileState createState() => DishTileState();
}

class DishTileState extends State<DishTile> {
  double diameter = 28;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: darkGreen1,
        borderRadius: BorderRadius.circular(32),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              dishPhoto(),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.entry.name,
                    style: textDecoration,
                  ),
                  Text(
                    "${widget.entry.type}  |  Stock: ${widget.entry.num.toString()}",
                    style: subTextDecoration,
                  ),
                ],
              ),
            ],
          ),
          IconButton(
              padding: EdgeInsets.zero,
              onPressed: () => widget.updateDishDialog(context, widget.entry),
              icon: const Icon(
                Icons.edit_outlined,
                color: Colors.lightGreen,
                size: 20,
              ))
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

  dishPhoto() {
    return CachedNetworkImage(
      imageUrl: widget.entry.photo,
      imageBuilder: (context, imageProvider) => Container(
        width: 64,
        height: 64,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
        ),
      ),
      placeholder: (context, url) => const CircularProgressIndicator(),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}
