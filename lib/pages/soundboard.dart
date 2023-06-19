import 'package:ambatuapp/widgets/appbar.dart';
import 'package:ambatuapp/widgets/fixed_header.dart';
import 'package:ambatuapp/widgets/sidebar.dart';
import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

class SoundboardPage extends StatefulWidget {
  const SoundboardPage({super.key});

  @override
  State<SoundboardPage> createState() => _SoundboardPageState();
}

class SoundItem {
  final String name;
  final String soundUrl;

  SoundItem({required this.name, required this.soundUrl});
}

class _SoundboardPageState extends State<SoundboardPage> {
  AssetsAudioPlayer audioPlayer = AssetsAudioPlayer.newPlayer();
  List<bool> isPlayingList = List.filled(26, false);
  int? currentIndex;
  List<SoundItem> soundItems = [
    SoundItem(name: 'Ambatukam', soundUrl: 'assets/sounds/ambatukam.mp3'),
    SoundItem(
        name: 'Ambatukaaaaam', soundUrl: 'assets/sounds/ambatukaaaaaam.mp3'),
    SoundItem(name: 'Ambasing', soundUrl: 'assets/sounds/ambasing.mp3'),
    SoundItem(
        name: 'Ambasing (full version)',
        soundUrl: 'assets/sounds/ambasing_full.mp3'),
    SoundItem(
        name: 'Ambatufakingnut', soundUrl: 'assets/sounds/ambatufakingnut.mp3'),
    SoundItem(name: 'Ambatunat', soundUrl: 'assets/sounds/ambatunat.mp3'),
    SoundItem(
        name: 'Ambatukam choir', soundUrl: 'assets/sounds/ambatukam_choir.mp3'),
    SoundItem(
        name: 'Ambatukam spongebob',
        soundUrl: 'assets/sounds/ambatukam_spongebob.mp3'),
    SoundItem(name: 'Bunda Rahma', soundUrl: 'assets/sounds/bunda_rahma.mp3'),
    SoundItem(name: 'Bus', soundUrl: 'assets/sounds/bus.mp3'),
    SoundItem(name: 'Ambaturemix', soundUrl: 'assets/sounds/ambaturemix.mp3'),
    SoundItem(
        name: 'Ambaturemix #2', soundUrl: 'assets/sounds/ambaturemix_2.mp3'),
    SoundItem(
        name: 'Classical Music', soundUrl: 'assets/sounds/classical_music.mp3'),
    SoundItem(
        name: 'Classical Music #2',
        soundUrl: 'assets/sounds/classical_music_2.mp3'),
    SoundItem(name: 'Ambatublou', soundUrl: 'assets/sounds/ambatublou.mp3'),
    SoundItem(
        name: 'Ambatublou :(', soundUrl: 'assets/sounds/ambatublou_sad.mp3'),
    SoundItem(name: 'I want it', soundUrl: 'assets/sounds/i_want_it.mp3'),
    SoundItem(name: 'Kakangku', soundUrl: 'assets/sounds/kakangku.mp3'),
    SoundItem(name: 'Nissan', soundUrl: 'assets/sounds/nissan.mp3'),
    SoundItem(name: 'Nissan (full)', soundUrl: 'assets/sounds/nissan_full.mp3'),
    SoundItem(name: 'Omaygot', soundUrl: 'assets/sounds/omaygot.mp3'),
    SoundItem(
        name: 'Possessed Dreamybull',
        soundUrl: 'assets/sounds/possessed_dreamybull.mp3'),
    SoundItem(name: 'Ughh', soundUrl: 'assets/sounds/ughh.mp3'),
    SoundItem(
        name: 'Stretch this ahh',
        soundUrl: 'assets/sounds/stretch_this_ahh.mp3'),
    SoundItem(name: 'Yes King', soundUrl: 'assets/sounds/yes_king.mp3'),
  ];

  void playSound(String soundUrl, int index) async {
    audioPlayer.open(
      Audio(soundUrl),
    );
    if (mounted) {
      setState(() {
        currentIndex = index;
      });
    }
  }

  void stopAllSounds() {
    audioPlayer.stop();
    if (mounted) {
      setState(() {
        currentIndex = null;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    audioPlayer.playlistAudioFinished.listen(
      (playing) {
        if (currentIndex != null) {
          if (mounted) {
            setState(() {
              currentIndex = null;
            });
          }
        }
      },
      cancelOnError: false,
    );
  }

  @override
  void dispose() {
    super.dispose();
    audioPlayer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerEnableOpenDragGesture: true,
      body: CustomScrollView(slivers: [
        CustomAppBar(),
        SliverPersistentHeader(
            pinned: true,
            delegate: FixedHeaderDelegate(
                child: Container(
                  padding: EdgeInsets.all(5),
                  alignment: Alignment.centerLeft,
                  color: Color.fromARGB(255, 204, 187, 235),
                ),
                text: 'Soundboard')),
        SliverGrid(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final soundItem = soundItems[index];
              return ElevatedButton(
                onPressed: () {
                  if (currentIndex == index) {
                    stopAllSounds();
                  } else {
                    playSound(soundItem.soundUrl, index);
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: currentIndex == index
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.primary.withOpacity(0.3),
                ),
                child: Text(
                  soundItem.name,
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                  textAlign: TextAlign.center,
                ),
              );
            },
            childCount: soundItems.length,
          ),
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200.0,
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0,
            childAspectRatio: 1.0,
          ),
        ),
      ]),
      drawer: const Sidebar(currentPage: 'Soundboard'),
      floatingActionButton: FloatingActionButton(
        onPressed: stopAllSounds,
        child: const Icon(Icons.stop),
      ),
    );
  }
}
