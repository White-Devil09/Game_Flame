import 'package:flutter/material.dart';

import '../globals.dart';
import 'game_play.dart';

class MainMenu extends StatelessWidget {
  const MainMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/${Globals.backgroundSprite}"),
                fit: BoxFit.cover)),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 40),
              child: Text(
                "Gift Collector",
                style: TextStyle(fontSize: 40),
              ),
            ),
            SizedBox(
              width: 250,
              height: 50,
              child: ElevatedButton(
                  onPressed:(){
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context)=>const GamePlay(),
                      )
                    );
                  },     
                  child: const Text(
                    "Play",
                    style: TextStyle(fontSize: 40),
                  )),
            )
          ],
        )),
      ),
    );
  }
}
