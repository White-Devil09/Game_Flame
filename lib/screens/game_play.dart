import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:game/Games/giftgrabber.dart';
import 'package:game/screens/game_over_menu.dart';

final GiftGrabGame _giftGrabGame = GiftGrabGame();

class GamePlay extends StatelessWidget {
  const GamePlay({super.key});

  @override
  Widget build(BuildContext context) {
    return GameWidget(
      game: _giftGrabGame,
      overlayBuilderMap: {
        GameOverMenu.iD: (BuildContext context, GiftGrabGame gameRef) =>
            GameOverMenu(gameRef: gameRef),
      },
    );
  }
}
