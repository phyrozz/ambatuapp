import 'package:ambatuapp/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

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
                  title: Row(
                    children: const [
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
                    Navigator.pushNamed(
                        context, '/'); // Navigate to the stats page
                  },
                ),
                ListTile(
                  contentPadding: const EdgeInsets.fromLTRB(10, 3, 0, 3),
                  title: Row(
                    children: const [
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
                    Navigator.pushNamed(
                        context, '/ambatuwatch'); // Navigate to the stats page
                  },
                ),
                ListTile(
                  contentPadding: const EdgeInsets.fromLTRB(10, 3, 0, 3),
                  title: Row(
                    children: const [
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
                    Navigator.pushNamed(
                        context, '/characters'); // Navigate to the stats page
                  },
                ),
                ListTile(
                  contentPadding: const EdgeInsets.fromLTRB(10, 3, 0, 3),
                  title: Row(
                    children: const [
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
                    Navigator.pushNamed(
                        context, '/soundboard'); // Navigate to the stats page
                  },
                ),
                ListTile(
                  contentPadding: const EdgeInsets.fromLTRB(10, 3, 0, 3),
                  title: Row(
                    children: const [
                      Icon(FeatherIcons.twitter),
                      SizedBox(
                        width: 8.0,
                      ),
                      Text(
                        'MyDreamy',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.pop(context); // Close the drawer
                    Navigator.pushNamed(
                        context, '/stats'); // Navigate to the stats page
                  },
                ),
                // Add more ListTiles for other pages in your app
              ],
            ),
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
