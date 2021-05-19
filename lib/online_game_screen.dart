import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class CustomData extends StatefulWidget {
  CustomData({this.app});
  final FirebaseApp app;

  @override
  _CustomDataState createState() => _CustomDataState();
}

class _CustomDataState extends State<CustomData> {

  final referenceDatabase = FirebaseDatabase.instance;
  final movieName = 'MovieTitle';
  final movieController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final ref = referenceDatabase.reference();
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              movieName,
              textAlign: TextAlign.center,
            ),
            TextField(
              controller:movieController ,
            ),
            FlatButton(
              child: Text('Save movie'),
              onPressed: (){
                print('here');
                ref.child('Movies').push().child(movieName).set(movieController.text).asStream();
                print('her1e');
                movieController.clear();
              },
            )
          ],
        ),
      ),
    );
  }
}
