import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/flame.dart';
import 'package:ambatuapp/pages/games/flappy_bus/flappy_bird_game.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

class Bird extends SpriteComponent
    with HasGameRef<FlappyBirdGame>, CollisionCallbacks {
  String birdAssetPath;
  Bird(this.birdAssetPath);

  double velocity = 200;
  final gravity = 400;

  @override
  Future<void> onLoad() async {
    final image = await Flame.images.load(birdAssetPath);
    size = Vector2(40, 40);
    position = Vector2(50, gameRef.size.y / 2 - size.y / 2);
    sprite = Sprite(image);

    add(CircleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);

    // Update the bird's velocity.
    velocity += gravity * dt;

    // Update the bird's position.
    position.y += velocity * dt;

    // Cap the velocity.
    velocity = velocity.clamp(-200, 250);
  }

  void fly() {
    add(
      MoveByEffect(
        Vector2(0, -85),
        EffectController(duration: 0.2, curve: Curves.decelerate),
      ),
    );
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    gameRef.gameOver(); // Call the gameOver method on collision
  }

  reset() {
    position = Vector2(50, gameRef.size.y / 2 - size.y / 2);
  }

  gameOver() {
    gameRef.pauseEngine();
  }
}
