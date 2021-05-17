import 'package:flutter/material.dart';



class Ghost1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(2),
      child: Image.asset('lib/images/ghost.png'),
    );
  }
}


class MyGhost2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(2),
      child: Image.asset('lib/images/ghost2.png'),
    );
  }
}

class MyGhost3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(2),
      child: Image.asset('lib/images/ghost3.png'),
    );
  }
}


class MyPlayer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Image.asset(
        'lib/images/pacman.png',
      ),
    );
  }
}
