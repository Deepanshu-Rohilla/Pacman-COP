import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:audioplayers/audio_cache.dart';
class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  static int numberInRow = 11;
  int numberOfSquares = numberInRow * 16;
  List<int> positionOfMovables = [numberInRow * 14 + 1, numberInRow * 2 - 2, numberInRow * 9 - 1, numberInRow * 11 - 2];
  List<String> directionOfMovement = ['right', 'left', 'left', 'down'];
  // Index 0 : Pacman (Player)
  // Index 1 : Blinky (Red)
  // Index 2 : Clyde (Yellow)
  // Index 3 : Inky (Green/Cyan)
  List<int> foodEaten = [];
  bool preGame = true;
  bool mouthClosed = false;
  var controller;
  int score = 0;
  bool paused = false;
  AudioPlayer advancedPlayer = new AudioPlayer();
  AudioPlayer advancedPlayer2 = new AudioPlayer();
  AudioCache audioInGame = new AudioCache(prefix: 'assets/');
  AudioCache audioMunch = new AudioCache(prefix: 'assets/');
  AudioCache audioDeath = new AudioCache(prefix: 'assets/');
  AudioCache audioPaused = new AudioCache(prefix: 'assets/');
  List<int> barriers = [
    0,
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    22,
    33,
    44,
    55,
    66,
    77,
    99,
    110,
    121,
    132,
    143,
    154,
    165,
    166,
    167,
    168,
    169,
    170,
    171,
    172,
    173,
    174,
    175,
    164,
    153,
    142,
    131,
    120,
    109,
    87,
    76,
    65,
    54,
    43,
    32,
    21,
    78,
    79,
    80,
    100,
    101,
    102,
    84,
    85,
    86,
    106,
    107,
    108,
    24,
    35,
    46,
    57,
    30,
    41,
    52,
    63,
    81,
    70,
    59,
    61,
    72,
    83,
    26,
    28,
    37,
    38,
    39,
    123,
    134,
    145,
    129,
    140,
    151,
    103,
    114,
    125,
    105,
    116,
    127,
    147,
    148,
    149,
  ];

  void moveLeft(int index){
    if (!barriers.contains(positionOfMovables[index] - 1)) {
      setState(() {
        positionOfMovables[index]--;
      });
    }
  }
  void moveRight(int index){
    if (!barriers.contains(positionOfMovables[index] + 1)) {
      setState(() {
        positionOfMovables[index]++;
      });
    }
  }
  void moveUp(int index){
    if (!barriers.contains(positionOfMovables[index] - numberInRow)) {
      setState(() {
        positionOfMovables[index] -= numberInRow;
      });
    }
  }
  void moveDown(int index){
    if (!barriers.contains(positionOfMovables[index] + numberInRow)) {
      setState(() {
        positionOfMovables[index] += numberInRow;
      });
    }
  }

  void moveMovable(int index){
    switch(directionOfMovement[index]){
      case 'left':
        moveLeft(index);
        break;
      case 'right':
        moveRight(index);
        break;
      case 'up':
        moveUp(index);
        break;
      case 'down':
        moveDown(index);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
