import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:pacman/developers.dart';
import 'package:pacman/gamescreen.dart';
import 'package:pacman/mazegame_form.dart';
import 'package:pacman/pacman_form.dart';

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

      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 40, right: 40),
            child: GestureDetector(
              child: Text('Pacman',
//              style: TextStyle(
//                fontFamily: 'caveat',
//                fontSize: 40,
//                fontWeight: FontWeight.bold,
//              ),
              style: GoogleFonts.caveat(
                textStyle: Theme.of(context).textTheme.headline4,
                fontSize: 100,
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.italic,
                color: Colors.white,
              ),
              ),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => PacmanForm()));
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 40, right: 40),
            child: GestureDetector(
              child: Text('Maze Game',
                  style: GoogleFonts.caveat(
                    textStyle: Theme.of(context).textTheme.headline4,
                    fontSize: 60,
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.italic,
                    color: Colors.white,
                  ),),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => MazeGameForm()));
              },
            ),
          ),
          GestureDetector(
            child: Text('How to play',
              style: GoogleFonts.caveat(
                textStyle: Theme.of(context).textTheme.headline4,
                fontSize: 50,
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.italic,
                color: Colors.white,
              ),),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => GameScreen(0,0)));
            },
          ),
          GestureDetector(
            child: Text('About the developers',
              style: GoogleFonts.caveat(
                textStyle: Theme.of(context).textTheme.headline4,
                fontSize: 40,
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.italic,
                color: Colors.white,
              ),),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => Developers()));
            },
          ),

        ],
      ),
    );
  }
}
