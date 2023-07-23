import 'package:ambatuapp/pages/games/flappy_bus/character_list.dart';
import 'package:ambatuapp/pages/games/flappy_bus/flappy_bird_game.dart';
import 'package:ambatuapp/pages/games/flappy_bus/flappy_bus.dart';
import 'package:flutter/material.dart';

class CharacterSelectionDialog extends StatefulWidget {
  final FlappyBirdGame game;

  const CharacterSelectionDialog({super.key, required this.game});

  @override
  State<CharacterSelectionDialog> createState() =>
      _CharacterSelectionDialogState();
}

class _CharacterSelectionDialogState extends State<CharacterSelectionDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.elasticOut,
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onPlayAgainPressed() {
    widget.game.resetGame();
    _animationController.reverse().then((_) {
      widget.game.overlays.remove('GameOver');
    });
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: ScaleTransition(
        scale: _animation,
        child: Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            constraints: const BoxConstraints(maxHeight: 450),
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Choose a bird',
                    style: TextStyle(fontSize: 32),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GridView.count(
                    crossAxisCount: 2, // Number of buttons per row
                    shrinkWrap: true,
                    children: characters
                        .map((character) => Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: CharacterButton(
                                character: character,
                                onPressed: () {
                                  setState(() {
                                    // Set the selected bird asset path
                                    widget.game.selectedBirdAsset =
                                        character.imagePath.substring(14);
                                  });
                                  // Load the selected bird asset and remove the character selection overlay
                                  widget.game.loadBirdAsset();
                                  widget.game.overlays
                                      .remove('CharacterSelection');
                                },
                              ),
                            ))
                        .toList(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
