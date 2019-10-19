import 'package:flutter/material.dart';
import 'package:dashed_container/dashed_container.dart';

import 'package:barcode_flutter/barcode_flutter.dart';
import 'package:responsive_container/responsive_container.dart';

import '../dashed_divider.dart';

class TicketsPage extends StatefulWidget {
  @override
  _TicketsPageState createState() => _TicketsPageState();
}

class _TicketsPageState extends State<TicketsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ResponsiveContainer(
          widthPercent: 100,
          heightPercent: 100,
          alignment: Alignment.center,
          padding: EdgeInsets.only(top: 80),
          child: Material(
            elevation: 15,
            borderRadius: BorderRadius.circular(15),
            shadowColor: Colors.yellow,
            child: DashedContainer(
              borderRadius: 15,
              blankLength: 5,
              dashColor: Color(0xfffe6600),
              dashedLength: 10,
              strokeWidth: 1.5,
              child: Container(
                width: 300,
                height: 450,
                child: ListView(
                  children: <Widget>[
                    Container(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Your Ticket",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Color(0xfffe6600),
                                fontSize: 25,
                                fontFamily: 'Verdana'),
                          ),
                        )),
                    Container(
                        alignment: Alignment.center,
                        height: 100,
                        color: Colors.black12,
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(
                                  'Event name here',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 25,
                                      fontFamily: 'Verdana'),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text('Serial Number here'),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text('Ticket type here',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Color(0xfffe6600),
                                        fontSize: 18,
                                        fontFamily: 'Verdana')),
                              ),
                            ],
                          ),
                        )),
                    Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Text(
                                'Numbers',
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 20,
                                    fontFamily: 'Verdana'),
                              ),
                              Text(
                                'Price',
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 20,
                                    fontFamily: 'Verdana'),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: Text(
                                '2 Tickets',
                                style: TextStyle(
                                    color: Color(0xfffe6600),
                                    fontSize: 20,
                                    fontFamily: 'Verdana'),
                              ),
                            ),
                            Text(
                              '220 EGP',
                              style: TextStyle(
                                  color: Color(0xfffe6600),
                                  fontSize: 20,
                                  fontFamily: 'Verdana'),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Text(
                              'Date',
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 20,
                                  fontFamily: 'Verdana'),
                            ),
                            Text(
                              'Time',
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 20,
                                  fontFamily: 'Verdana'),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Text(
                              '30-9-2019',
                              style: TextStyle(
                                  color: Color(0xfffe6600),
                                  fontSize: 20,
                                  fontFamily: 'Verdana'),
                            ),
                            Text(
                              '09:00am',
                              style: TextStyle(
                                  color: Color(0xfffe6600),
                                  fontSize: 20,
                                  fontFamily: 'Verdana'),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        DashedDivider(
                          height: 2,
                          color: Color(0xfffe6600),
                          width: 8,
                        ),
                        BarCodeImage(
                          data: "1234ABCD", // Code string. (required)
                          codeType: BarCodeType.Code93, // Code type (required)
                          lineWidth:
                          2.0, // width for a single black/white bar (default: 2.0)
                          barHeight:
                          90.0, // height for the entire widget (default: 100.0)
                          hasText: true,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
