import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:pacman/form.dart';
import 'package:pacman/homepage.dart';
import 'package:pacman/main.dart';
import 'package:pacman/maze_objects.dart';
import 'package:pacman/movables.dart';
import 'dart:async';
import 'dart:math';
import 'dart:ffi';

import 'package:flutter/rendering.dart';
import 'package:pacman/playerlist.dart';


class AddMaze extends StatefulWidget {
  @override
  _AddMazeState createState() => _AddMazeState();
}

class _AddMazeState extends State<AddMaze> {

  Widget generateCell(int index) {
   if(barriers.contains(index) || add.contains(index)) {
      return MazeCell(
        innerColor: Colors.blue[900],
        outerColor: Colors.blue[800],
        // child: Text(index.toString()),
      );
    } else {
      return Path(
        innerColor: Colors.black,
        outerColor: Colors.black,
      );
    }
  }

  void showReturnDialog(){
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
                title: Center(child: Text("Maze added successfully!")),
                actions: [
                  RaisedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
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
                      child: const Text('Okay'),
                    ),
                  ),
                ],
              ));
        });
  }
  void addMaze(){
    List<int> finalList = barriers + add;
    gameBarriers.add(finalList);
    showReturnDialog();
  }

  void modifyMaze(int index){
    if(barriers.contains(index)){
      return;
    }
    if(add.contains(index)){
      add.remove(index);
    }
    else{
      add.add(index);
    }
    setState(() {

    });
  }

  List<int> barriers = [0,1,2,3,4,5,6,7,8,9,10,21,32,43,54,65,76,87,98,109,120,131,142,153,164,175,174,173,172,171,170,169,168,167,166,165,154,143,132,121,110,99,88,77,66,55,44,33,22,11,0,1,2,3,4,5,6,7,8,9,10,11,21,22,32,33,43,44,54,55,65,66,76,77,88,98,99,109,110,120,121,131,132,142,143,153,154,164,165,166,167,168,169,170,171,172,173,174,175];
  List<int> add=[];
  static int numberInRow = 11;
  int numberOfSquares = numberInRow * 16;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            flex: (MediaQuery.of(context).size.height.toInt() * 0.0139).toInt(),
            child: GridView.builder(
                  padding: (MediaQuery.of(context).size.height.toInt() * 0.0139).toInt() > 10 ? EdgeInsets.only(top: 80) : EdgeInsets.only(top: 20),
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: numberOfSquares,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: numberInRow),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      child: generateCell(index),
                      onTap: (){
                        modifyMaze(index);
                      },
                    );
                  },
                ),
              ),
          Expanded(
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: (){
                      addMaze();
                    },
                    child: Text("ADD MAZE TO GAME",
                        style: TextStyle(color: Colors.white, fontSize: 23)),
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

