import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ticketawy/view/custom_widgets/CustomShowDialog.dart';
import 'package:ticketawy/view/home_pages/event_details_pages/dashed_divider.dart';
import '../login.dart';
import 'event_details_pages/about.dart';
import 'event_details_pages/location.dart';
import 'event_details_pages/schedule.dart';

import '../../globals.dart';
import '../../util.dart' as util;
import 'package:intl/intl.dart';

final int aboutPageIndex = 0;
final int locationPageIndex = 1;
final int schedulePageIndex = 2;

class EventDetails extends StatelessWidget {
  final Function onPreviousPagePressed;
  final Function onEventBooked;
  final Function onAllCategoriesPressed;

  EventDetails({@required this.onPreviousPagePressed, @required this.onEventBooked, @required this.onAllCategoriesPressed});

  @override
  Widget build(BuildContext context) {
    Globals.pagesStack.push(PagesIndices.eventPageIndex);

    return Scaffold(
      body: FutureBuilder(
        future: util.getEventDetails(Globals.eventId),
        builder: (context, snapshot){
          if(snapshot.hasData){
            return EventTabs(
              data: snapshot.data,
              onEventBooked: onEventBooked,
            );
          }
          return Container();
        },
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
                      Image.asset(
                        'assets/back.png',
                        width: 30,
                        height: 30,
                      ),
                      Text(
                        'Previous Page',
                        style: TextStyle(
                          color: Colors.white,fontFamily: 'MyriadPro',
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: onAllCategoriesPressed,
                child: Container(
                  padding: EdgeInsets.all(15),
                  color: Color(0xff4b3d7a),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Image.asset(
                        'assets/all_events.png',
                        width: 30,
                        height: 30,
                      ),
                      Text(
                        'All Categories',
                        style: TextStyle(
                          color: Colors.white,fontFamily: 'MyriadPro',
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EventTabs extends StatefulWidget {
  final Function onEventBooked;
  final Map data;

  EventTabs({@required this.onEventBooked, @required this.data});
  @override
  _EventTabsState createState() => _EventTabsState();
}

class _EventTabsState extends State<EventTabs> with TickerProviderStateMixin {
  int index = aboutPageIndex;

  TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(
      length: 3,
      vsync: this,
      initialIndex: index,
    )..addListener(() {
        setState(() {
          index = _tabController.index;
        });
      });
  }
//sghgjxgjd csdkjdvskj ksjhfksjdhf
  //Begin
  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: _width > 360?Platform.isIOS?6.0:10:8.0, bottom: _width > 360?Platform.isIOS?6.0:10:8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    height: 45,
                    color: Color(0xfff0f0f0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                index = aboutPageIndex;
                              });
                              _tabController.animateTo(index);
                            },
                            child: Text(
                              'About',
                              style: TextStyle(
                                fontSize: _width > 360?Platform.isIOS? 14:20:14,
                                fontFamily: 'Verdana',
                                color: index == aboutPageIndex
                                    ? Color(0xffff6600)
                                    : Color(0xff979797),
                              ),
                            ),
                          ),
                        ),
                        Image.asset(
                          'assets/seperator.png',
                          height: 10,
                          width: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                index = locationPageIndex;
                              });
                              _tabController.animateTo(index);
                            },
                            child: Text(
                              'Location',
                              style: TextStyle(
                                fontSize: _width > 360?Platform.isIOS? 14:20:14,
                                fontFamily: 'Verdana',
                                color: index == locationPageIndex
                                    ? Color(0xffff6600)
                                    : Color(0xff979797),
                              ),
                            ),
                          ),
                        ),
                        Image.asset(
                          'assets/seperator.png',
                          height: 10,
                          width: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                index = schedulePageIndex;
                              });
                              _tabController.animateTo(index);
                            },
                            child: Text(
                              'Schedule',
                              style: TextStyle(
                                fontSize: _width > 360?Platform.isIOS? 14:20:14,
                                fontFamily: 'Verdana',
                                color: index == schedulePageIndex
                                    ? Color(0xffff6600)
                                    : Color(0xff979797),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),




                // Buy Tickets Button
//                BuyTicket(),
                GestureDetector(
                  onTap: () {
                    if(Globals.skipped){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => Login()));
                    } else {
                      if(Globals.reservationOption == ReservationOptions.byTickets)
                        _showChooseTicketDialog(widget.onEventBooked);
                      else if(Globals.reservationOption == ReservationOptions.bySeats)
                        widget.onEventBooked();
                    }

                  },
                  child: Container(
                    height: 45,
                    color: Color(0xffff6600),
                    child: Padding(
                      padding: EdgeInsets.only(left: _width > 350?30:25,right: _width > 350?30:20,top: 15,bottom: 15),
                      child: Text(
                        Globals.reservationOption == ReservationOptions.byTickets? 'Buy Tickets' : '  Buy 20\$  ',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontFamily: 'MyriadPro'),
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: Platform.isIOS?10
                    :_width > 360? 25: 20
            ),
          ),
          Flexible(
            child: TabBarView(
              controller: _tabController,
              children: <Widget>[
                AboutPage(
                  imageUrl: 'http://40.85.116.121:8606/EventsLogo/${widget.data['logo']}',
                  eventName: widget.data['name'],
                  eventDescription: widget.data['content'],
                  endDate: widget.data['endDate'],
                  startDate: widget.data['startDate'],
                ),
                LocationPage(
                  mapUrl: widget.data['locationGmap'],
                  endDate: widget.data['endDate'],
                  startDate: widget.data['startDate'],
                ),
                SchedulePage(
                  scheduleList: widget.data['schedules'],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
// End
  _showChooseTicketDialog(Function onTicketChosen) {
    showDialog(
        context: context,
        builder: (context) {
          return CustomAlertDialog(
            titlePadding: EdgeInsets.all(0),
            contentPadding: EdgeInsets.all(0),
            content: Container(
              width: 400.0,
              height: 400.0,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(33.0)),
              ),
              child: ChooseTicket(
                onTicketChosen: onTicketChosen,
              ),
            ),
          );
        });
  }
}

class ChooseTicket extends StatefulWidget {

  final Function onTicketChosen;

  ChooseTicket({@required this.onTicketChosen});
  @override
  _ChooseTicketState createState() => _ChooseTicketState();
}

class _ChooseTicketState extends State<ChooseTicket> {
  Map _map = {
    'Class A': 120,
    'Class B': 80,
    'Class C': 50,
  };

  static const platform = const MethodChannel('fawry');

  @override
  Widget build(BuildContext context) {

    return ListView(
      children: <Widget>[

        // The logo
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            'assets/logo.png',
            width: 60,
            height: 82,
          ),
        ),

        // Choose Ticket title
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Choose tickets',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 23,
              fontFamily: 'GeometriqueSans',
              color: Color(0xff878787)
            ),
          ),
        ),

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(_map.keys.toList().length, (index) {
              return Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DashedDivider(),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 16,left: 12),
                          child: Text('${_map.keys.toList()[index]}',style: TextStyle(fontSize: 20,
                              fontFamily: 'GeometriqueSans',
                              color: Color(0xff878787)),),
                        ),
                        Container(
                          width: 70,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Color(0xffff6600),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 8.0,
                              right: 8.0,
                              top: 3.0,
                              bottom: 3.0,
                            ),
                            child: Text(
                              '${_map[_map.keys.toList()[index]]}\$',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Verdana',
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          child: TicketQuantity(),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }),
          ),
        ),

        // Buy Button
        Padding(
          padding: const EdgeInsets.only(
            right: 70,
            left: 70,
          ),
          child: ListTile(
            onTap: () {
              platform.invokeMethod('initFawry');
              Navigator.of(context).pop();
            },
            title: Container(
              decoration: BoxDecoration(
                color: Color(0xfffe6700),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Buy',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white,
                    fontFamily: 'Verdana',
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}


// Ticket Quantity dropdown.
class TicketQuantity extends StatefulWidget {
  @override
  _TicketQuantityState createState() => _TicketQuantityState();
}

class _TicketQuantityState extends State<TicketQuantity> {
  int _current = 0;
  @override
  Widget build(BuildContext context) {
    return Row(

      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[

        //decrement
        GestureDetector(
          onTap: (){
            if(_current > 0){
              setState(() {
                _current--;
              });
            }

          },
          child: Icon(Icons.remove),
        ),

        //Ticket Quantity
        Container(
            width: 30,
            child:  Text('$_current', textAlign: TextAlign.center, style: TextStyle(fontFamily: 'Verdana',),)

        ),

        // increment
        GestureDetector(
          onTap: (){
            setState(() {
              _current++;
            });
          },
          child: Icon(Icons.add),
        ),
      ],
    );
  }
}


