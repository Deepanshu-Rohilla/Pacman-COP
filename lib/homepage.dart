import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:pacman/add_maze.dart';
import 'package:pacman/camera.dart';
import 'package:pacman/developers.dart';
import 'package:pacman/simulation.dart';
import 'form.dart';

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
              child: Text(
                'Pacman',
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
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => GameForm(true)));
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 40, right: 40),
            child: GestureDetector(
              child: Text(
                'Maze Game',
                style: GoogleFonts.caveat(
                  textStyle: Theme.of(context).textTheme.headline4,
                  fontSize: 60,
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.italic,
                  color: Colors.white,
                ),
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => GameForm(false)));
              },
            ),
          ),
          GestureDetector(
            child: Text(
              'Add maze',
              style: GoogleFonts.caveat(
                textStyle: Theme.of(context).textTheme.headline4,
                fontSize: 50,
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.italic,
                color: Colors.white,
              ),
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => AddMaze()));
            },
          ),
          GestureDetector(
            child: Text(
              'Add Image',
              style: GoogleFonts.caveat(
                textStyle: Theme.of(context).textTheme.headline4,
                fontSize: 50,
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.italic,
                color: Colors.white,
              ),
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => CameraScreen()));
            },
          ),
          GestureDetector(
            child: Text(
              'Maze simulation',
              style: GoogleFonts.caveat(
                textStyle: Theme.of(context).textTheme.headline4,
                fontSize: 50,
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.italic,
                color: Colors.white,
              ),
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => SimulationScreen()));
            },
          ),
          GestureDetector(
            child: Text(
              'About the developers',
              style: GoogleFonts.caveat(
                textStyle: Theme.of(context).textTheme.headline4,
                fontSize: 40,
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.italic,
                color: Colors.white,
              ),
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => Developers()));
            },
          ),
        ],
      ),
    );
  }
}
