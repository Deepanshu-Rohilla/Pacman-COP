import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pacman/main.dart';


class Movables extends StatelessWidget {
  String imagePath;
  Movables(this.imagePath);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(2),
      child: Image.asset(imagePath),
    );
  }
}

class Movables2 extends StatelessWidget {
  Movables2();
  @override
  Widget build(BuildContext context) {
    print("I AM HERE BITCHES");
    print("I AM HERE BITCHES");
    print("I 23AM HERE BITCHES");
    print("I AM432 HERE BITCHES");
    print("I AM HE4RE BITCHES");
    print("I AM HER3E BITCHES");
    print("I AM HERE5 BITCHES");
    print("I AM HERE 34BITCHES");
    print("I AM HERE BI5TCHES");
    print("I AM HERE BIT43CHES");
    print("I AM HERE BITCH5ES");
    print("I AM HERE BITCHES");
    print("I AM HERE BITC34HES");
    print("I AM HERE BITCHE5S");
    if(customImagePath==''){
      return Padding(
        padding: EdgeInsets.all(2),
        child: Image.asset('lib/images/pacman.png'),
      );
    }
    else{
      return Padding(
        padding: EdgeInsets.all(2),
        child: Image.file(File(customImagePath)),
      );
    }

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
