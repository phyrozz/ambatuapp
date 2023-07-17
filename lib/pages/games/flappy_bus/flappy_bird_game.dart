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
  // final BannerAd? bannerAd;
  FlappyBirdGame(
    this.context,
    // this.bannerAd
  );

  int score = 0;
  late AudioPool death;
  late AudioPool scoreSound;
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

  @override
  Future<void> onLoad() async {
    death =
        await AudioPool.createFromAsset(path: 'audio/death.mp3', maxPlayers: 5);
    scoreSound = await AudioPool.createFromAsset(
        path: 'audio/score.mp3', maxPlayers: 100);
    tap =
        await AudioPool.createFromAsset(path: 'audio/tap.mp3', maxPlayers: 100);

    addAll([
      Background(),
      Ground(),
      _bird = Bird(),
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
  }

  void resetGame() {
    // Reset game state
    isGameOver = false;
    _timeSinceLastPipeGroup = 0;
    _scoreCountInterval = 0;
    _countToFirstPipeGroup = 0;
    score = 0;

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
  void update(double dt) {
    super.update(dt);
    _timeSinceLastPipeGroup += dt;
    _countToFirstPipeGroup += dt;
    if (_countToFirstPipeGroup > 2.8) {
      _scoreCountInterval += dt;
      if (_scoreCountInterval > 1.5) {
        scoreSound.start();
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

    showModalBottomSheet<void>(
      context: context,
      isDismissible: false,
      enableDrag: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: Container(
            height: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Game Over',
                  style: TextStyle(fontSize: 32.0),
                ),
                const SizedBox(height: 12.0),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Close the modal

                    resetGame(); // Restart the game
                    resumeEngine(); // Resume the game
                  },
                  child: const Text('Try Again'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
