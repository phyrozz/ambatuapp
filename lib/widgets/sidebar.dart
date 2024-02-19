import 'package:ambatuapp/main.dart';
import 'package:ambatuapp/pages/ambatugames.dart';
import 'package:ambatuapp/pages/ambatuwatch.dart';
import 'package:ambatuapp/pages/characters.dart';
import 'package:ambatuapp/pages/home.dart';
import 'package:ambatuapp/pages/soundboard.dart';
import 'package:ambatuapp/supabase.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Sidebar extends StatelessWidget {
  final String currentPage;

  const Sidebar({super.key, required this.currentPage});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: Theme.of(context).appBarTheme.backgroundColor,
                  ),
                  child: Text(
                    currentPage,
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                ListTile(
                  contentPadding: const EdgeInsets.fromLTRB(10, 3, 0, 3),
                  title: const Row(
                    children: [
                      Icon(Icons.home_outlined),
                      SizedBox(
                        width: 8.0,
                      ),
                      Text(
                        'Home',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.pop(context); // Close the drawer
                    Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) => const HomePage(),
                      ),
                    );
                  },
                ),
                ListTile(
                  contentPadding: const EdgeInsets.fromLTRB(10, 3, 0, 3),
                  title: const Row(
                    children: [
                      Icon(Icons.tv_rounded),
                      SizedBox(
                        width: 8.0,
                      ),
                      Text(
                        'AmbatuWatch',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.pop(context); // Close the drawer
                    Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) =>
                            const AmbatuWatchPage(),
                      ),
                    );
                  },
                ),
                ListTile(
                  contentPadding: const EdgeInsets.fromLTRB(10, 3, 0, 3),
                  title: const Row(
                    children: [
                      Icon(Icons.person_outline),
                      SizedBox(
                        width: 8.0,
                      ),
                      Text(
                        'Characters',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.pop(context); // Close the drawer
                    Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) =>
                            const CharacterListPage(),
                      ),
                    );
                  },
                ),
                ListTile(
                  contentPadding: const EdgeInsets.fromLTRB(10, 3, 0, 3),
                  title: const Row(
                    children: [
                      Icon(Icons.audiotrack_outlined),
                      SizedBox(
                        width: 8.0,
                      ),
                      Text(
                        'Soundboard',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.pop(context); // Close the drawer
                    Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) =>
                            const SoundboardPage(),
                      ),
                    );
                  },
                ),
                ListTile(
                  contentPadding: const EdgeInsets.fromLTRB(10, 3, 0, 3),
                  title: const Row(
                    children: [
                      Icon(Icons.gamepad_outlined),
                      SizedBox(
                        width: 8.0,
                      ),
                      Text(
                        'AmbatuGames',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.pop(context); // Close the drawer
                    Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) =>
                            const AmbatuGamesPage(),
                      ),
                    );
                  },
                ),
                // ListTile(
                //   contentPadding: const EdgeInsets.fromLTRB(10, 3, 0, 3),
                //   title: Row(
                //     children: const [
                //       Icon(FeatherIcons.twitter),
                //       SizedBox(
                //         width: 8.0,
                //       ),
                //       Text(
                //         'MyDreamy',
                //         style: TextStyle(fontWeight: FontWeight.bold),
                //       ),
                //     ],
                //   ),
                //   onTap: () {
                //     Navigator.pop(context); // Close the drawer
                //     Navigator.pushNamed(
                //         context, '/stats'); // Navigate to the stats page
                //   },
                // ),
                // Add more ListTiles for other pages in your app
              ],
            ),
          ),
          ListTile(
            contentPadding: const EdgeInsets.fromLTRB(10, 3, 0, 3),
            title: const Row(
              children: [
                Icon(Icons.logout_rounded),
                SizedBox(
                  width: 8.0,
                ),
                Text(
                  'Log out',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            onTap: () {
              Navigator.pop(context);
              SupabaseAuth().signOut();
            },
          ),
          Consumer<ThemeModel>(
            builder: (context, themeModel, _) {
              return Container(
                padding: const EdgeInsets.all(10),
                color: Theme.of(context).appBarTheme.backgroundColor,
                child: ListTile(
                  leading: const Icon(
                    Icons.brightness_6,
                    color: Colors.white,
                  ),
                  title: const Text(
                    'Dark Mode',
                    style: TextStyle(color: Colors.white),
                  ),
                  trailing: Switch(
                    value: themeModel.isDarkMode,
                    onChanged: (value) => themeModel.toggleDarkMode(),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
