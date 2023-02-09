import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/palette.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:game/components/background_component.dart';
import 'package:game/components/gift_component.dart';
import 'package:game/components/ice_component.dart';
import 'package:game/components/santa_component.dart';
import 'package:game/globals.dart';
import 'package:game/joystick.dart';

import '../screens/game_over_menu.dart';


class GiftGrabGame extends FlameGame with HasDraggables, HasCollisionDetection {
  int score = 0;
  late Timer _timer;
  int _remainingTime = 90;
  late TextComponent _timeText;
  late TextComponent _scoreText;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    add(BackgroundComponent());
    add(GiftComponent());
    add(SantaComponent(joystick: joystick));
    add(joystick);

    FlameAudio.audioCache.loadAll([
      Globals.itemGrabSound,
      Globals.freezeSound,
    ]);

    add(IceComponent(startPositon: Vector2(200, 200)));
    add(IceComponent(startPositon: Vector2(size.x - 200, size.y - 200)));
    add(ScreenHitbox());

    _scoreText = TextComponent(
        text: 'Score : $score',
        position: Vector2(40, 40),
        anchor: Anchor.topLeft,
        textRenderer: TextPaint(
            style: TextStyle(
              color: BasicPalette.white.color,
               fontSize: 15
            )
          )
    );

    add(_scoreText);

    _timeText = TextComponent(
        text: 'Remaining Time : $_remainingTime seconds',
        position: Vector2(size.x - 40, 40),
        anchor: Anchor.topRight,
        textRenderer: TextPaint(
            style: TextStyle(
              color: BasicPalette.white.color,
               fontSize: 15
            )
          )
    );

    add(_timeText);

      

    _timer = Timer(
      1,
      repeat: true,
      onTick: () {
        if (_remainingTime == 0) {
          pauseEngine();
          overlays.add(GameOverMenu.iD);
        } else {
          _remainingTime -= 1;
        }
      },
    );

    _timer.start();
  }

  @override
  void update(dt){
    super.update(dt);
    _timer.update(dt);
    _scoreText.text = 'Score : $score';
    _timeText.text ='Remaining Time : $_remainingTime';
  }

  void reset(){
    score = 0;
    _remainingTime = 90;
  }
}
