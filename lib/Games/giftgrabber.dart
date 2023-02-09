import 'package:flame/collisions.dart';
import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:game/components/background_component.dart';
import 'package:game/components/gift_component.dart';
import 'package:game/components/ice_component.dart';
import 'package:game/components/santa_component.dart';
import 'package:game/globals.dart';
import 'package:game/joystick.dart';

class GiftGrabGame extends FlameGame with HasDraggables,HasCollisionDetection{
  int score = 0;
  @override
  Future<void> onLoad() async{
    await super.onLoad(); 

    add(BackgroundComponent());
    add(GiftComponent());
    add(SantaComponent(joystick: joystick));
    add(joystick);

    FlameAudio.audioCache.loadAll([
      Globals.itemGrabSound,
      Globals.freezeSound,
    ]);

    add(IceComponent(startPositon: Vector2(200,200)));
    add(IceComponent(startPositon: Vector2(size.x - 200,size.y - 200)));
    add(ScreenHitbox());
  }
}