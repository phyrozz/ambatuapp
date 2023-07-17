import 'package:ambatuapp/pages/games/flappy_bus/flappy_bird_game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class FlappyAdBanner extends StatelessWidget {
  final FlappyBirdGame game;
  final BannerAd? bannerAd;

  const FlappyAdBanner({super.key, required this.game, required this.bannerAd});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: bannerAd!.size.width.toDouble(),
        height: bannerAd!.size.height.toDouble(),
        child: AdWidget(ad: bannerAd!),
      ),
    );
  }
}
