import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          'AmbatuApp',
          style: TextStyle(color: Colors.white),
        ),
      ),
      pinned: true,
    );
  }
}
