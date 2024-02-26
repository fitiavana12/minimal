import 'package:flutter/material.dart';
import 'package:minimal_music_player/pages/settings_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer ({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        children: [
          //logo
          DrawerHeader(
              child: Center(
                child: Icon(
                    Icons.music_note,
                    size: 40,
                    color: Theme.of(context).colorScheme.inversePrimary,
                ),
              )
          ),

          // home title
        Padding(
            padding: const EdgeInsets.only(left: 25.0, top: 25),
            child: ListTile(
              title: Text("Home"),
              leading: Icon(Icons.home),
              onTap: () => Navigator.pop(context),
            ),
        ),

          Padding(
            padding: const EdgeInsets.only(left: 25.0, top: 25),
            child: ListTile(
              title: Text("Settings"),
              leading: Icon(Icons.settings),
              onTap: () {
                // pop drawer
                Navigator.pop(context);

                // navigate to settings page
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SettingsPage()
                    ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

}