/*
* la idea seria reaporvechar el menu de flutter de problemas con los cuadrados
* grandes para poner las acciones de la puerta, y que el appbar
* camie de color en funcion del 'state' de la puerta
*
*
* el codigo de aqu es solo una prueba q no funciona aun
* */

import 'package:flutter/material.dart';
import 'package:tutorial_acs_2/tree.dart';
import 'package:tutorial_acs_2/requests.dart';
import 'package:tutorial_acs_2/root.dart';

class ScreenDoor extends StatefulWidget {
  final String id;
  const ScreenDoor({super.key, required this.id});

  @override
  State<ScreenDoor> createState() => _StateScreenDoor();
}

class _StateScreenDoor extends State<ScreenDoor> {
  late Future<Tree> futureTree;

  @override
  void initState() {
    super.initState();
    futureTree = getTree(widget.id);
  }
  Widget _buildRow(Door door, int index) { // session 8 buildRow
    return ListTile(

      title: Row(
        children: [
          Text('${door.from} ('),

          Text(')'),
        ],
      ),

      trailing: door.state == 'locked'
      // ternary operator
          ? TextButton(
          onPressed: () {
            unlockDoor(door); //if door locked
            futureTree = getTree(widget.id);
            setState(() {});
          },
          child: Text('Unlock'))
          : TextButton(
          onPressed: () {
            lockDoor(door); // if door unlocked
            futureTree = getTree(widget.id);
            setState(() {});
          },
          child: const Text('Lock')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Tree>(
      future: futureTree,
      builder: (context, snapshot) {
        // anonymous function
        if (snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Theme.of(context).colorScheme.onPrimary,
              title: Text(snapshot.data!.root.id),
              actions: <Widget>[
                IconButton(icon: const Icon(Icons.home), onPressed: () {
                  Navigator.of(context).pop(); // close drawer
                  Navigator.of(context).push(MaterialPageRoute<void>(
                    builder: (context) => ScreenBlank(),
                  ));

                }

                ),

              ],
            ),
            body: ListView.separated(
              // it's like ListView.builder() but better because it includes a separator between items
              padding: const EdgeInsets.all(16.0),
              itemCount: snapshot.data!.root.children.length,
              itemBuilder: (BuildContext context, int i) =>
                  _buildRow(snapshot.data!.root.children[i], i),
              separatorBuilder: (BuildContext context, int index) =>
              const Divider(),
            ),
          );

        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        // By default, show a progress indicator
        return Container(
            height: MediaQuery.of(context).size.height,
            color: Colors.white,
            child: Center(
              child: CircularProgressIndicator(),
            ));

      }, //builder
    );
  }

}