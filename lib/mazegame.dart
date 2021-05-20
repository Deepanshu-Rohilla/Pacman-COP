import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:pacman/maze_objects.dart';
import 'package:pacman/movables.dart';
import 'dart:async';
import 'dart:math';
import 'dart:ffi';

import 'package:flutter/rendering.dart';
import 'package:pacman/playerlist.dart';

import 'form.dart';
import 'main.dart';

class MazeGameScreen extends StatefulWidget {
  int numberOfGhosts;
  int movementSpeed;
  int numberOfPlayers;
  int playerNumber;
  int mazeDifficulty;
  MazeGameScreen(this.numberOfGhosts, this.movementSpeed, this.numberOfPlayers, this.playerNumber,this.mazeDifficulty);
  @override
  _MazeGameScreenState createState() => _MazeGameScreenState();
}

class _MazeGameScreenState extends State<MazeGameScreen> {

  static int numberInRow = 11;
  int numberOfSquares = numberInRow * 16;
  int playerPosition = numberInRow  + 1;
  String playerDirection = 'right';
  String playerImage = 'lib/images/player.png';
  List<int> positionOfMovables = [ numberInRow * 2 - 2, numberInRow * 9 - 1, numberInRow * 11 - 2];
  List<String> directionOfMovement = ['left', 'left', 'down'];
  List<String> imagePath = ['lib/images/red.png', 'lib/images/yellow.png', 'lib/images/cyan.png'];
  int destination = numberInRow * 15 - 2;
  String imageDestination = 'lib/images/finish.png';
  bool win = false;
  // Index 0 : Pacman (Player)
  // Index 1 : Blinky (Red)
  // Index 2 : Clyde (Yellow)
  // Index 3 : Inky (Green/Cyan)
  bool preGame = true;
  var controller;
  int score = 0;
  bool paused = false;
  AudioPlayer advancedPlayer = new AudioPlayer();
  AudioPlayer advancedPlayer2 = new AudioPlayer();
  AudioCache audioMunch = new AudioCache(prefix: 'assets/');
  AudioCache audioDeath = new AudioCache(prefix: 'assets/');
  AudioCache audioPaused = new AudioCache(prefix: 'assets/');
  List<int> barriers;

  @override
  void initState() {
    // TODO: implement initState
    var rand = Random();
    int maze = rand.nextInt(4);
    barriers = gameBarriers[ (widget.mazeDifficulty-1)*5+ maze];

  }

  @override
  void dispose() {
    advancedPlayer.stop();
    advancedPlayer2.stop();
    super.dispose();
  }


  void gameOverDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
              onWillPop: () {
                Navigator.pop(context);
                Navigator.pop(context);
                return Future.value(false);
              },
          child: AlertDialog(
            title: Center(child:Text( win ? 'You won! and the time taken is $score seconds' : 'You lose! and the time taken is $score seconds')),
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
                  child: const Text('Try Again'),
                ),
              ),
              RaisedButton(
                onPressed: () {
                  setState(() {
                    scores[widget.playerNumber] = score;
                  });
                  resetGame();
                  setState(() {

                  });
                  Navigator.pop(context);
                  Navigator.pop(context);
                  if(widget.numberOfPlayers>1){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => PlayerList(widget.numberOfGhosts, widget.movementSpeed, widget.numberOfPlayers, false,widget.mazeDifficulty)));
                  }
                  else{
                    Navigator.push(context, MaterialPageRoute(builder: (context) => GameForm(false)));
                  }


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
                  child: const Text('Submit Score'),
                ),
              )
            ],
          ));
        });

  }

  void resetGame() {
//    audioInGame.loop('pacman_beginning.wav');
    setState(() {
      playerPosition = numberInRow + 1;
      for(int i=0;i<widget.numberOfGhosts;i++){
        if(i==0){
          positionOfMovables[0] = numberInRow * 2 - 2;
        }
        else if(i==1){
          positionOfMovables[1] = numberInRow * 9 - 1;
        }
        else{
          positionOfMovables[2] = numberInRow * 11 - 2;
        }
      }
      paused = false;
      preGame = false;
      win = false;
      playerDirection = "right";
      score = 0;
    });
    Navigator.pop(context);

  }

  Widget generateCell(int index) {
    if (index == playerPosition) {
      return Movables(playerImage);
    } else if (index == positionOfMovables[0] && widget.numberOfGhosts>0) {
      return Movables(imagePath[0]);
    } else if (index == positionOfMovables[1] && widget.numberOfGhosts>1) {
      return Movables(imagePath[1]);
    } else if (index == positionOfMovables[2] && widget.numberOfGhosts>2) {
      return Movables(imagePath[2]);
    } else if (barriers.contains(index)) {
      return MazeCell(
        innerColor: Colors.blue[900],
        outerColor: Colors.blue[800],
        // child: Text(index.toString()),
      );
    } else if (index==destination){
      return Movables(imageDestination);
    }
    else {
      return Path(
        innerColor: Colors.black,
        outerColor: Colors.black,
      );
    }
  }

  void moveGhost(int index){
    String direction = directionOfMovement[index];
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

  void movePlayer(){
    switch (playerDirection) {
      case 'left':
        if (!barriers.contains(playerPosition - 1)) {
          setState(() {
            playerPosition--;
          });
        }
        break;
      case 'right':
        if (!barriers.contains(playerPosition + 1)) {
          setState(() {
            playerPosition++;
          });
        }
        break;
      case 'up':
        if (!barriers.contains(playerPosition - numberInRow)) {
          setState(() {
            playerPosition -= numberInRow;
          });
        }
        break;
      case 'down':
        if (!barriers.contains(playerPosition + numberInRow)) {
          setState(() {
            playerPosition += numberInRow;
          });
        }
        break;
    }
  }



  void playGame() {
    if (preGame) {
//      audioInGame.loop('pacman_beginning.wav');
      preGame = false;
      Timer.periodic(Duration(milliseconds: 10), (timer) {
        if (paused) {
        } else {
          advancedPlayer.resume();
        }

        if (positionOfMovables.sublist(0,widget.numberOfGhosts).contains(playerPosition) || playerPosition==destination) {
          if(playerPosition==destination){
            advancedPlayer.stop();
            setState(() {
              playerPosition = -1;
              win = true;
            });

            gameOverDialog();
          }
          else{
            advancedPlayer.stop();
            audioDeath.play('pacman_death.wav');
            setState(() {
              playerPosition = -1;
              win = false;
            });
            gameOverDialog();

          }

        }
      });
      switch(widget.movementSpeed){
        case 1:
          Timer.periodic(Duration(milliseconds: 240), (timer) {
            if (!paused) {
              for(int i=0;i<widget.numberOfGhosts;i++){
                moveGhost(i);
              }
            }
          });
          break;
        case 2:
          Timer.periodic(Duration(milliseconds: 190), (timer) {
            if (!paused) {
              for(int i=0;i<widget.numberOfGhosts;i++){
                moveGhost(i);
              }
            }
          });
          break;
        case 3:
          Timer.periodic(Duration(milliseconds: 170), (timer) {
            if (!paused) {
              for(int i=0;i<widget.numberOfGhosts;i++){
                moveGhost(i);
              }
            }
          });
          break;
        default:
          Timer.periodic(Duration(milliseconds: 190), (timer) {
            if (!paused) {
              for(int i=0;i<widget.numberOfGhosts;i++){
                moveGhost(i);
              }
            }
          });

      }
      Timer.periodic(Duration(milliseconds: 1000), (timer) {
        score++;
      });

      Timer.periodic(Duration(milliseconds: 170), (timer) {

        movePlayer();
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
                  playerDirection = "down";
                } else if (details.delta.dy < 0) {
                  playerDirection = "up";
                }
                // print(direction);
              },
              onHorizontalDragUpdate: (details) {
                if (details.delta.dx > 0) {
                  playerDirection = "right";
                } else if (details.delta.dx < 0) {
                  playerDirection = "left";
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
                    " Time : " + (score).toString(),
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
