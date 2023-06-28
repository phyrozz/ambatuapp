import 'package:ambatuapp/widgets/sidebar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StartGamePage extends StatelessWidget {
  final String title;
  final String description;
  final StatefulWidget navigateTo;

  const StartGamePage(
      {super.key,
      required this.title,
      required this.description,
      required this.navigateTo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'AmbatuApp',
          style: GoogleFonts.lato(
            color: Colors.white,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 30.0),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(description),
            const SizedBox(
              height: 50,
            ),
            ElevatedButton(
              style: const ButtonStyle(
                padding: MaterialStatePropertyAll(
                    EdgeInsets.fromLTRB(30, 15, 30, 15)),
              ),
              child: const Text('Start Game'),
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => navigateTo));
              },
            ),
          ],
        ),
      ),
    );
  }
}
