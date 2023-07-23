import 'package:ambatuapp/ad_helper.dart';
import 'package:ambatuapp/pages/games/flappy_bus/character_list.dart';
import 'package:ambatuapp/pages/games/flappy_bus/character_selection.dart';
import 'package:ambatuapp/pages/games/flappy_bus/game_over.dart';
import 'package:flame/game.dart';
import 'package:ambatuapp/pages/games/flappy_bus/flappy_bird_game.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class FlappyBusPage extends StatefulWidget {
  const FlappyBusPage({super.key});

  @override
  State<FlappyBusPage> createState() => _FlappyBusPageState();
}

class _FlappyBusPageState extends State<FlappyBusPage> {
  BannerAd? _bannerAd;
  bool _canGoBack = true;
  late FlappyBirdGame game;

  @override
  void initState() {
    super.initState();

    BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          if (mounted) {
            setState(() {
              _bannerAd = ad as BannerAd;
            });
          }
        },
        onAdFailedToLoad: (ad, err) {
          ad.dispose();
        },
      ),
    ).load();
    game = FlappyBirdGame(context, _bannerAd);
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    // game.detach();
    // print('The game has been disposed.');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        GameWidget(
          game: game,
          overlayBuilderMap: {
            'CharacterSelection': (BuildContext context, FlappyBirdGame game) {
              return CharacterSelectionDialog(game: game);
            },
            'AdBanner': (BuildContext context, FlappyBirdGame game) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    bottom: 10,
                    child: _bannerAd != null
                        ? Container(
                            width: _bannerAd!.size.width.toDouble(),
                            height: _bannerAd!.size.height.toDouble(),
                            child: AdWidget(ad: _bannerAd!),
                          )
                        : Container(),
                  ),
                ],
              );
            },
            'GameOver': (BuildContext context, FlappyBirdGame game) {
              return GameOverDialog(game: game);
            },
          },
        ),
      ]),
    );
  }

  Future<bool> onWillPop() async {
    if (_canGoBack) {
      _canGoBack = false;
      return true;
    } else {
      return false;
    }
  }
}

class CharacterButton extends StatelessWidget {
  final Character character;
  final VoidCallback onPressed;

  const CharacterButton(
      {super.key, required this.character, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(character.imagePath,
              width: 50, height: 50), // Adjust the size as needed
          Text(character.name),
        ],
      ),
    );
  }
}
