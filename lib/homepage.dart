import "package:flutter/material.dart";
import 'package:pacman/gamescreen.dart';
import 'package:pacman/mazegame_form.dart';
import 'package:pacman/pacman_form.dart';
import 'package:pacman/settings.dart.dart';

import 'mazegame.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Pacman'),
        actions: [
          IconButton(
              icon: Icon(Icons.settings),
              tooltip: 'Settings',
              onPressed: () {
                return Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return Settings();
                }));
              })
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            width: w,
            height: h/20,
          ),
          GestureDetector(
            child: Text('Pacman',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => PacmanForm()));
            },
          ),

          SizedBox(
            width: w,
            height: h/20,
          ),
          GestureDetector(
            child: Text('Maze Game',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => MazeGameForm()));
            },
          ),
          GestureDetector(
            child: Text('How to play',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => GameScreen(0,0)));
            },
          ),
          SizedBox(
            width: w,
            height: h/20,
          ),
          GestureDetector(
            child: Text('About the developers',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => GameScreen(0,0)));
            },
          ),
          SizedBox(
            width: w,
            height: h/8,
          ),
        ],
      ),
    );
  }
}
