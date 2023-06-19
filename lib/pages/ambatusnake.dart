import 'package:ambatuapp/widgets/sidebar.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

import 'package:google_fonts/google_fonts.dart';

class AmbatuSnakePage extends StatefulWidget {
  const AmbatuSnakePage({super.key});

  @override
  State<AmbatuSnakePage> createState() => _AmbatuSnakePageState();
}

class _AmbatuSnakePageState extends State<AmbatuSnakePage> {
  final int numRows = 20;
  final int numColumns = 20;
  final int snakeSpeed = 200; // milliseconds

  List<int> snake = [];
  List<int> food = [];
  Direction direction = Direction.right;
  GameStatus gameStatus = GameStatus.notStarted;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    resetGame();
  }

  void resetGame() {
    setState(() {
      snake = [44, 45];
      food = generateFood();
      direction = Direction.right;
      gameStatus = GameStatus.playing;
    });

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
        gameStatus = GameStatus.gameOver;
        timer!.cancel();
        return;
      }

      snake.add(nextCell);

      if (nextCell == food.first) {
        food = generateFood();
      } else {
        snake.removeAt(0);
      }
    });
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
        child: Center(
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
                    ? Colors.lightGreen
                    : (food.contains(index)
                        ? Colors.transparent
                        : Theme.of(context).primaryColorLight);
                return Container(
                  margin: const EdgeInsets.all(1),
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: resetGame,
        child: const Icon(Icons.refresh),
      ),
      drawer: const Sidebar(currentPage: 'AmbatuSnake'),
    );
  }
}

enum Direction { up, down, left, right }

enum DirectionalKey { up, down, left, right }

enum GameStatus { notStarted, playing, gameOver }
