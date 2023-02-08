import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:game/Games/giftgrabber.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  runApp(GameWidget(game: GiftGrabGame()));
}