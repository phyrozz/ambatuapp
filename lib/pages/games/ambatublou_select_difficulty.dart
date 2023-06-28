import 'package:ambatuapp/pages/games/ambatublou.dart';
import 'package:ambatuapp/widgets/sidebar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AmbatublouSelectDifficulty extends StatefulWidget {
  const AmbatublouSelectDifficulty({
    super.key,
  });

  @override
  State<AmbatublouSelectDifficulty> createState() =>
      _AmbatublouSelectDifficultyState();
}

class _AmbatublouSelectDifficultyState
    extends State<AmbatublouSelectDifficulty> {
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
            Column(
              children: <Widget>[
                const Text(
                  'Select Difficulty',
                  style: TextStyle(fontSize: 30.0),
                ),
                const SizedBox(
                  height: 30,
                ),
                ButtonBar(
                  alignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: const ButtonStyle(
                        padding: MaterialStatePropertyAll(
                            EdgeInsets.fromLTRB(30, 15, 30, 15)),
                      ),
                      onPressed: () => Navigator.pushReplacement(
                          (context),
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const AmbatublouGame(
                                    rows: 8,
                                    cols: 8,
                                    totalMines: 10,
                                  ))),
                      child: const Text('Easy'),
                    ),
                    ElevatedButton(
                      style: const ButtonStyle(
                        padding: MaterialStatePropertyAll(
                            EdgeInsets.fromLTRB(30, 15, 30, 15)),
                      ),
                      onPressed: () => Navigator.pushReplacement(
                          (context),
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const AmbatublouGame(
                                    rows: 10,
                                    cols: 10,
                                    totalMines: 20,
                                  ))),
                      child: const Text('Medium'),
                    ),
                    ElevatedButton(
                      style: const ButtonStyle(
                        padding: MaterialStatePropertyAll(
                            EdgeInsets.fromLTRB(30, 15, 30, 15)),
                      ),
                      onPressed: () => Navigator.pushReplacement(
                          (context),
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const AmbatublouGame(
                                    rows: 12,
                                    cols: 12,
                                    totalMines: 30,
                                  ))),
                      child: const Text('Hard'),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
