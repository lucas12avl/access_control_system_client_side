import 'package:flutter/material.dart';
import 'package:tutorial_acs_2/requests.dart';
import 'package:tutorial_acs_2/screen_partition.dart';
import 'screen_favourites.dart';


class TheDrawer {
  late Drawer drawer; //late porque tendremos un drawer que al ponerse, luego no se podra cambiar

  TheDrawer(BuildContext context) {
    drawer = Drawer(
      // we want the "hamburger" button that unfolds the navigation drawer only
      // if we are at the root, if not we want the up button, like in page of space
      // how to make a drawer https://flutter.dev/docs/cookbook/design/drawer
      child: ListView( // el ListView es la lista de cosas que tendremos en el menu de hamburguesa
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            child: Text('ACS'),
          ),
          ListTile(
            leading: const Icon(Icons.holiday_village),
            // https://material.io/resources/icons
            title: const Text('Places'),
            onTap: () async {
              Navigator.of(context).pop(); // close drawer
              String rootId = await getRoot();
              Navigator.of(context).push(MaterialPageRoute<void>( //"building"
                builder: (context) => ScreenPartition(id: rootId),
              ));

            },
          ),
          ListTile(
            leading: const Icon(Icons.favorite),
            title: const Text('Favorites'),
            onTap: () async {
              Navigator.of(context).pop(); // close drawer
              Navigator.of(context).push(MaterialPageRoute<void>( //"building"
                 builder: (context) => ScreenBlank(),
          ));

          },
          ),
        ],
      ),
    );
  }
}