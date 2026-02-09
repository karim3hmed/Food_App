import 'package:flutter/material.dart';
import 'package:foodapp/splash.dart';

void main() {
  runApp(FoodApp());
}

class FoodApp extends StatelessWidget {
  const FoodApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(splashColor: Colors.white),
      debugShowCheckedModeBanner: false,
      home: Splash(),
    );
  }
}
