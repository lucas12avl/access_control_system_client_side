import 'package:flutter/material.dart';
import 'hamburguer_menu.dart';

class ScreenBlank extends StatefulWidget {
  const ScreenBlank({super.key});

  @override
  State<ScreenBlank> createState() => _ScreenBlankState();

}

class _ScreenBlankState extends State<ScreenBlank> {

  @override

  Widget build(BuildContext context) {

    return Scaffold(
      drawer: TheDrawer(context).drawer,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        title: const Row(
          children: [
            Text("Favourites"),
            SizedBox(width: 18),
            Icon(Icons.favorite, color: Colors.white),
          ],
        ),
      ),

      //todo: implement the same structure with the screen_space.dart, a build that implemnts a build_row and makes the door from the list of favourites doors
    );
  }
}
