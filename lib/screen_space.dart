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


 IconData iconClose(Door door2){
   if (door2.closed) {
     return Icons.door_back_door;
   }
   else{
     return Icons.door_back_door_outlined;
   }

 }
  Color colorClose(Door door){

    if(door.state == 'locked'){
      return Colors.grey;
    }
    else{
        return Colors.black;
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

  IconData iconFav(Door door) { //TODO implement this
    //check if the door is in favorite list,
    // if true,  return Icons.favorite
    //else return Icons.favorite_border;

    return Icons.favorite_border;
  }

  Widget _buildRow(Door door, int index) {
    return ListTile(
      leading: IconButton(
        icon: Icon(iconFav(door), color: Colors.deepPurple,), //todo: the door must have a favourite bool, and change the icon if the bool is true or not
            onPressed: () {
          //todo implement somewhere a new class favourites that includes a list of doors
          //todo: when pressed, we have to include o exclude the door from the list of favourites doors
            },

      ),
      title: Row(
        children: [
          Text('${door.from}'),
        ],
      ),
      onTap: () => _navigateDownDoor(door.id),

      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(iconClose(door),
            color: colorClose(door),), // the icon changes if the door is open or closed
            onPressed: () { // if the icon represents a locked door if pressed, the icon changes and the request will be send it.
              _handleOpenCloseOp(door);
            },
          ),
          const SizedBox(width: 16),
          IconButton(
            icon: Icon(
              iconDoorState(door),
              color: colorDoorState(door),
            ),
            onPressed: () {
              _handleLockUnclockOp(door);
            },
          ),
        ],
      ),
    );
  }

  void _handleLockUnclockOp(Door door) {

    if (door.state == 'locked') {
       unlockDoor(door);
    } else {
     lockDoor(door);
    }
    //only when the operation lock/unlock is finished, we refresh the screen 3 milliseconds after

    // trying to solve some inconsistencies, we found that if we delay the refresh,
    // the app dont gets stuck on the previous state
    Future.delayed(const Duration(milliseconds: 3), () {
        _refresh();
    });

  }

  void _handleOpenCloseOp(Door door) {

    if (door.closed) {
      openDoor(door);
    } else {
      closeDoor(door);
    }
    //only when the operation open/close is finished, we refresh the screen 3 milliseconds after

    // trying to solve some inconsistencies, we found that if we delay the refresh,
    // the app dont gets stuck on the previous state
    Future.delayed(const Duration(milliseconds: 3), () {
        _refresh();
    });

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
                    builder: (context) => const ScreenBlank(),
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
            child: const Center(
              child: CircularProgressIndicator(),
            ));
      },
    );
  }


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
