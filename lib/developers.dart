import 'package:flutter/material.dart';

class Developers extends StatefulWidget {
  @override
  _DevelopersState createState() => _DevelopersState();
}

class _DevelopersState extends State<Developers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About the developers'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 100, bottom: 100, left: 50, right: 50),
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('This app is developed by two students of IIT Delhi as a project of the COP290 course'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Deepanshu Rohilla'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Prashant Mishra'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('https://github.com/Deepanshu-Rohilla/Pacman-COP'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
