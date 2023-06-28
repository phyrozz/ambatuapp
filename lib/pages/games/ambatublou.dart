import 'package:ambatuapp/pages/games/ambatublou_select_difficulty.dart';
import 'package:ambatuapp/widgets/sidebar.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:google_fonts/google_fonts.dart';

enum CellState {
  hidden,
  revealed,
  flagged,
}

class AmbatublouGame extends StatefulWidget {
  final int rows;
  final int cols;
  final int totalMines;

  const AmbatublouGame(
      {Key? key,
      required this.rows,
      required this.cols,
      required this.totalMines})
      : super(key: key);

  @override
  State<AmbatublouGame> createState() => _AmbatublouGameState();
}

class _AmbatublouGameState extends State<AmbatublouGame> {
  late List<List<bool>> cellVisibility;
  late List<List<CellState>> gameBoard;
  late List<List<bool>> mines;
  bool gameOver = false;
  final gameOverSfx = AssetsAudioPlayer();

  @override
  void initState() {
    super.initState();
    initializeGame();
  }

  void initializeGame() {
    cellVisibility =
        List.generate(widget.rows, (_) => List.filled(widget.cols, false));

    gameBoard = List.generate(
        widget.rows, (_) => List.filled(widget.cols, CellState.hidden));
    mines = List.generate(widget.rows, (_) => List.filled(widget.cols, false));

    // Place mines randomly
    final random = Random();
    int minesPlaced = 0;
    while (minesPlaced < widget.totalMines) {
      final row = random.nextInt(widget.rows);
      final col = random.nextInt(widget.cols);
      if (!mines[row][col]) {
        mines[row][col] = true;
        minesPlaced++;
      }
    }
  }

  void revealCell(int row, int col) {
    if (gameOver || gameBoard[row][col] != CellState.hidden) {
      return;
    }

    if (mounted) {
      setState(() {
        gameBoard[row][col] = CellState.revealed;
        cellVisibility[row][col] = true;

        if (mines[row][col]) {
          // Game over, show all mines
          gameOver = true;
          revealAllMines();
          showGameOverModal();
        } else if (countAdjacentMines(row, col) == 0) {
          // If the cell has no adjacent mines, automatically reveal neighboring cells
          for (var i = -1; i <= 1; i++) {
            for (var j = -1; j <= 1; j++) {
              final newRow = row + i;
              final newCol = col + j;
              if (isValidCell(newRow, newCol)) {
                revealCell(newRow, newCol);
              }
            }
          }
        }
      });
    }
  }

  void flagCell(int row, int col) {
    if (gameOver) {
      return;
    }

    if (mounted) {
      setState(() {
        final cellState = gameBoard[row][col];
        if (cellState == CellState.hidden) {
          gameBoard[row][col] = CellState.flagged;
        } else if (cellState == CellState.flagged) {
          gameBoard[row][col] = CellState.hidden;
        }
      });
    }
  }

  void revealAllMines() {
    gameOverSfx.open(Audio('assets/sounds/snake_game_over.mp3'));
    gameOverSfx.play();
    for (var i = 0; i < widget.rows; i++) {
      for (var j = 0; j < widget.cols; j++) {
        if (mines[i][j]) {
          gameBoard[i][j] = CellState.revealed;
        }
      }
    }
  }

  int countAdjacentMines(int row, int col) {
    int count = 0;
    for (var i = -1; i <= 1; i++) {
      for (var j = -1; j <= 1; j++) {
        final newRow = row + i;
        final newCol = col + j;
        if (isValidCell(newRow, newCol) && mines[newRow][newCol]) {
          count++;
        }
      }
    }
    return count;
  }

  bool isValidCell(int row, int col) {
    return row >= 0 && row < widget.rows && col >= 0 && col < widget.cols;
  }

  void showGameOverModal() {
    Future.delayed(const Duration(seconds: 2), () {
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
                      'Game Over',
                      style: TextStyle(fontSize: 32.0),
                    ),
                    const SizedBox(
                      height: 12.0,
                    ),
                    const Text('You hit a mine!'),
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
                            Navigator.pop(context);
                            if (mounted) {
                              setState(() {
                                gameOver = false;
                                initializeGame();
                              });
                            }
                          },
                        ),
                        ElevatedButton(
                          style: const ButtonStyle(
                            padding: MaterialStatePropertyAll(
                                EdgeInsets.fromLTRB(30, 15, 30, 15)),
                          ),
                          child: const Text('Choose another difficulty'),
                          onPressed: () {
                            Navigator.pop(context);
                            if (mounted) {
                              setState(() {
                                gameOver = false;
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            const AmbatublouSelectDifficulty()));
                              });
                            }
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
    });
  }

  @override
  void dispose() {
    gameOverSfx.stop();
    gameOverSfx.dispose();
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
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height / 1.2,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(widget.rows, (row) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(widget.cols, (col) {
                  return GestureDetector(
                    onTap: () => revealCell(row, col),
                    onLongPress: () => flagCell(row, col),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      width: MediaQuery.of(context).size.width / widget.cols,
                      height: MediaQuery.of(context).size.width / widget.cols,
                      decoration: BoxDecoration(
                        color: gameBoard[row][col] == CellState.revealed
                            ? Theme.of(context).primaryColorDark
                            : Theme.of(context).primaryColorLight,
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Center(
                        child: _buildCellContent(row, col),
                      ),
                    ),
                  );
                }),
              );
            }),
          ),
        ),
      ),
      drawer: const Sidebar(currentPage: 'Ambatublou'),
    );
  }

  Widget _buildCellContent(int row, int col) {
    final cellState = gameBoard[row][col];
    if (cellState == CellState.flagged) {
      return Icon(Icons.flag, color: Theme.of(context).primaryColor, size: 20);
    } else if (cellState == CellState.revealed && mines[row][col]) {
      return Stack(
        children: [
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width / widget.cols,
              height: MediaQuery.of(context).size.width / widget.cols,
              color: Colors.redAccent[700],
            ),
          ),
          Center(
            child: Image.asset(
              'assets/mine.jpg',
              width: MediaQuery.of(context).size.width / widget.cols - 10,
              height: MediaQuery.of(context).size.width / widget.cols - 10,
            ),
          ),
        ],
      );
    } else if (cellState == CellState.revealed) {
      final count = countAdjacentMines(row, col);
      if (count > 0) {
        return Text(
          count.toString(),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        );
      }
    }
    return const SizedBox.shrink();
  }
}
