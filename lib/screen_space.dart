import 'package:flutter/material.dart';
import 'package:tutorial_acs_2/tree.dart';
import 'package:tutorial_acs_2/requests.dart';
import 'package:tutorial_acs_2/root.dart';
import 'package:tutorial_acs_2/screen_door.dart';

class ScreenSpace extends StatefulWidget {
  final String id;
  const ScreenSpace({super.key, required this.id});

  @override
  State<ScreenSpace> createState() => _StateScreenSpace();
}

class _StateScreenSpace extends State<ScreenSpace> {
  late Future<Tree> futureTree;

  @override
  void initState() {
    super.initState();
    futureTree = getTree(widget.id);
  }

  /* // tutorial buildRow
  Widget _buildRow(Door door, int index) {
    return ListTile(
      title: Text('D ${door.id}'),
      trailing: Text('${door.state}, closed=${door.closed}'),
    );
  }
*/

 IconData iconClose(Door door2){
   if (door2.closed) {
     return Icons.door_back_door;
   }
   else{
     return Icons.door_back_door_outlined;
   }

 }

  IconData iconDoorState(Door door) {
    switch (door.state) {
      case 'locked':
        return Icons.lock_rounded;
      case 'unlocked':
        return Icons.lock_open;

      case 'unlocked_shortly':
        return Icons.punch_clock_outlined;

      default:
        return Icons.error_outline;
    }
  }


  Color colorDoorState(Door door){

    switch (door.state) {
      case 'locked':
        return Colors.deepOrangeAccent;
      case 'unlocked':
        return Colors.green;

      case 'unlocked_shortly':
        return Colors.lightGreen;

      default:
        return Colors.red;
    }
  }

  Widget _buildRow(Door door, int index) { // session 8 buildRow
    return ListTile(
      leading:  Icon(iconClose(door)),
      title: Row(
        children: [
          Text('${door.from} ('),
          Icon(iconDoorState(door), color:  colorDoorState(door),),
          Text(')'),
        ],
      ),
      onTap: () => _navigateDownDoor(door.id),

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


  // future with listview
// https://medium.com/nonstopio/flutter-future-builder-with-list-view-builder-d7212314e8c9
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
                  // TODO go home page = root
                ),
                //TODO other actions
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
      },
    );
  }

  //funciones que habra que usar para ir a la pantalla de la info de la puerta
  void _navigateDownDoor(String childId) {
    Navigator.of(context)
        .push(MaterialPageRoute<void>(
      builder: (context) => ScreenDoor(id: childId),
    ))
        .then((var value) {
      _refresh();
    });
  }

  void _refresh() async {
    futureTree = getTree(widget.id);
    setState(() {});
  }

}
