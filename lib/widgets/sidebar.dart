import 'package:ambatuapp/main.dart';
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
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                ListTile(
                  title: const Text(
                    'Home',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    Navigator.pop(context); // Close the drawer
                    Navigator.pushNamed(
                        context, '/'); // Navigate to the stats page
                  },
                ),
                ListTile(
                  title: const Text(
                    'Characters',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    Navigator.pop(context); // Close the drawer
                    Navigator.pushNamed(
                        context, '/characters'); // Navigate to the stats page
                  },
                ),
                ListTile(
                  title: const Text(
                    'Soundboard',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    Navigator.pop(context); // Close the drawer
                    Navigator.pushNamed(
                        context, '/soundboard'); // Navigate to the stats page
                  },
                ),
                ListTile(
                  title: const Text(
                    'Stats',
                    style: TextStyle(fontWeight: FontWeight.bold),
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
                padding: EdgeInsets.all(10),
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
