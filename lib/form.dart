import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pacman/gamescreen.dart';
import 'package:pacman/playerlist.dart';

import 'main.dart';
import 'mazegame.dart';

class GameForm extends StatefulWidget {
  bool pacman;
  GameForm(this.pacman);

  @override
  _GameFormState createState() => _GameFormState();
}

class _GameFormState extends State<GameForm> {


  final _formKey = GlobalKey<FormState>();
  int numberOfGhosts=-1;
  int movementSpeed=-1;
  int numberOfPlayers=1;
  int mazeDifficulty=-1;
  bool validInteger=true;
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    return  Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: h/6),
            Text('Set Difficulty',
              style: GoogleFonts.caveat(
                textStyle: Theme.of(context).textTheme.headline4,
                fontSize: 60,
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.italic,
                color: Colors.white,
              ),),


            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 100, left: 50, right: 50),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Choose number of ghosts',
                        style: GoogleFonts.caveat(
                          textStyle: Theme.of(context).textTheme.headline4,
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.italic,
                          color: Colors.white,
                        ),),
                      ListTile(
                        title:  Text( widget.pacman ? '1 (Easy)' : '0 (Easy)'),
                        leading: Radio(
                          value: widget.pacman ? 1 : 0,
                          groupValue: numberOfGhosts,
                          onChanged: (int value) {
                            setState(() {
                              numberOfGhosts = value;
                            });
                          },
                        ),
                      ),
                      ListTile(
                        title: const Text('2 (Medium)'),
                        leading: Radio(
                          value: 2,
                          groupValue: numberOfGhosts,
                          onChanged: (int value) {
                            setState(() {
                              numberOfGhosts = value;
                            });
                          },
                        ),
                      ),
                      ListTile(
                        title: const Text('3 (Hard)'),
                        leading: Radio(
                          value: 3,
                          groupValue: numberOfGhosts,
                          onChanged: (int value) {
                            setState(() {
                              numberOfGhosts = value;
                            });
                          },
                        ),
                      ),
                      Text('Choose movement speed',
                        style: GoogleFonts.caveat(
                          textStyle: Theme.of(context).textTheme.headline4,
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.italic,
                          color: Colors.white,
                        ),),
                      ListTile(
                        title: const Text('Slow (Easy)'),
                        leading: Radio(
                          value: 1,
                          groupValue: movementSpeed,
                          onChanged: (int value) {
                            setState(() {
                              movementSpeed = value;
                            });
                          },
                        ),
                      ),
                      ListTile(
                        title: const Text('Intermediate (Medium)'),
                        leading: Radio(
                          value: 2,
                          groupValue: movementSpeed,
                          onChanged: (int value) {
                            setState(() {
                              movementSpeed = value;
                            });
                          },
                        ),
                      ),
                      ListTile(
                        title: const Text('Fast (Hard)'),
                        leading: Radio(
                          value: 3,
                          groupValue: movementSpeed,
                          onChanged: (int value) {
                            setState(() {
                              movementSpeed = value;
                            });
                          },
                        ),
                      ),
                      Text('Choose maze difficulty',
                        style: GoogleFonts.caveat(
                          textStyle: Theme.of(context).textTheme.headline4,
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.italic,
                          color: Colors.white,
                        ),),
                      ListTile(
                        title: const Text('Easy'),
                        leading: Radio(
                          value: 1,
                          groupValue: mazeDifficulty,
                          onChanged: (int value) {
                            setState(() {
                              mazeDifficulty = value;
                            });
                          },
                        ),
                      ),
                      ListTile(
                        title: const Text('Medium'),
                        leading: Radio(
                          value: 2,
                          groupValue: mazeDifficulty,
                          onChanged: (int value) {
                            setState(() {
                              mazeDifficulty = value;
                            });
                          },
                        ),
                      ),
                      ListTile(
                        title: const Text('Hard'),
                        leading: Radio(
                          value: 3,
                          groupValue: mazeDifficulty,
                          onChanged: (int value) {
                            setState(() {
                              mazeDifficulty = value;
                            });
                          },
                        ),
                      ),
                      Text('Enter the number of players',
                        style: GoogleFonts.caveat(
                          textStyle: Theme.of(context).textTheme.headline4,
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.italic,
                          color: Colors.white,
                        ),),
                      TextFormField(
                        initialValue: '1',
                        onChanged: (String value){
                          setState(() {
                            try{
                              print('here');
                              numberOfPlayers = int.parse(value);
                              validInteger = true;
                              print('here1');
                              print("wowo his okay value is ${int.parse(value)}");
                              print('here2');
                            }catch(e){
                              validInteger = false;
                              print("wowo his is" + value);
                            }

                          });
                        },
                        // The validator receives the text that the user has entered.
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState.validate()==null) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(content: Text('Processing Data')));
                            }
                          },
                          child: GestureDetector(
                            child : Text('Submit'),
                            onTap: (){
                              if(numberOfGhosts==-1 || movementSpeed==-1 || !validInteger){
                                showDialog(context: context, builder: (BuildContext context){
                                  return AlertDialog(
                                    title: Center(child: Text( numberOfGhosts==-1 ?"Please enter the number of ghosts!" :
                                    validInteger ? "Please enter the movement speed!" :
                                    "Please enter valid integer value")),
                                    actions: [
                                      RaisedButton(
                                        onPressed: () {
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
                                          child: const Text('Go Back'),
                                        ),
                                      )
                                    ],
                                  );
                                });
                              }
                              else{
                                print(numberOfGhosts);
                                print(movementSpeed);
                                scores = [];
                                gamePlayed = [];
                                for (int i = 0; i < numberOfPlayers; i++) {
                                  scores.add(0);
                                  gamePlayed.add(false);
                                }
                                if(numberOfPlayers>1){

                                  Navigator.push(context, MaterialPageRoute(builder: (context) => PlayerList(numberOfGhosts, movementSpeed, numberOfPlayers, widget.pacman,mazeDifficulty)));
                                }
                                else{
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => widget.pacman ?  GameScreen(numberOfGhosts, movementSpeed,numberOfPlayers,0,mazeDifficulty)
                                      : MazeGameScreen(numberOfGhosts,movementSpeed,numberOfPlayers,0,mazeDifficulty)
                                  )
                                  );
                                }


                              }

                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
