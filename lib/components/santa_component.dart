import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:game/Games/giftgrabber.dart';
import 'package:game/components/ice_component.dart';
import 'package:game/globals.dart';

enum MovementState { idle, slideLeft, slideRight, frozen }

class SantaComponent extends SpriteGroupComponent<MovementState>
    with HasGameRef<GiftGrabGame>, CollisionCallbacks {
  final _spriteHeight = 150.0;

  final _speed = 500.0;

  late double _upBound;
  late double _downBound;
  late double _rightBound;
  late double _leftBound;

  JoystickComponent joystick;

  bool _frozen = false;
  final Timer _timer = Timer(2);
  SantaComponent({required this.joystick});
  @override
  Future<void> onLoad() async {
    await super.onLoad();

    Sprite santaIdle = await gameRef.loadSprite(Globals.santaIdleSprite);
    Sprite santaSlideLeft =
        await gameRef.loadSprite(Globals.santaLeftSlideSprite);
    Sprite santaSlideRight =
        await gameRef.loadSprite(Globals.santaRightSlideSprite);
    Sprite santaFrozen = await gameRef.loadSprite(Globals.santaFrozenSprite);

    sprites = {
      MovementState.idle: santaIdle,
      MovementState.slideLeft: santaSlideLeft,
      MovementState.slideRight: santaSlideRight,
      MovementState.frozen: santaFrozen,
    };

    _rightBound = gameRef.size.x - 45;
    _leftBound = 45;
    _upBound = 55;
    _downBound = gameRef.size.y - 55;

    current = MovementState.idle;

    position = gameRef.size / 2;
    height = _spriteHeight;
    width = _spriteHeight * 1.42;
    anchor = Anchor.center;
    add(CircleHitbox());
  }

  @override
  void update(dt) {
    super.update(dt);

    if (!_frozen) {
      if (joystick.direction == JoystickDirection.idle) {
        current = MovementState.idle;
        return;
      }
      if (x >= _rightBound) {
        x = _rightBound - 1;
      }
      if (x <= _leftBound) {
        x = _leftBound + 1;
      }
      if (y >= _downBound) {
        y = _downBound + 1;
      }
      if (y <= _upBound) {
        y = _upBound + 1;
      }

      bool movementLeft = joystick.relativeDelta[0] < 0;
      if (movementLeft) {
        current = MovementState.slideLeft;
      } else {
        current = MovementState.slideRight;
      }

      position.add(joystick.relativeDelta * _speed * dt);
    } else {
      _timer.update(dt);
      if (_timer.finished) {
        _unfreezeSanta();
      }
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is IceComponent) {
      _freezeSanta();
    }
  }

  void _unfreezeSanta(){
    _frozen = false;
    current = MovementState.idle;
  }

  void _freezeSanta(){
    if(!_frozen){
      FlameAudio.play(Globals.freezeSound);
      _frozen = true;
      current = MovementState.frozen;
      _timer.start();
    }
  }
}
