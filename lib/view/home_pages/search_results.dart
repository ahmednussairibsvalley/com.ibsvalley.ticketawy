import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../../globals.dart';
import '../../util.dart' as util;

List<T> map<T>(List list, Function handler) {
  List<T> result = [];
  for (var i = 0; i < list.length; i++) {
    result.add(handler(i, list[i]));
  }

  return result;
}

class SearchResults extends StatelessWidget {
  final Function(int) onEventClicked;

  SearchResults({@required this.onEventClicked});
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: util.search(Globals.keyWord),
      builder: (context, snapshot){
        if(snapshot.hasData){
          return EventsSlider(
            onCategoryPressed: onEventClicked,
            list: snapshot.data,
          );
        }
        return Container();
      },
    );
  }
}

class EventsSlider extends StatefulWidget {
  final Function(int) onCategoryPressed;
  final List list;

  EventsSlider({@required this.onCategoryPressed, @required this.list});
  @override
  _EventsSliderState createState() => _EventsSliderState();
}

class _EventsSliderState extends State<EventsSlider> {
  int _current = 0;
  static List _list = List();
  CarouselSlider _carouselSlider;
  List child;
  List<Map> paisList = List();

  @override
  void initState() {
    super.initState();
    _list = widget.list;
    for (int i = 0; i < _list.length; i++) {
      Map pairs = Map();
      int first = i * 4;
      int second = first + 1;
      int third = second + 1;
      int fourth = third + 1;
      if (first >= _list.length) {
        break;
      } else {
        pairs['first'] = first;
      }

      if (second >= _list.length) {
        second = 0;
      }
      pairs['second'] = second;

      if (third >= _list.length) {
        paisList.add(pairs);
        break;
      } else {
        pairs['third'] = third;
      }

      if (fourth >= _list.length) {
        fourth = 0;
      }
      pairs['fourth'] = fourth;
      paisList.add(pairs);
    }

    child = map<Widget>(
      paisList,
          (index, i) {
        List list = List();

        list.add(_list[paisList[index]['first']]);

        if (paisList[index]['second'] > 0) {
          list.add(_list[paisList[index]['second']]);
        }

        if (paisList[index].containsKey('third')) {
          if (paisList[index]['third'] > 0) {
            list.add(_list[paisList[index]['third']]);
          }
        }

        if (paisList[index].containsKey('fourth')) {
          if (paisList[index]['fourth'] > 0) {
            list.add(_list[paisList[index]['fourth']]);
          }
        }

        return EventsPage(
          list: list,
          onCategoryPressed: widget.onCategoryPressed,
        );
      },
    ).toList();

    _carouselSlider = CarouselSlider(
      items: child,
      viewportFraction: .95,
      aspectRatio: 1.1,
      onPageChanged: (index) {
        setState(() {
          _current = index;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _carouselSlider,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: map<Widget>(
            paisList,
                (index, url) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _current = index;
                  });
                  _carouselSlider.animateToPage(_current,
                      duration: Duration(milliseconds: 100),
                      curve: Curves.linear);
                },
                child: Container(
                  width: 15.0,
                  height: 15.0,
                  margin: EdgeInsets.symmetric(vertical: 2.0, horizontal: 5.0),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _current == index
                          ? Color(0xffed5e00)
                          : Color(0xff7e7e7e)),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class EventsPage extends StatelessWidget {
//  List list = Globals.controller.events;
  final List list;
  final Function(int) onCategoryPressed;

  EventsPage({@required this.list, @required this.onCategoryPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.2,
            crossAxisSpacing: 1,
            mainAxisSpacing: 1),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: NeverScrollableScrollPhysics(),
        children: List.generate(list.length, (index) {
          return Padding(
            padding: const EdgeInsets.all(2.0),
            child: GestureDetector(
              onTap: (){
                onCategoryPressed(list[index]['event_Id']);
              },
              child: Material(
                elevation: 5,
                shadowColor: Colors.black,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Column(
//                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                          child: Stack(
                            children: <Widget>[
                              Image.network(
                                'http://40.85.116.121:8606/EventsLogo/${list[index]['logo']}',
                                fit: BoxFit.cover,
                              ),
                              Positioned(
                                  top: 3.0,
                                  right: 3,
                                  child: Container(
                                    width: 30,
                                    height: 30,
                                    decoration: new BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.deepOrange),
                                    child: GestureDetector(
                                      child: IconButton(
                                          padding: EdgeInsets.only(top: 2),
                                          icon: Icon(
                                            Icons.favorite,
                                            color: Colors.white,
                                            size: 25,
                                          ),
                                          onPressed: (){Icon(Icons.favorite_border);}),
                                    ),
                                  )),
                            ],
                          )),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text('${list[index]['event_name']}'),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Color(0xffff6600),
                            borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            '${list[index]['price']} EGP / Ticket',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class DrawerDivider extends StatelessWidget {
  final double height;
  final Color color;
  final double width;

  const DrawerDivider(
      {this.height = 1, this.color = Colors.black, this.width = 10});
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        final dashWidth = width;
        final dashHeight = height;
        final dashCount = (boxWidth / (2 * dashWidth)).floor();
        return Flex(
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: color),
              ),
            );
          }),
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
        );
      },
    );
  }
}