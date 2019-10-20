import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ticketawy/view/custom_widgets/CustomShowDialog.dart';
import 'package:ticketawy/view/home_pages/event_details_pages/dashed_divider.dart';
import 'package:responsive_container/responsive_container.dart';

import '../login.dart';
import 'event_details_pages/about.dart';
import 'event_details_pages/location.dart';
import 'event_details_pages/schedule.dart';

import '../../globals.dart';
import '../../util.dart' as util;

final int aboutPageIndex = 0;
final int locationPageIndex = 1;
final int schedulePageIndex = 2;

List orderTickets = [];

class EventDetails extends StatelessWidget {
  final Function onPreviousPagePressed;
  final Function onEventBooked;
  final Function onAllCategoriesPressed;
  final Function onWillPop;

  EventDetails(
      {@required this.onPreviousPagePressed,
      @required this.onEventBooked,
      @required this.onAllCategoriesPressed,
      @required this.onWillPop,});


  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: () async {
        onWillPop();
        return false;
      },
      child: Scaffold(
        body: FutureBuilder(
          future: util.getEventDetails(Globals.eventId),
          builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.done){
              if (snapshot.hasData) {
                return EventTabs(
                  data: snapshot.data,
                  onEventBooked: onEventBooked,
                );
              }
              return Container();
            }
            return Container(
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(),
                ],
              ),
            );
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
                            color: Colors.white,
                            fontFamily: 'MyriadPro',
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
                            color: Colors.white,
                            fontFamily: 'MyriadPro',
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
  bool _expired = false;

  @override
  void initState() {
    super.initState();
    DateTime _expirationDate = DateTime.parse(widget.data['expirationDate']);
    DateTime _currentDate = DateTime.now();
    _expired =
        _expirationDate.difference(_currentDate).inDays > 0 ? false : true;
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

    return
      // the hole space
      ResponsiveContainer(widthPercent: 100,heightPercent: 90, child: Scaffold(
      body: Column(
        children: <Widget>[

          // event tabs
          ResponsiveContainer(
            widthPercent: 100,heightPercent: 8,

            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    height: 45,
                    color: Color(0xfff0f0f0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[

                        // About
                        ResponsiveContainer(
                          widthPercent: 21,heightPercent: 8,
                          alignment: Alignment.center,
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
                                fontSize: 15,
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

                        // Location
                        ResponsiveContainer(
                          widthPercent: 21,heightPercent: 8,
                          alignment: Alignment.center,
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
                                fontSize: 15,
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

                        // Schedule
                        ResponsiveContainer(
                          widthPercent: 21,heightPercent: 8,
                          alignment: Alignment.center,
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
                                fontSize: 15,
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
                    if (Globals.skipped) {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => Login(openedFromHome: false,)));
                    } else {
                      if (Globals.reservationOption ==
                          ReservationOptions.byTickets)
                        _showChooseTicketDialog(widget.onEventBooked);
                      else if (Globals.reservationOption ==
                          ReservationOptions.bySeats) widget.onEventBooked();
                    }
                  },
                  child: Container(
                    height: 45,
                    color: Color(0xffff6600),
                    child: ResponsiveContainer(
                      widthPercent: 30,heightPercent: 8,
                      alignment: Alignment.center,
                      child: Text(
                        Globals.reservationOption ==
                            ReservationOptions.byTickets
                            ? 'Buy Tickets'
                            : 'Buy Seats',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white, fontFamily: 'MyriadPro',fontSize: 15),
                      ),
                    ),
                  ),
                )
//                _expired?Container(
//                  height: 45,
//                  color: Color(0xff808B96),
//                  child: Padding(
//                    padding: EdgeInsets.only(left: _width > 350?23:25,right: _width > 350?23:20,top: 15,bottom: 15),
//                    child: Text('Expired',
//                      textAlign: TextAlign.center,
//                      style: TextStyle(color: Colors.white, fontFamily: 'MyriadPro'),
//                    ),
//                  ),
//                )
//                :GestureDetector(
//                  onTap: () {
//                    if(Globals.skipped){
//                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => Login()));
//                    } else {
//                      if(Globals.reservationOption == ReservationOptions.byTickets)
//                        _showChooseTicketDialog(widget.onEventBooked);
//                      else if(Globals.reservationOption == ReservationOptions.bySeats)
//                        widget.onEventBooked();
//                    }
//
//                  },
//                  child: Container(
//                    height: 45,
//                    color: Color(0xffff6600),
//                    child: Padding(
//                      padding: EdgeInsets.only(left: _width > 350?23:25,right: _width > 350?23:20,top: 15,bottom: 15),
//                      child: Text(
//                        Globals.reservationOption == ReservationOptions.byTickets? 'Buy Tickets' : 'Buy Seats',
//                        textAlign: TextAlign.center,
//                        style: TextStyle(color: Colors.white, fontFamily: 'MyriadPro'),
//                      ),
//                    ),
//                  ),
//                ),
              ],
            ),
          ),

          Flexible(
            child: TabBarView(
              controller: _tabController,
              children: <Widget>[
                AboutPage(
                  imageUrl:
                  '${Globals.imageBaseUrl}/${widget.data['logo']}',
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
    ),);
  }

// End
  _showChooseTicketDialog(Function onTicketChosen) {
    showDialog(
      barrierDismissible: false,
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
  static const platform = const MethodChannel('fawry');

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ListView(
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
                    color: Color(0xff878787)),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FutureBuilder(
                future: util.getServiceClasses(Globals.eventId),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(snapshot.data.length, (index) {
                        return ClassItem(
                            orderIndex: index,
                            classId: snapshot.data[index]['id'],
                            className: snapshot.data[index]['class_Name'],
                            totalPrice: snapshot.data[index]['total_Price'],
                            activityServiceId: snapshot.data[index]['activity_service_Id']);
                      }),
                    );
                  }
                  return Container();
                },
              ),
            ),

            // Buy Button
            Padding(
              padding: const EdgeInsets.only(
                right: 70,
                left: 70,
              ),
              child: ListTile(
                onTap: () async {
                  Navigator.of(context).pop();
                  List list = List();
                  for (int i = 0; i < orderTickets.length; i++) {
                    int numberOfTickets =
                    int.parse(orderTickets[i]['numberOfTickets'].toString());
                    if (numberOfTickets > 0) {
                      list.add(orderTickets[i]);
                    }
                  }
                  orderTickets.clear();
//              print('${Globals.userId}');
//              print('${Globals.eventId}');
//              print('${json.encode(list)}');

                  Map response =
                  await util.addOrder(eventId: Globals.eventId, orders: list);

                  print('$response');
                  var responseFromNative = await platform.invokeMethod('initFawry', response);

                  print('Response from native: ${responseFromNative.toString()}');


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
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Verdana',
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        Positioned(
          right: 0.0, top: 0.0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: (){
                Navigator.of(context).pop();
              },
              child: Icon(Icons.close),
            ),
          ),
        ),
      ],
    );
  }
}

class ClassItem extends StatefulWidget {
  final int orderIndex;
  final int classId;
  final String className;
  final double totalPrice;
  final int activityServiceId;

  ClassItem(
      {@required this.orderIndex,
      @required this.classId,
      @required this.className,
      @required this.totalPrice,
      @required this.activityServiceId});

  @override
  _ClassItemState createState() => _ClassItemState();
}

class _ClassItemState extends State<ClassItem> {
  int _quantity = 1;

  @override
  void initState() {
    super.initState();
    Map item = {"classId": widget.classId, "numberOfTickets": 0};
    bool itemAddedBefore = false;

    for (int i = 0; i < orderTickets.length; i++) {
      if (orderTickets[i]['classId'] == item['classId']) {
        itemAddedBefore = true;
        break;
      }
    }
    if (!itemAddedBefore) orderTickets.add(item);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: DashedDivider(),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 16, left: 12),
                child: Text(
                  widget.className,
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'GeometriqueSans',
                      color: Color(0xff878787)),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
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
                        '${_quantity > 0 ?widget.totalPrice * _quantity:widget.totalPrice} EGP',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Verdana',
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: TicketQuantity(
                      onUpdateQuantity: (value) async {
//                        Map response = await util.availableTickets(
//                            quantity: value,
//                            classId: widget.classId,
//                            activityServiceId: widget.activityServiceId);
//
//                        print('$response');
//
//                        if(response['result']){
//
//                        }
                        setState(() {
                          _quantity = value;
                        });
                        orderTickets[widget.orderIndex]['classId'] =
                        '${widget.classId}';
                        orderTickets[widget.orderIndex]['numberOfTickets'] =
                        '$value';
                        print('$orderTickets');


                      },
                      activityServiceId: widget.activityServiceId,
                      classId: widget.classId,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// Ticket Quantity dropdown.
class TicketQuantity extends StatefulWidget {
  final int classId;
  final int activityServiceId;
  final Function(int) onUpdateQuantity;

  TicketQuantity({@required this.onUpdateQuantity, @required this.classId, @required this.activityServiceId});

  @override
  _TicketQuantityState createState() => _TicketQuantityState();
}

class _TicketQuantityState extends State<TicketQuantity> {
  int _current = 0;

  bool _increasing = false;
  bool _decreasing = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        //decrement
        GestureDetector(
          onTapDown: (details){
            setState(() {
              _decreasing = true;
            });
          },
          onTapUp: (details){
            setState(() {
              _decreasing = false;
            });
          },
          onTap: () async {
            if (_current > 0) {
              int quantity = _current;

              quantity--;

              Map response = await util.availableTickets(
                  quantity: quantity,
                  classId: widget.classId,
                  activityServiceId: widget.activityServiceId);

              print('$response');

              if(response['result']){
                setState(() {
                  _current = quantity;
                });
                widget.onUpdateQuantity(_current);
              }
              Fluttertoast.showToast(
                  msg: response['user_Message'],
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIos: 1,
                  backgroundColor: Colors.black38,
                  textColor: Colors.white,
                  fontSize: 16.0
              );

            }
          },
          child: CircleAvatar(
            backgroundColor: _decreasing?Colors.black12:Colors.transparent,
            maxRadius: 15,
            child: Icon(Icons.remove, color: Colors.black87,),
          ),
        ),

        //Ticket Quantity
        Container(
            width: 30,
            child: Text(
              '$_current',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Verdana',
              ),
            )),

        // increment
        GestureDetector(
          onTapDown: (details){
            setState(() {
              _increasing = true;
            });
          },
          onTapUp: (details){
            setState(() {
              _increasing = false;
            });
          },
          onTap: () async{

            int quantity = _current;

            quantity++;

            Map response = await util.availableTickets(
                quantity: quantity,
                classId: widget.classId,
                activityServiceId: widget.activityServiceId);



            print('$response');

            if(response['result']){
              setState(() {
                _current = quantity;
              });
              widget.onUpdateQuantity(_current);
            }
            Fluttertoast.showToast(
                msg: response['user_Message'],
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIos: 1,
                backgroundColor: Colors.black38,
                textColor: Colors.white,
                fontSize: 16.0
            );


          },
          child: CircleAvatar(

            backgroundColor: _increasing?Colors.black12:Colors.transparent,
            maxRadius: 15,
            child: Icon(Icons.add, color: Colors.black87,),
          ),
        ),
      ],
    );
  }
}
