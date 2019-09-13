import 'package:flutter/material.dart';

class FaqPage extends StatefulWidget {
  final Function onPreviousPagePressed;
  FaqPage({@required this.onPreviousPagePressed});
  @override
  _FaqPageState createState() => _FaqPageState(
    onPreviousPagePressed: onPreviousPagePressed,
  );
}

class _FaqPageState extends State<FaqPage> {
  final Function onPreviousPagePressed;

  _FaqPageState({@required this.onPreviousPagePressed});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('FAQ'),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: GestureDetector(
                onTap: onPreviousPagePressed,
                child: Container(
                  padding: EdgeInsets.all(15),
                  color: Color(0xfffe6700),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Image.asset('assets/back.png', width: 30, height: 30,),
                      Text(
                        'Previous Page',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(15),
                color: Colors.purple,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Image.asset('assets/all_events.png', width: 30, height: 30,),
                    Text(
                      'All Events',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

