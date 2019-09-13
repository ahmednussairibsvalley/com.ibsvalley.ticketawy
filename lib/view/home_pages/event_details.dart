import 'package:flutter/material.dart';
import 'package:ticketawy/view/home_pages/event_details_pages/about.dart';
import 'package:ticketawy/view/home_pages/event_details_pages/location.dart';
import 'package:ticketawy/view/home_pages/event_details_pages/schedule.dart';

final int aboutPageIndex = 0;
final int locationPageIndex = 1;
final int schedulePageIndex = 2;

class EventDetails extends StatefulWidget {

  final Function onPreviousPagePressed;

  EventDetails({@required this.onPreviousPagePressed});

  @override
  _EventDetailsState createState() => _EventDetailsState(
    onPreviousPagePressed: onPreviousPagePressed,
  );
}

class _EventDetailsState extends State<EventDetails> {
  final Function onPreviousPagePressed;

  int index = aboutPageIndex;

  _EventDetailsState({@required this.onPreviousPagePressed});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    height: 50,
                    color: Color(0xfff0f0f0),
                    child:  Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: (){
                              setState(() {
                                index = aboutPageIndex;
                              });
                            },
                            child: Text('About',
                              style: TextStyle(
                                color: index == aboutPageIndex? Color(0xffff6600): Color(0xff979797),
                              ),
                            ),
                          ),
                        ),
                        Image.asset('assets/seperator.png', height: 10, width: 10,),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: (){
                              setState(() {
                                index = locationPageIndex;
                              });
                            },
                            child: Text('Location',
                              style: TextStyle(
                                color: index == locationPageIndex? Color(0xffff6600): Color(0xff979797),
                              ),
                            ),
                          ),
                        ),
                        Image.asset('assets/seperator.png', height: 10, width: 10,),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: (){
                              setState(() {
                                index = schedulePageIndex;
                              });
                            },
                            child: Text('Schedule',
                              style: TextStyle(
                                color: index == schedulePageIndex? Color(0xffff6600): Color(0xff979797),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  color: Color(0xffff6600),
                  child: Padding(
                    padding: EdgeInsets.all(15),
                    child: Text('Buy Tickets',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          index == aboutPageIndex? AboutPage():
          index == locationPageIndex ? LocationPage():
          index == schedulePageIndex ? SchedulePage():
          Container(),
        ],
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

