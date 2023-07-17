import 'package:ambatuapp/ad_helper.dart';
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
  // BannerAd? _bannerAd;
  bool _canGoBack = true;

  @override
  void initState() {
    super.initState();

    // BannerAd(
    //   adUnitId: AdHelper.bannerAdUnitId,
    //   request: const AdRequest(),
    //   size: AdSize.banner,
    //   listener: BannerAdListener(
    //     onAdLoaded: (ad) {
    //       setState(() {
    //         _bannerAd = ad as BannerAd;
    //       });
    //     },
    //     onAdFailedToLoad: (ad, err) {
    //       ad.dispose();
    //     },
    //   ),
    // ).load();
  }

  @override
  void dispose() {
    // _bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    FlappyBirdGame game = FlappyBirdGame(context);

    return Scaffold(
      body: Stack(children: [
        GameWidget(
          game: game, // Pass _bannerAd to the game
        ),
        // Positioned(
        //   bottom: 0,
        //   child: _bannerAd != null
        //       ? Container(
        //           width: _bannerAd!.size.width.toDouble(),
        //           height: _bannerAd!.size.height.toDouble(),
        //           child: AdWidget(ad: _bannerAd!),
        //         )
        //       : Container(),
        // ),
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
