import 'dart:async';
import 'dart:math';
import 'package:ambatuapp/widgets/sidebar.dart';
import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:google_fonts/google_fonts.dart';

class AmbatugamePage extends StatefulWidget {
  const AmbatugamePage({Key? key}) : super(key: key);

  @override
  State<AmbatugamePage> createState() => _AmbatugamePageState();
}

class _AmbatugamePageState extends State<AmbatugamePage> {
  int totalScore = 0;
  int comboCount = 0;
  int tapCount = 0;
  late DateTime lastTapTime;
  AssetsAudioPlayer assetsAudioPlayer = AssetsAudioPlayer();
  bool showCombo = false;
  Timer? comboTimer;

  @override
  void initState() {
    super.initState();
    lastTapTime = DateTime.now();
  }

  final List<String> audioFiles = [
    'assets/sounds/ambatublou.mp3',
    'assets/sounds/omaygot.mp3',
    'assets/sounds/ambatufakingnut.mp3',
    'assets/sounds/bus.mp3',
    'assets/sounds/ambatukaaaaaam.mp3',
    'assets/sounds/i_want_it.mp3',
    'assets/sounds/ambasing.mp3',
  ];
  final List<AssetsAudioPlayer> activePlayers = [];

  Future<void> playTapSound() async {
    if (activePlayers.length >= 10) {
      return; // Limit reached, do not create more audio players
    }

    final random = Random();
    final audioIndex = random.nextInt(audioFiles.length);
    final audioFilePath = audioFiles[audioIndex];

    final player = AssetsAudioPlayer.newPlayer();
    await player.open(Audio(audioFilePath));

    activePlayers.add(player);
    if (activePlayers.length == 10) {
      activePlayers[0].stop();
      activePlayers.removeAt(0);
    }
    print(activePlayers);
  }

  void updateScore() {
    if (mounted) {
      setState(() {
        totalScore += comboCount + 1;
        comboCount++;
        showCombo = true;
        resetComboTimer();
      });
    }
  }

  void resetCombo() {
    if (mounted) {
      setState(() {
        comboCount = 0;
        showCombo = false;
      });
    }
  }

  void resetComboTimer() {
    comboTimer?.cancel();
    comboTimer = Timer(const Duration(seconds: 1), resetCombo);
  }

  void handleButtonTap() {
    DateTime now = DateTime.now();
    Duration timeDifference = now.difference(lastTapTime);

    if (timeDifference.inMilliseconds <= 500) {
      updateScore();
    } else {
      resetCombo();
    }

    tapCount++;
    playTapSound();
    lastTapTime = now;
  }

  @override
  void dispose() {
    super.dispose();
    for (final f in activePlayers) {
      f.dispose();
    }
    assetsAudioPlayer.stop();
    comboTimer?.cancel();
  }

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
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  text: TextSpan(
                    text: 'Score: ',
                    style: GoogleFonts.lato(
                        fontSize: 24.0,
                        color: Theme.of(context).primaryColorLight),
                    children: [
                      TextSpan(
                        text: '$totalScore',
                        style: GoogleFonts.lato(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    text: 'Taps: ',
                    style: GoogleFonts.lato(
                        fontSize: 24.0,
                        color: Theme.of(context).primaryColorLight),
                    children: [
                      TextSpan(
                        text: '$tapCount',
                        style: GoogleFonts.lato(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(),
              Container(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                width: 200,
                height: 200,
                child: LayoutBuilder(builder: (context, constraints) {
                  if (comboCount >= 0 && comboCount < 15) {
                    return Image.asset('assets/dreamy_default.jpg');
                  } else if (comboCount >= 15 && comboCount <= 35) {
                    return Image.asset('assets/dreamy_smiling.jpg');
                  } else if (comboCount > 35 && comboCount <= 70) {
                    return Image.asset('assets/dreamy.jpg');
                  } else {
                    return Image.asset('assets/dreamy_face.jpg');
                  }
                }),
              ),
              Stack(
                clipBehavior: Clip.none,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                        const EdgeInsets.fromLTRB(60, 35, 60, 35),
                      ),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24.0),
                        ),
                      ),
                      shadowColor: null,
                    ),
                    onPressed: handleButtonTap,
                    child: const Text(
                      'Tap to 🚌!',
                      style: TextStyle(fontSize: 24.0),
                    ),
                  ),
                  if (comboCount != 0)
                    Positioned(
                      top: -25,
                      right: -25,
                      child: AnimatedOpacity(
                        duration: const Duration(milliseconds: 500),
                        opacity: showCombo ? 1.0 : 0.0,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                          padding: const EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Text(
                            '+$comboCount',
                            style: const TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(),
            ],
          ),
        ],
      ),
      drawer: const Sidebar(currentPage: 'AmbatuTap'),
    );
  }
}
