import 'package:flutter/material.dart';


class Movables extends StatelessWidget {
  String imagePath;
  Movables(this.imagePath);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(2),
      child:  Image.asset(imagePath),
    );
  }
}



//class Blinky extends StatelessWidget {
//
//  @override
//  Widget build(BuildContext context) {
//    return Padding(
//      padding: EdgeInsets.all(2),
//      child: Image.asset('lib/images/ghost1.png'),
//    );
//  }
//}
//
//
//class Clyde extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return Padding(
//      padding: EdgeInsets.all(2),
//      child: Image.asset('lib/images/ghost2.png'),
//    );
//  }
//}
//
//class Inky extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return Padding(
//      padding: EdgeInsets.all(2),
//      child: Image.asset('lib/images/ghost3.png'),
//    );
//  }
//}
//
//
//class Pacman extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return Padding(
//      padding: const EdgeInsets.all(2.0),
//      child: Image.asset(
//        'lib/images/pacman.png',
//      ),
//    );
//  }
//}
