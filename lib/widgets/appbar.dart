import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          'AmbatuApp',
          style: GoogleFonts.lato(
              color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
      ),
      pinned: true,
    );
  }
}
