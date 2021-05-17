import "package:flutter/material.dart";
import 'package:pacman/gamescreen.dart';

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
          SizedBox(
            width: w,
            height: h/8,
          ),
          GestureDetector(
            child: Text('New Game',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => GameScreen()));
            },
          ),

          SizedBox(
            width: w,
            height: h/8,
          ),
          GestureDetector(
            child: Text('How to play',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => GameScreen()));
            },
          ),
          SizedBox(
            width: w,
            height: h/8,
          ),
          GestureDetector(
            child: Text('About the developers',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => GameScreen()));
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
