import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool switchValue = true, checkBoxValue = true;
  double sliderValue = 0.5;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: Container(
      padding: const EdgeInsets.all(16),
      child: Material(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Preview',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Switch(
                    activeColor: Theme.of(context).accentColor,
                    value: switchValue,
                    onChanged: (_) {
                      setState(() {
                        switchValue = !switchValue;
                      });
                    }),
                Radio(
                  activeColor: Theme.of(context).accentColor,
                  groupValue: 0,
                  value: 0,
                  onChanged: (_) {},
                ),
                Checkbox(
                  activeColor: Theme.of(context).accentColor,
                  value: checkBoxValue,
                  onChanged: (_) {
                    setState(() {
                      checkBoxValue = !checkBoxValue;
                    });
                  },
                ),
                RaisedButton(
                  color: Theme.of(context).accentColor,
                  child: Text(
                    'BUTTON',
                  ),
                  onPressed: () {},
                )
              ],
            ),
            Slider(
              activeColor: Theme.of(context).accentColor,
              onChanged: (double newValue) {
                setState(() {
                  sliderValue = newValue;
                });
              },
              min: 0,
              max: 1,
              value: sliderValue,
            ),
          ],
        ),
      ),
    ),
    );
  }
}
