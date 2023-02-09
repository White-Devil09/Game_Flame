import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:game/Games/giftgrabber.dart';
import 'package:game/components/santa_component.dart';
import 'package:game/globals.dart';

class GiftComponent extends SpriteComponent
    with HasGameRef<GiftGrabGame>, CollisionCallbacks {
  final _spriteHeight = 80.0;
  final Random _random = Random();

  GiftComponent();


  @override
  Future<void> onLoad() async {
    await super.onLoad();

    sprite = await gameRef.loadSprite(Globals.giftSprite);
    size = gameRef.size;
    height = width = _spriteHeight;
    position = _getRandomPositon();
    anchor = Anchor.center;
    add(CircleHitbox());
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is SantaComponent) {
      FlameAudio.play(Globals.itemGrabSound);
      removeFromParent();
      gameRef.score += 1;
      gameRef.add(GiftComponent());
    }
  }
  
  Vector2 _getRandomPositon() {
    double x = _random.nextInt(gameRef.size.x.toInt()).toDouble();
    double y = _random.nextInt(gameRef.size.y.toInt()).toDouble();

    return Vector2(x, y);
  }
}
