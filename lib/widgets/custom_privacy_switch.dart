import 'package:flutter/material.dart';

bool? isSwitchedGlobal;

class CustomPrivacySwitch extends StatefulWidget {
  @override
  SwitchClass createState() => SwitchClass();
}

class SwitchClass extends State {
  bool isSwitchedGlobal = false;
  var textValue = 'Privacy OFF';

  void toggleSwitch(bool value) {
    if (isSwitchedGlobal == false) {
      setState(() {
        isSwitchedGlobal = true;
        textValue = 'Privacy ON';
      });
      print('Switch Button is ON');
    } else {
      setState(() {
        isSwitchedGlobal = false;
        textValue = 'Privacy OFF';
      });
      print('Switch Button is OFF');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Transform.scale(
          scale: 1,
          child: Switch(
            onChanged: toggleSwitch,
            value: isSwitchedGlobal,
            activeColor: Colors.blue,
            activeTrackColor: Colors.yellow,
            inactiveThumbColor: Colors.redAccent,
            inactiveTrackColor: Colors.orange,
          ),
        ),
        Text(
          '$textValue',
          style: TextStyle(fontSize: 15),
        ),
      ],
    );
  }
}
