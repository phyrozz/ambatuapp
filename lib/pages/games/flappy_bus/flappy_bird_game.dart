import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:ambatuapp/pages/games/flappy_bus/background.dart';
import 'package:ambatuapp/pages/games/flappy_bus/bird.dart';
import 'package:ambatuapp/pages/games/flappy_bus/ground.dart';
import 'package:ambatuapp/pages/games/flappy_bus/pipe_group.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flame_audio/flame_audio.dart';

class FlappyBirdGame extends FlameGame with TapDetector, HasCollisionDetection {
  final BuildContext context;
  final BannerAd? bannerAd;
  FlappyBirdGame(this.context, this.bannerAd);

  int score = 0;
  late AudioPool death;
  late List<AudioPool> selectedScoreSounds;
  final Random random = Random();
  late AudioPool tap;
  late TextComponent textComponent;
  TextPaint scoreTextBorderPaint = TextPaint(
      style: TextStyle(
    fontSize: 48,
    fontFamily: 'Pixelated',
    foreground: Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..color = Colors.black,
  ));
  TextPaint scoreTextPaint =
      TextPaint(style: const TextStyle(fontSize: 48, fontFamily: 'Pixelated'));
  bool isGameOver = false;
  double speed = 150;
  late Bird _bird;
  late PipeGroup pipeGroup;
  double _timeSinceLastPipeGroup = 0;
  double _countToFirstPipeGroup = 0;
  double _scoreCountInterval = 0;
  final gameOverOverlayIdentifier = "GameOver";
  String selectedBirdAsset = 'bird_1.png';

  @override
  Future<void> onLoad() async {
    death =
        await AudioPool.createFromAsset(path: 'audio/death.mp3', maxPlayers: 5);
    tap = await AudioPool.createFromAsset(path: 'audio/tap.mp3', maxPlayers: 5);

    addAll([
      Background(),
      Ground(),
      pipeGroup = PipeGroup(),
    ]);

    List<PipeGroup> pipeGroupsToRemove = [];

    // Iterate over the children and add any pipe groups to the list.
    for (Component child in children) {
      if (child is PipeGroup) {
        pipeGroupsToRemove.add(child);
      }
    }

    // Remove the pipe groups from the game.
    for (PipeGroup pipeGroup in pipeGroupsToRemove) {
      pipeGroup.removeFromParent();
    }

    overlays.add('CharacterSelection');
    pauseEngine();
    _bird = Bird(selectedBirdAsset);
  }

  Future<Bird> loadBirdAsset() async {
    _bird.removeFromParent();
    _bird = Bird(
        selectedBirdAsset); // Create a new bird component with the selected asset
    add(_bird);
    switch (selectedBirdAsset) {
      case 'bird_1.png':
        selectedScoreSounds = await Future.wait([
          AudioPool.createFromAsset(path: 'audio/score_1.mp3', maxPlayers: 5),
          AudioPool.createFromAsset(path: 'audio/score_2.mp3', maxPlayers: 5),
          AudioPool.createFromAsset(path: 'audio/score_3.mp3', maxPlayers: 5),
          AudioPool.createFromAsset(path: 'audio/score_4.mp3', maxPlayers: 5),
          AudioPool.createFromAsset(path: 'audio/score_5.mp3', maxPlayers: 5),
          AudioPool.createFromAsset(path: 'audio/score_6.mp3', maxPlayers: 5),
        ]);
        break;
      case 'bird_2.png':
        selectedScoreSounds = await Future.wait([
          AudioPool.createFromAsset(
              path: 'audio/score_kakangku_1.mp3', maxPlayers: 5),
          AudioPool.createFromAsset(
              path: 'audio/score_kakangku_2.mp3', maxPlayers: 5),
          AudioPool.createFromAsset(
              path: 'audio/score_kakangku_3.mp3', maxPlayers: 5),
        ]);
        break;
      case 'bird_3.png':
        selectedScoreSounds = await Future.wait([
          AudioPool.createFromAsset(
              path: 'audio/score_nissan_1.mp3', maxPlayers: 5),
          AudioPool.createFromAsset(
              path: 'audio/score_nissan_2.mp3', maxPlayers: 5),
          AudioPool.createFromAsset(
              path: 'audio/score_nissan_3.mp3', maxPlayers: 5),
          AudioPool.createFromAsset(
              path: 'audio/score_nissan_4.mp3', maxPlayers: 5),
        ]);
        break;
      case 'bird_4.png':
        selectedScoreSounds = await Future.wait([
          AudioPool.createFromAsset(
              path: 'audio/score_bunda_1.mp3', maxPlayers: 5),
          AudioPool.createFromAsset(
              path: 'audio/score_bunda_2.mp3', maxPlayers: 5),
          AudioPool.createFromAsset(
              path: 'audio/score_bunda_3.mp3', maxPlayers: 5),
          AudioPool.createFromAsset(
              path: 'audio/score_bunda_4.mp3', maxPlayers: 5),
        ]);
        break;
    }
    resetGame(); // Add the new bird component to the game
    return _bird;
  }

  void resetGame() {
    // Reset game state
    isGameOver = false;
    _timeSinceLastPipeGroup = 0;
    _scoreCountInterval = 0;
    _countToFirstPipeGroup = 0;
    score = 0;

    overlays.clear();
    // Display the ad on the overlay
    overlays.add('AdBanner');
    resumeEngine();

    // Reset bird position
    _bird.reset();

    // Create a list to store the pipe groups that we want to remove.
    List<PipeGroup> pipeGroupsToRemove = [];

    // Iterate over the children and add any pipe groups to the list.
    for (Component child in children) {
      if (child is PipeGroup) {
        pipeGroupsToRemove.add(child);
      }
    }

    // Remove the pipe groups from the game.
    for (PipeGroup pipeGroup in pipeGroupsToRemove) {
      pipeGroup.removeFromParent();
    }
  }

  @override
  void onTap() {
    super.onTap();
    tap.start();
    _bird.fly();
  }

  @override
  void onDetach() {
    super.onDetach();
    try {
      death.dispose();
      // for (var sound in scoreSounds) {
      //   sound.dispose();
      // }
      // for (var sound in bundaScoreSounds) {
      //   sound.dispose();
      // }
      // for (var sound in kakangkuScoreSounds) {
      //   sound.dispose();
      // }
      // for (var sound in nissanScoreSounds) {
      //   sound.dispose();
      // }
      for (var sound in selectedScoreSounds) {
        sound.dispose();
      }
      tap.dispose();
    } catch (e) {
      print("Error disposing death audio pool: $e");
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    _timeSinceLastPipeGroup += dt;
    _countToFirstPipeGroup += dt;
    if (_countToFirstPipeGroup > 2.7) {
      _scoreCountInterval += dt;
      if (_scoreCountInterval > 1.5) {
        int randomIndex = random.nextInt(selectedScoreSounds.length);
        selectedScoreSounds[randomIndex].start();
        score++;
        _scoreCountInterval = 0;
      }
    }
    if (_timeSinceLastPipeGroup > 1.5) {
      add(PipeGroup());
      _timeSinceLastPipeGroup = 0;
    }
    if (_bird.position.y < 0) {
      gameOver();
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    scoreTextPaint.render(
        canvas, '$score', Vector2(MediaQuery.of(context).size.width / 2, 60),
        anchor: Anchor.center);
    scoreTextBorderPaint.render(
        canvas, '$score', Vector2(MediaQuery.of(context).size.width / 2, 60),
        anchor: Anchor.center);
  }

  void gameOver() {
    death.start();
    // Pause the game
    pauseEngine();
    overlays.add(gameOverOverlayIdentifier);
  }
}
