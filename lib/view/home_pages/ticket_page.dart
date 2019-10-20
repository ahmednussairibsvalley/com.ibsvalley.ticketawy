import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:dashed_container/dashed_container.dart';

import 'package:barcode_flutter/barcode_flutter.dart';
import 'package:responsive_container/responsive_container.dart';

import '../../globals.dart';
import '../dashed_divider.dart';
import '../../util.dart' as util;

List<T> map<T>(List list, Function handler) {
  List<T> result = [];
  for (var i = 0; i < list.length; i++) {
    result.add(handler(i, list[i]));
  }

  return result;
}

class TicketsPage extends StatefulWidget {
  @override
  _TicketsPageState createState() => _TicketsPageState();
}

class _TicketsPageState extends State<TicketsPage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: util.getTicketDetails(Globals.orderId),
      builder: (context, snapshot){
        if(snapshot.connectionState == ConnectionState.done){
          if(snapshot.hasData){
            return TicketsSlider(list: snapshot.data,);
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
    );
  }
}

class TicketsSlider extends StatefulWidget {

  final List list;

  TicketsSlider({@required this.list});
  @override
  _TicketsSliderState createState() => _TicketsSliderState();
}

class _TicketsSliderState extends State<TicketsSlider> {

  int _current = 0;
  static List _list = List();
  CarouselSlider _carouselSlider;
  List child;

  @override
  void initState() {
    _list = widget.list;
    super.initState();
    child = map<Widget>(
      _list,
          (index, i) {
        return TicketItem(
          className: i['class_Name'],
          price: i['price_per_Ticket'],
          eventName: i['event_Name'],
          date: i['date'],
          orderId: '${i['order_Id']}',
          serialNumber: i['serial_Number'],
        );
      },
    ).toList();
    _carouselSlider = CarouselSlider(
      items: child,
      viewportFraction: 1.0,
      aspectRatio: 0.9,
      enableInfiniteScroll: false,
      onPageChanged: (index) {
        setState(() {
          _current = index;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    return Column(
      children: <Widget>[
        _carouselSlider,
        _list.length > 1?Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: map<Widget>(
            _list,
                (index, url) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _current = index;
                  });
                  _carouselSlider.animateToPage(_current,
                      duration: Duration(milliseconds: 200),
                      curve: Curves.linear);
                },
                child: Container(
                  width: _width > 350 ? 12.0 : 10.0,
                  height: _width > 350 ? 12.0 : 10.0,
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5.0),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _current == index
                          ? Color(0xffed5e00)
                          : Color(0xff7e7e7e)),
                ),
              );
            },
          ),
        ):Container(),
      ],
    );
  }
}


class TicketItem extends StatefulWidget {
  final String orderId;
  final String eventName;
  final String serialNumber;
  final String className;
  final double price;
  final String date;

  TicketItem(
      {@required this.orderId,
        @required this.eventName,
        @required this.serialNumber,
        @required this.className,
        @required this.price,
        @required this.date});
  @override
  _TicketItemState createState() => _TicketItemState();
}

class _TicketItemState extends State<TicketItem> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ResponsiveContainer(
          widthPercent: 100,
          heightPercent: 62,
          alignment: Alignment.center,
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
                height: 420,
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
                                  '${widget.eventName}',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 25,
                                      fontFamily: 'Verdana'),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text('${widget.serialNumber}'),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text('${widget.className}',
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
                                '${widget.price} EGP',
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
                                '1 Ticket',
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
