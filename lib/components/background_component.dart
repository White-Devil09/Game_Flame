import 'package:flame/components.dart';
import 'package:game/Games/giftgrabber.dart';
import 'package:game/globals.dart';

class BackgroundComponent extends SpriteComponent with HasGameRef<GiftGrabGame>{
  @override
  Future<void> onLoad() async{
    await super.onLoad(); 

    sprite = await gameRef.loadSprite(Globals.backgroundSprite);
    size = gameRef.size;
  }
}