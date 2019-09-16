import 'package:flutter/material.dart';
import 'package:ticketawy/view/custom_widgets/CustomShowDialog.dart';
import 'package:ticketawy/view/home_pages/event_details_pages/dashed_divider.dart';
import 'event_details_pages/about.dart';
import 'event_details_pages/location.dart';
import 'event_details_pages/schedule.dart';

import '../../globals.dart';

final int aboutPageIndex = 0;
final int locationPageIndex = 1;
final int schedulePageIndex = 2;

class EventDetails extends StatelessWidget {
  final Function onPreviousPagePressed;

  EventDetails({@required this.onPreviousPagePressed});

  @override
  Widget build(BuildContext context) {
    Globals.pagesStack.push(PagesIndices.eventPageIndex);
    return Scaffold(
      body: EventTabs(),
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
                    Image.asset(
                      'assets/all_events.png',
                      width: 30,
                      height: 30,
                    ),
                    Text(
                      'All Categories',
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

class EventTabs extends StatefulWidget {
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
                GestureDetector(
                  onTap: () {
                    _showChooseTicketDialog();
                  },
                  child: Container(
                    height: 50,
                    color: Color(0xffff6600),
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: Text(
                        'Buy Tickets',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            child: TabBarView(
              controller: _tabController,
              children: <Widget>[
                AboutPage(),
                LocationPage(),
                SchedulePage(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _showChooseTicketDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return CustomAlertDialog(
            titlePadding: EdgeInsets.all(0),
            contentPadding: EdgeInsets.all(0),
            content: Container(
              width: 400.0,
              height: 500.0,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(33.0)),
              ),
              child: ChooseTicket(),
            ),
          );
        });
  }
}

class ChooseTicket extends StatefulWidget {
  @override
  _ChooseTicketState createState() => _ChooseTicketState();
}

class _ChooseTicketState extends State<ChooseTicket> {
  Map _map = {
    'Class A': 120,
    'Class B': 80,
    'Class C': 50,
  };
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
              fontSize: 20,
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
                        Text('${_map.keys.toList()[index]}'),
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

class TicketQuantity extends StatefulWidget {
  @override
  _TicketQuantityState createState() => _TicketQuantityState();
}

class _TicketQuantityState extends State<TicketQuantity> {
  int _current = 0;
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
        value: _current,
        items: List.generate(100, (index) {
          return DropdownMenuItem(
            child: Text('$index'),
            value: index,
          );
        }),
        onChanged: (index) {
          setState(() {
            _current = index;
          });
        });
  }
}
