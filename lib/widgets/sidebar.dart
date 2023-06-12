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
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                ListTile(
                  title: const Text('Home'),
                  onTap: () {
                    Navigator.pop(context); // Close the drawer
                    Navigator.pushNamed(
                        context, '/'); // Navigate to the stats page
                  },
                ),
                ListTile(
                  title: const Text('Characters'),
                  onTap: () {
                    Navigator.pop(context); // Close the drawer
                    Navigator.pushNamed(
                        context, '/characters'); // Navigate to the stats page
                  },
                ),
                ListTile(
                  title: const Text('Soundboard'),
                  onTap: () {
                    Navigator.pop(context); // Close the drawer
                    Navigator.pushNamed(
                        context, '/soundboard'); // Navigate to the stats page
                  },
                ),
                ListTile(
                  title: const Text('Stats'),
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
              return ListTile(
                leading: const Icon(Icons.brightness_6),
                title: const Text('Dark Mode'),
                trailing: Switch(
                  value: themeModel.isDarkMode,
                  onChanged: (value) => themeModel.toggleDarkMode(),
                ),
              );
            },
          ),
          const SizedBox(
            height: 15.0,
          ),
        ],
      ),
    );
  }
}
