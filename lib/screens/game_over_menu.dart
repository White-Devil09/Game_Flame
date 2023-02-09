import 'package:flutter/material.dart';
import '../Games/giftgrabber.dart';
import '../globals.dart';

class GameOverMenu extends StatelessWidget {
  static const String iD = 'GameOverMenu';
  final GiftGrabGame gameRef;
  const GameOverMenu({Key? key, required this.gameRef}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
        image: AssetImage("assets/images/${Globals.backgroundSprite}"),
        fit: BoxFit.cover,
      )),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 40),
              child: Text(
                "Game Over",
                style: TextStyle(fontSize: 40),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: Text(
                "Score : ${gameRef.score}",
                style: const TextStyle(fontSize: 40),
              ),
            ),
            SizedBox(
              width: 250,
              height: 50,
              child: ElevatedButton(
                onPressed: (){
                  gameRef.overlays.remove(GameOverMenu.iD);
                  gameRef.reset();
                  gameRef.resumeEngine();
                },
                child: const Text("Play again?",style: TextStyle(fontSize: 40),),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
