import 'dart:io';

import 'package:flutter/material.dart';

import 'form.dart';
import 'main.dart';

class PreviewImage extends StatefulWidget {
  String path;
  PreviewImage(this.path);
  @override
  _PreviewImageState createState() => _PreviewImageState();
}

class _PreviewImageState extends State<PreviewImage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Preview Image'),
      ),
      body: WillPopScope(
          onWillPop: () {
            Navigator.pop(context);
            Navigator.pop(context);
            return Future.value(false);
          },
          child: AlertDialog(
            backgroundColor: Colors.black,
            title: Center(child: Image.file(File(widget.path))),
            actions: [
              RaisedButton(
                onPressed: () {
                  customImage = true;
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => GameForm(true)));
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
                  child: const Text('Use in pacman'),
                ),
              ),
              RaisedButton(
                onPressed: () {
                  customImage = true;
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => GameForm(false)));
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
                  child: const Text('Use in maze'),
                ),
              )
            ],
          )),
    );
  }
}
