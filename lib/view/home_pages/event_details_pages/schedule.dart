import 'package:flutter/material.dart';
import 'package:ticketawy/view/dashed_divider.dart';

class SchedulePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final _width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(right: _width> 360?80:60, left: _width> 360?80:60, top: _width> 360?40:5, bottom: _width> 360?40:20),
      child: Material(
        elevation: 10,
        shadowColor: Colors.black,
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('* First Day',
                    style: TextStyle(
                      color: Color(0xffff6600),
                      fontFamily: 'MyriadPro',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xff4b3d7a),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8.0, left: 8.0, top: 3.0, bottom: 3.0,),
                          child: Text('09:00 am',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Verdana',
                            ),
                          ),
                        ),
                      ),
                      Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                        style: TextStyle(
                          fontFamily: 'Verdana',
                          color: Color(0xff656565)
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16, top: 14, bottom: 13),
                  child: DashedDivider(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
