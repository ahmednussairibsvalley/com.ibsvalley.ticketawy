import 'package:flutter/material.dart';

import 'dashed_divider.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, right: 50, left: 50),
          child: Material(
            elevation: 10,
            shadowColor: Colors.black,
            child: Stack(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset('assets/event_image.png',
                        fit: BoxFit.fill,
                      ),
                    ),
                    Text('Event Name Here',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xffff6600),fontFamily: 'Verdana'
                      ),
                    ),
                    Text('Event Description',style: TextStyle(fontFamily: 'Verdana',color: Color(0xff656565)),),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DashedDivider(
                        height: 1,
                        width: 5,
                        color: Color(0xffb8b8b8),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset('assets/event_time.png', width: 25, height: 25,),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text('Starts at:',style: TextStyle(fontFamily: 'Verdana',color: Color(0xff656565))),
                                Text('09:00 am',
                                  style: TextStyle(
                                    color: Color(0xffff6600),
                                    fontFamily: 'Verdana'
                                  ),
                                ),
                              ],
                            ),
                          ],

                        ),
                        Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset('assets/event_duration.png', width: 25, height: 25,),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text('Duration:',style: TextStyle(fontFamily: 'Verdana',color: Color(0xff656565))),
                                Text('2 Days',
                                  style: TextStyle(
                                    color: Color(0xffff6600),
                                    fontFamily: 'Verdana'
                                  ),
                                ),
                              ],
                            ),
                          ],

                        ),
                      ],
                    )
                  ],
                ),
                Positioned(
                  bottom: 90.0, left: 70.0, right: 70.0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xffff6600),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text('30-09-2019',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
