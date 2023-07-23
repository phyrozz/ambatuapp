import 'package:ambatuapp/ad_helper.dart';
import 'package:ambatuapp/widgets/sidebar.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';
import 'package:google_fonts/google_fonts.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AmbatuSnakePage extends StatefulWidget {
  const AmbatuSnakePage({super.key});

  @override
  State<AmbatuSnakePage> createState() => _AmbatuSnakePageState();
}

class _AmbatuSnakePageState extends State<AmbatuSnakePage> {
  final int numRows = 20;
  final int numColumns = 20;
  final int snakeSpeed = 200; // milliseconds
  final gameOverSfx = AssetsAudioPlayer();

  List<int> snake = [];
  List<int> food = [];
  List<AssetsAudioPlayer> activePlayers = [];
  List<String> audioFiles = [
    'assets/sounds/snake_food1.mp3',
    'assets/sounds/snake_food2.mp3',
    'assets/sounds/snake_food3.mp3',
    'assets/sounds/snake_food4.mp3',
    'assets/sounds/snake_food5.mp3',
    'assets/sounds/snake_food6.mp3',
    'assets/sounds/snake_food7.mp3',
  ];
  Direction direction = Direction.right;
  GameStatus gameStatus = GameStatus.notStarted;
  Timer? timer;
  BannerAd? _bannerAd;

  @override
  void initState() {
    super.initState();
    startGame();

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
  }

  void startGame() {
    resetGame();

    if (timer != null) {
      timer!.cancel();
    }
    timer = Timer.periodic(Duration(milliseconds: snakeSpeed), (timer) {
      moveSnake();
    });
  }

  void resetGame() {
    if (mounted) {
      setState(() {
        snake = [44, 45];
        food = generateFood();
        direction = Direction.right;
        gameStatus = GameStatus.playing;
      });
    }

    if (timer != null) {
      timer!.cancel();
    }
    timer = Timer.periodic(Duration(milliseconds: snakeSpeed), (timer) {
      moveSnake();
    });
  }

  List<int> generateFood() {
    final random = Random();
    int randomNumber = random.nextInt(numRows * numColumns);

    // Ensure that food does not appear on the snake's body
    while (snake.contains(randomNumber)) {
      randomNumber = random.nextInt(numRows * numColumns);
    }

    return [randomNumber];
  }

  void moveSnake() {
    if (mounted) {
      setState(() {
        if (gameStatus != GameStatus.playing) {
          return;
        }

        final head = snake.last;
        int nextCell = 0;

        switch (direction) {
          case Direction.up:
            nextCell = head - numColumns;
            break;
          case Direction.down:
            nextCell = head + numColumns;
            break;
          case Direction.left:
            nextCell = head - 1;
            break;
          case Direction.right:
            nextCell = head + 1;
            break;
        }

        if (snake.contains(nextCell) ||
            nextCell < 0 ||
            nextCell >= numRows * numColumns) {
          gameOverSfx.open(Audio('assets/sounds/snake_game_over.mp3'));
          gameOverSfx.play();
          gameStatus = GameStatus.gameOver;
          timer!.cancel();
          showModalBottomSheet<void>(
            context: context,
            isDismissible: false,
            enableDrag: false,
            builder: (BuildContext context) {
              return WillPopScope(
                onWillPop: () async {
                  return false;
                },
                child: Container(
                  height: 300,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const Text(
                          'Game Over!',
                          style: TextStyle(fontSize: 32.0),
                        ),
                        const SizedBox(
                          height: 40.0,
                        ),
                        ButtonBar(
                          alignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              style: const ButtonStyle(
                                padding: MaterialStatePropertyAll(
                                    EdgeInsets.fromLTRB(30, 15, 30, 15)),
                              ),
                              child: const Text('Play Again'),
                              onPressed: () {
                                resetGame();
                                Navigator.pop(context);
                              },
                            ),
                            ElevatedButton(
                              style: const ButtonStyle(
                                padding: MaterialStatePropertyAll(
                                    EdgeInsets.fromLTRB(30, 15, 30, 15)),
                              ),
                              child: const Text('Exit'),
                              onPressed: () {
                                Navigator.pop(context);
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
          return;
        }

        snake.add(nextCell);

        if (nextCell == food.first) {
          food = generateFood();

          // Play a sound effect when the snake eats the food
          final random = Random();
          final audioIndex = random.nextInt(audioFiles.length);
          final audioFilePath = audioFiles[audioIndex];
          final player = AssetsAudioPlayer.newPlayer();
          player.open(Audio(audioFilePath));
          activePlayers.add(player);
          player.play();
        } else {
          snake.removeAt(0);
        }
      });
    }
  }

  void handleUserInput(DirectionalKey key) {
    if (gameStatus != GameStatus.playing) {
      return;
    }

    switch (key) {
      case DirectionalKey.up:
        if (direction != Direction.down) {
          direction = Direction.up;
        }
        break;
      case DirectionalKey.down:
        if (direction != Direction.up) {
          direction = Direction.down;
        }
        break;
      case DirectionalKey.left:
        if (direction != Direction.right) {
          direction = Direction.left;
        }
        break;
      case DirectionalKey.right:
        if (direction != Direction.left) {
          direction = Direction.right;
        }
        break;
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    for (final f in activePlayers) {
      f.dispose();
    }
    gameOverSfx.dispose();
    _bannerAd?.dispose();
    super.dispose();
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
      body: GestureDetector(
        onVerticalDragUpdate: (details) {
          if (details.delta.dy > 0) {
            handleUserInput(DirectionalKey.down);
          } else if (details.delta.dy < 0) {
            handleUserInput(DirectionalKey.up);
          }
        },
        onHorizontalDragUpdate: (details) {
          if (details.delta.dx > 0) {
            handleUserInput(DirectionalKey.right);
          } else if (details.delta.dx < 0) {
            handleUserInput(DirectionalKey.left);
          }
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            if (_bannerAd != null)
              Positioned(
                bottom: 10,
                child: Container(
                  width: _bannerAd!.size.width.toDouble(),
                  height: _bannerAd!.size.height.toDouble(),
                  child: AdWidget(ad: _bannerAd!),
                ),
              ),
            Center(
              child: Container(
                margin: const EdgeInsets.all(10),
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: numColumns,
                  ),
                  itemCount: numRows * numColumns,
                  itemBuilder: (BuildContext context, int index) {
                    final cellColor = snake.contains(index)
                        ? Theme.of(context).primaryColorDark
                        : (food.contains(index)
                            ? Colors.transparent
                            : Theme.of(context).primaryColorLight);
                    return Container(
                      color: cellColor,
                      child: food.contains(index)
                          ? Image.asset(
                              'assets/dreamy_smiling.jpg',
                              fit: BoxFit.fill,
                            )
                          : null,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      drawer: const Sidebar(currentPage: 'AmbatuSnake'),
    );
  }
}

enum Direction { up, down, left, right }

enum DirectionalKey { up, down, left, right }

enum GameStatus { notStarted, playing, gameOver }
