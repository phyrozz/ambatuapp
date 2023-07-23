import 'dart:math';

import 'package:ambatuapp/pages/games/flappy_bus/flappy_bird_game.dart';
import 'package:ambatuapp/pages/games/flappy_bus/pipe.dart';
import 'package:flame/components.dart';

class PipeGroup extends PositionComponent with HasGameRef<FlappyBirdGame> {
  PipeGroup();

  final Random _random = Random();
  static const double pipeSpacingFraction = 0.3;

  @override
  Future<void> onLoad() async {
    position.x = gameRef.size.x;
    final heightMinusGround = gameRef.size.y - 125;

    final spacing = heightMinusGround * pipeSpacingFraction;
    final centerY =
        spacing + _random.nextDouble() * (heightMinusGround - 2 * spacing);
    addAll([
      Pipe(pipePosition: PipePosition.top, height: centerY - spacing / 2),
      Pipe(
          pipePosition: PipePosition.bottom,
          height: heightMinusGround - (centerY + spacing / 2)),
    ]);
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.x -= gameRef.speed * dt;
    if (position.x < -50) {
      removeFromParent();
    }
  }
}
