import 'package:flutter/material.dart';

class CustomCharacterAppBar extends StatelessWidget {
  const CustomCharacterAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          // Navigate back to the /characters page
          Navigator.pop(context);
          // Navigator.pushNamed(context, '/characters');
        },
      ),
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text('AmbatuApp', style: TextStyle(color: Colors.white)),
      ),
      pinned: true,
    );
  }
}
