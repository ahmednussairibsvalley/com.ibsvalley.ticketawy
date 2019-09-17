import 'package:flutter/material.dart';

class SchedulePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 80, left: 80, top: 20, bottom: 20),
      child: Material(
        elevation: 10,
        shadowColor: Colors.black,
        child: Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('* First Day'),
              Text('* Second Day'),
            ],
          ),
        ),
      ),
    );
  }
}
