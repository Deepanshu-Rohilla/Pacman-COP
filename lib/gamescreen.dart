import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:pacman/maze_objects.dart';
import 'package:pacman/movables.dart';
import 'dart:async';
import 'dart:math';
import 'dart:ffi';

import 'package:flutter/rendering.dart';

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  static int numberInRow = 11;
  int numberOfSquares = numberInRow * 16;
  List<int> positionOfMovables = [numberInRow * 14 + 1, numberInRow * 2 - 2, numberInRow * 9 - 1, numberInRow * 11 - 2];
  List<String> directionOfMovement = ['right', 'left', 'left', 'down'];
  List<String> imagePath = ['lib/images/pacman.png', 'lib/images/red.png', 'lib/images/yellow.png', 'lib/images/cyan.png'];
  // Index 0 : Pacman (Player)
  // Index 1 : Blinky (Red)
  // Index 2 : Clyde (Yellow)
  // Index 3 : Inky (Green/Cyan)
  List<int> foodAvailable = [];
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

  void gameOverDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(child: Text("Game Over!")),
            content: Text("Your Score : " + (score).toString()),
            actions: [
              RaisedButton(
                onPressed: () {
                  resetGame();
                },
                textColor: Colors.white,
                padding: const EdgeInsets.all(0.0),
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: <Color>[
                        Color(0xFF0D47A1),
                        Color(0xFF1976D2),
                        Color(0xFF42A5F5),
                      ],
                    ),
                  ),
                  padding: const EdgeInsets.all(10.0),
                  child: const Text('Restart'),
                ),
              )
            ],
          );
        });
  }

  void getFood() {
    for (int i = 0; i < numberOfSquares; i++)
      if (!barriers.contains(i)) {
        foodAvailable.add(i);
      }
  }

  void resetGame() {
    audioInGame.loop('pacman_beginning.wav');
    setState(() {
      positionOfMovables[0] = numberInRow * 14 + 1;
      positionOfMovables[1] = numberInRow * 2 - 2;
      positionOfMovables[2] = numberInRow * 9 - 1;
      positionOfMovables[3] = numberInRow * 11 - 2;
      paused = false;
      preGame = false;
      mouthClosed = false;
      directionOfMovement[0] = "right";
      foodAvailable.clear();
      getFood();
      score = 0;
    });
    Navigator.pop(context);

  }

  Widget generateCell(int index) {
    if (mouthClosed && index == positionOfMovables[0]) {
      return Padding(
        padding: EdgeInsets.all(4),
        child: Container(
          decoration: BoxDecoration(color: Colors.yellow, shape: BoxShape.circle),
        ),
      );
    } else if (index == positionOfMovables[0]) {
      switch (directionOfMovement[0]) {
        case "left":
          return Transform.rotate(
            angle: pi,
            child: Movables(imagePath[0]),
          );
          break;
        case "right":
          return Movables(imagePath[0]);
          break;
        case "up":
          return Transform.rotate(
            angle: 3 * pi / 2,
            child: Movables(imagePath[0]),
          );
          break;
        case "down":
          return Transform.rotate(
            angle: pi / 2,
            child: Movables(imagePath[0]),
          );
          break;
        default:
          return Movables(imagePath[0]);
      }
    } else if (index == positionOfMovables[1]) {
      return Movables(imagePath[1]);
    } else if (index == positionOfMovables[2]) {
      return Movables(imagePath[2]);
    } else if (index == positionOfMovables[3]) {
      return Movables(imagePath[3]);
    } else if (barriers.contains(index)) {
      return MazeCell(
        innerColor: Colors.blue[900],
        outerColor: Colors.blue[800],
        // child: Text(index.toString()),
      );
    } else if (preGame || foodAvailable.contains(index)) {
      return Path(
        innerColor: Colors.yellow,
        outerColor: Colors.black,
        // child: Text(index.toString()),
      );
    } else {
      return Path(
        innerColor: Colors.black,
        outerColor: Colors.black,
      );
    }
  }

  void moveGhost(int index, String direction){
    switch (direction) {
      case "left":
        if (!barriers.contains(positionOfMovables[index] - 1)) {
          setState(() {
            positionOfMovables[index]--;
          });
        } else {
          if (!barriers.contains(positionOfMovables[index] + numberInRow)) {
            setState(() {
              positionOfMovables[index] += numberInRow;
              directionOfMovement[index] = "down";
            });
          } else if (!barriers.contains(positionOfMovables[index] + 1)) {
            setState(() {
              positionOfMovables[index]++;
              directionOfMovement[index] = "right";
            });
          } else if (!barriers.contains(positionOfMovables[index] - numberInRow)) {
            setState(() {
              positionOfMovables[index] -= numberInRow;
              directionOfMovement[index] = "up";
            });
          }
        }
        break;
      case "right":
        if (!barriers.contains(positionOfMovables[index] + 1)) {
          setState(() {
            positionOfMovables[index]++;
          });
        } else {
          if (!barriers.contains(positionOfMovables[index] - numberInRow)) {
            setState(() {
              positionOfMovables[index] -= numberInRow;
              directionOfMovement[index] = "up";
            });
          } else if (!barriers.contains(positionOfMovables[index] + numberInRow)) {
            setState(() {
              positionOfMovables[index] += numberInRow;
              directionOfMovement[index] = "down";
            });
          } else if (!barriers.contains(positionOfMovables[index] - 1)) {
            setState(() {
              positionOfMovables[index]--;
              directionOfMovement[index] = "left";
            });
          }
        }
        break;
      case "up":
        if (!barriers.contains(positionOfMovables[index] - numberInRow)) {
          setState(() {
            positionOfMovables[index] -= numberInRow;
            directionOfMovement[index] = "up";
          });
        } else {
          if (!barriers.contains(positionOfMovables[index] + 1)) {
            setState(() {
              positionOfMovables[index]++;
              directionOfMovement[index] = "right";
            });
          } else if (!barriers.contains(positionOfMovables[index] - 1)) {
            setState(() {
              positionOfMovables[index]--;
              directionOfMovement[index] = "left";
            });
          } else if (!barriers.contains(positionOfMovables[index] + numberInRow)) {
            setState(() {
              positionOfMovables[index] += numberInRow;
              directionOfMovement[index] = "down";
            });
          }
        }
        break;
      case "down":
        if (!barriers.contains(positionOfMovables[index] + numberInRow)) {
          setState(() {
            positionOfMovables[index] += numberInRow;
            directionOfMovement[index] = "down";
          });
        } else {
          if (!barriers.contains(positionOfMovables[index] - 1)) {
            setState(() {
              positionOfMovables[index]--;
              directionOfMovement[index] = "left";
            });
          } else if (!barriers.contains(positionOfMovables[index] + 1)) {
            setState(() {
              positionOfMovables[index]++;
              directionOfMovement[index] = "right";
            });
          } else if (!barriers.contains(positionOfMovables[index] - numberInRow)) {
            setState(() {
              positionOfMovables[index] -= numberInRow;
              directionOfMovement[index] = "up";
            });
          }
        }
        break;
    }
  }

  void moveLeft(int index) {
    if(index!=0){
      moveGhost(index, 'left');
    }
    else{
      if (!barriers.contains(positionOfMovables[index] - 1)) {
        setState(() {
          positionOfMovables[index]--;
        });
      }
    }

  }

  void moveRight(int index) {
    if(index!=0){
      moveGhost(index, 'right');
    }
    else{
      if (!barriers.contains(positionOfMovables[index] + 1)) {
        setState(() {
          positionOfMovables[index]++;
        });
      }
    }

  }

  void moveUp(int index) {
    if(index!=0){
      moveGhost(index, 'up');
    }
    else{
      if (!barriers.contains(positionOfMovables[index] - numberInRow)) {
        setState(() {
          positionOfMovables[index] -= numberInRow;
        });
      }
    }

  }

  void moveDown(int index) {
    if(index!=0){
      moveGhost(index, 'down');
    }
    else{
      if (!barriers.contains(positionOfMovables[index] + numberInRow)) {
        setState(() {
          positionOfMovables[index] += numberInRow;
        });
      }
    }

  }

  void moveMovable(int index) {
    switch (directionOfMovement[index]) {
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

  void playGame() {
    if (preGame) {
      advancedPlayer = new AudioPlayer();
      audioInGame = new AudioCache(fixedPlayer: advancedPlayer);
      audioPaused = new AudioCache(fixedPlayer: advancedPlayer2);
      audioInGame.loop('pacman_beginning.wav');
      preGame = false;
      getFood();
      Timer.periodic(Duration(milliseconds: 10), (timer) {
        if (paused) {
        } else {
          advancedPlayer.resume();
        }
        if (positionOfMovables[0] == positionOfMovables[1] || positionOfMovables[0] == positionOfMovables[2] || positionOfMovables[0] == positionOfMovables[3]) {
          advancedPlayer.stop();
          audioDeath.play('pacman_death.wav');
          setState(() {
            positionOfMovables[0] = -1;
          });
          gameOverDialog();
        }
      });
      Timer.periodic(Duration(milliseconds: 190), (timer) {
        if (!paused) {
          moveMovable(1);
          moveMovable(2);
          moveMovable(3);
        }
      });
      Timer.periodic(Duration(milliseconds: 170), (timer) {
        setState(() {
          mouthClosed = !mouthClosed;
        });
        if (foodAvailable.contains(positionOfMovables[0])) {
          audioMunch.play('pacman_chomp.wav');
          setState(() {
            foodAvailable.remove(positionOfMovables[0]);
          });
          score++;
        }
        switch (directionOfMovement[0]) {
          case "left":
            if (!paused) moveLeft(0);
            break;
          case "right":
            if (!paused) moveRight(0);
            break;
          case "up":
            if (!paused) moveUp(0);
            break;
          case "down":
            if (!paused) moveDown(0);
            break;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            flex: (MediaQuery.of(context).size.height.toInt() * 0.0139).toInt(),
            child: GestureDetector(
              onVerticalDragUpdate: (details) {
                if (details.delta.dy > 0) {
                  directionOfMovement[0] = "down";
                } else if (details.delta.dy < 0) {
                  directionOfMovement[0] = "up";
                }
                // print(direction);
              },
              onHorizontalDragUpdate: (details) {
                if (details.delta.dx > 0) {
                  directionOfMovement[0] = "right";
                } else if (details.delta.dx < 0) {
                  directionOfMovement[0] = "left";
                }
                // print(direction);
              },
              child: Container(
                child: GridView.builder(
                  padding: (MediaQuery.of(context).size.height.toInt() * 0.0139).toInt() > 10 ? EdgeInsets.only(top: 80) : EdgeInsets.only(top: 20),
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: numberOfSquares,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: numberInRow),
                  itemBuilder: (BuildContext context, int index) {
                    return generateCell(index);
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    " Score : " + (score).toString(),
                    // // (MediaQuery.of(context).size.height.toInt() * 0.0139)
                    //     .toInt()
                    //     .toString(),
                    style: TextStyle(color: Colors.white, fontSize: 23),
                  ),
                  GestureDetector(
                    onTap: (){
                      playGame();
                    },
                    child: Text("P L A Y",
                        style: TextStyle(color: Colors.white, fontSize: 23)),
                  ),
                  if (!paused)
                    GestureDetector(
                      child: Icon(
                        Icons.pause,
                        color: Colors.white,
                      ),
                      onTap: () => {
                        if (!paused)
                          {
                            paused = true,
                            advancedPlayer.pause(),
                            audioPaused.loop('pacman_intermission.wav'),
                          }
                        else
                          {
                            paused = false,
                            advancedPlayer2.stop(),
                          },
                        Icon(
                          Icons.play_arrow,
                          color: Colors.white,
                        )
                      },
                    ),
                  if (paused)
                    GestureDetector(
                      child: Icon(
                        Icons.play_arrow,
                        color: Colors.white,
                      ),
                      onTap: () => {
                        if (paused)
                          {paused = false, advancedPlayer2.stop()}
                        else
                          {
                            paused = true,
                            advancedPlayer.pause(),
                            audioPaused.loop('pacman_intermission.wav'),
                          },
                      },
                    ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
