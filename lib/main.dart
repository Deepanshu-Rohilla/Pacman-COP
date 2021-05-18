import 'package:flutter/material.dart';
import 'homepage.dart';

List<int> scores = [];
List<bool> gamePlayed = [];

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
