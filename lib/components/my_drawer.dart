import 'package:flutter/material.dart';
import 'package:music_player/pages/settings_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        children: [
          // logo
          const DrawerHeader(
            child: Center(
              child: Icon(
                Icons.music_note,
                size: 40,
              ),
            ),
          ),

          //home tile
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.0),
            child: ListTile(
              title: const Text(
                'H O M E',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              leading: const Icon(Icons.home),
              onTap: () => Navigator.pop(context),
            ),
          ),

          //setting tile

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: ListTile(
              title: const Text(
                'S E T T I N G S',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              leading: const Icon(Icons.settings),
              onTap: () {
                // pop drawer
                Navigator.pop(context);

                // navigate to settings page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SettingsPage(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
