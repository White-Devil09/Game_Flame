import 'package:flutter/material.dart';
import 'package:game/screens/main_menu.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MainMenu(),
  ));
}