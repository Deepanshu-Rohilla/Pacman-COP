import 'package:flutter/material.dart';
import 'package:pacman/gamescreen.dart';

class PacmanForm extends StatefulWidget {

  @override
  _PacmanFormState createState() => _PacmanFormState();
}

class _PacmanFormState extends State<PacmanForm> {


  final _formKey = GlobalKey<FormState>();
  int numberOfGhosts=-1;
  int movementSpeed=-1;
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    return  Scaffold(
      body: Column(
        children: [
          SizedBox(height: h/6),
            Text('Set Difficulty',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
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
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),),
                    ListTile(
                      title: const Text('1 (Easy)'),
                      leading: Radio(
                        value: 1,
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
                      title: const Text('4 (Hard)'),
                      leading: Radio(
                        value: 4,
                        groupValue: numberOfGhosts,
                        onChanged: (int value) {
                          setState(() {
                            numberOfGhosts = value;
                          });
                        },
                      ),
                    ),
                    Text('Choose movement speed',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),),
                    ListTile(
                      title: const Text('Slow (Easy)'),
                      leading: Radio(
                        value: 1,
                        groupValue: movementSpeed,
                        onChanged: (int value) {
                          setState(() {
                            numberOfGhosts = value;
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
                        value: 4,
                        groupValue: movementSpeed,
                        onChanged: (int value) {
                          setState(() {
                            movementSpeed = value;
                          });
                        },
                      ),
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
                             if(numberOfGhosts==-1 || movementSpeed==-1){
                               showDialog(context: context, builder: (BuildContext context){
                                 return AlertDialog(
                                   title: Center(child: Text("Please enter the difficulty!")),
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
                               Navigator.push(context, MaterialPageRoute(builder: (context) => GameScreen(numberOfGhosts, movementSpeed)));
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
    );
  }
}