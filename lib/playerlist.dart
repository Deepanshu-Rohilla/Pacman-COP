import 'package:flutter/material.dart';
import 'main.dart';
import 'gamescreen.dart';
import 'mazegame.dart';

class PlayerList extends StatefulWidget {
  int numberOfGhosts;
  int movementSpeed;
  int numberOfPlayers;
  bool pacman;
  int mazeDiffculty;
  PlayerList(this.numberOfGhosts, this.movementSpeed, this.numberOfPlayers, this.pacman, this.mazeDiffculty);
  @override
  _PlayerListState createState() => _PlayerListState();
}

class _PlayerListState extends State<PlayerList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Players list'),
      ),
      body: ListView.builder(
          itemCount: widget.numberOfPlayers,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              leading: Icon(Icons.person),
              title: Text('Player ${index + 1}'),
              subtitle: Text(gamePlayed[index] ? 'Played' : 'Not Played'),
              trailing: Text('Score: ${scores[index]}'),
              onTap: () {
                setState(() {
                  gamePlayed[index]=true;
                });
                Navigator.push(context, MaterialPageRoute(builder: (context) => widget.pacman ? GameScreen(widget.numberOfGhosts, widget.movementSpeed, widget.numberOfPlayers,index,widget.mazeDiffculty) : MazeGameScreen(widget.numberOfGhosts, widget.movementSpeed, widget.numberOfPlayers,index,widget.mazeDiffculty)));
              },
            );
          }),
    );
  }
}