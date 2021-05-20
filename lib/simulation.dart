import 'package:flutter/material.dart';

import 'maze_objects.dart';
import 'movables.dart';

class SimulationScreen extends StatefulWidget {
  @override
  _SimulationScreenState createState() => _SimulationScreenState();
}

class _SimulationScreenState extends State<SimulationScreen> {

  List<int> barriers = [3,5,8];
  List<int> stones = [4,7];
  static int numberInRow = 11;
  int numberOfSquares = numberInRow * 16;
  int playerPosition = 0;
  int destination=100;
  String playerImage = 'lib/images/player.png';
  String imageDestination = 'lib/images/finish.png';
  List<int> path;

  void findPath(){
    
  }



  Widget generateCell(int index) {
    if (index == playerPosition) {
      return Movables(playerImage);
      }
    else if(index==destination){
      return Movables(imageDestination); // Destination is not really a movable lol
    }
    else if(barriers.contains(index)) {
      return MazeCell(
        innerColor: Colors.blue[900],
        outerColor: Colors.blue[800],
        // child: Text(index.toString()),
      );
    } else if(stones.contains(index)){
      return Path(
        innerColor: Colors.yellow,
        outerColor: Colors.black,
        // child: Text(index.toString()),
      );
    }
    else {
      return Path(
        innerColor: Colors.black,
        outerColor: Colors.black,
      );
    }
  }

  void startSimulation(){

  }

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
                return generateCell(index);
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
                      startSimulation();
                    },
                    child: Text("START SIMULATION",
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
