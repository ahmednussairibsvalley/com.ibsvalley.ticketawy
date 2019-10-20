import 'package:carousel_slider/carousel_slider.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../custom_widgets/CustomShowDialog.dart';
import 'package:responsive_container/responsive_container.dart';

import '../../globals.dart';
import '../../util.dart' as util;

List<T> map<T>(List list, Function handler) {
  List<T> result = [];
  for (var i = 0; i < list.length; i++) {
    result.add(handler(i, list[i]));
  }

  return result;
}

class CategoryPage extends StatefulWidget {
  final Function onBack;
  final Function(int) onCategoryPressed;
  final Function onAllCategoriesPressed;
  final Function onWillPop;

  CategoryPage(
      {@required this.onBack,
      @required this.onCategoryPressed,
      @required this.onAllCategoriesPressed,
      @required this.onWillPop});
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  FutureBuilder _eventsViewer;

  bool _noEvents = false;

  @override
  void initState() {
    super.initState();
    _eventsViewer = FutureBuilder(
      future: util.getEventsList(Globals.categoryId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Globals.controller.populateEvents(snapshot.data);
          if(Globals.controller.events.length <= 0){
            _noEvents = true;
          }
          return Column(
            children: <Widget>[
              Flexible(
                child: ListView(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            Globals.currentCategoryName,
                            style: TextStyle(
                                color: Color(0xffff6600),
                                fontSize: 17,
                                fontFamily: 'Verdana'),
                          ),
                          _noEvents? Container():
                          GestureDetector(
                            onTap: () {
                              _showFilterDialog(context);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Color(0xffff6600),
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(
                                    right: 10, left: 10, top: 5, bottom: 5),
                                child: Text(
                                  'Filter By',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Globals.controller.events.length > 0
                        ? EventsSlider(
                      eventsList: Globals.controller.events,
                      onCategoryPressed: widget.onCategoryPressed,
                    )
                        : Center(
                      child: ResponsiveContainer(heightPercent: 50, widthPercent: 70, padding: EdgeInsets.only(top: 70), child: Column(
                        children: <Widget>[
                          Image.asset(
                            'assets/sad_ticketawy.png',
                            width: 120,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'There are no events yet',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20,
                                color: Color(0xfffe6700),
                              ),
                            ),
                          ),
                        ],
                      ),),
                    ),
                  ],
                ),
              ),
            ],
          );
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

  @override
  Widget build(BuildContext context) {
    if(Globals.pagesStack.top() != PagesIndices.categoryPageIndex)
      Globals.pagesStack.push(PagesIndices.categoryPageIndex);

    return WillPopScope(
      onWillPop: () async {
        widget.onWillPop();
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          body: _eventsViewer,
          bottomNavigationBar: BottomAppBar(
            color: Colors.black,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: GestureDetector(
                    onTap: widget.onBack,
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
                    onTap: widget.onAllCategoriesPressed,
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
      ),
    );
  }

  _showFilterDialog(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return CustomAlertDialog(
            titlePadding: EdgeInsets.all(0),
            contentPadding: EdgeInsets.all(0),
            content: Container(
              width: 300.0,
              height: 450.0,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(33.0)),
              ),
              child: FiterDialog(),
            ),
          );
        });
  }
}

class EventsSlider extends StatefulWidget {
  final Function(int) onCategoryPressed;
  final List eventsList;

  EventsSlider({@required this.onCategoryPressed, @required this.eventsList});
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
    _list = widget.eventsList;
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
    return Column(
      children: <Widget>[
        _carouselSlider,
        paisList.length > 1?Row(
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
        ):Container(),
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
              onTap: () {
                onCategoryPressed(list[index].id);
              },
              child: Material(
                elevation: 5,
                shadowColor: Colors.black,
                child: Padding(
                  padding: const EdgeInsets.all(0),
                  child: Column(
//                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      ResponsiveContainer(
                        heightPercent: 10, widthPercent: 40,
                          child: Image.network(
                        list[index].imageUrl,
                        fit: BoxFit.fill,

                      )),
                      ResponsiveContainer(
                        heightPercent: 4.5, widthPercent: 100,
                        alignment: Alignment.center,
                        child: Text('${list[index].title}',style: TextStyle(fontSize: 12),textAlign: TextAlign.center,),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Color(0xffff6600),
                            borderRadius: BorderRadius.circular(20)),
                        child: ResponsiveContainer(
                          heightPercent: 3, widthPercent: 35,
                          alignment: Alignment.center,
                          child: Text(
                            'Start from ${list[index].price} EGP',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
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

class FiterDialog extends StatefulWidget {
  @override
  _FiterDialogState createState() => _FiterDialogState();
}

class _FiterDialogState extends State<FiterDialog> {
  List _cityList = [
    'Cairo',
    'Alexandria',
    'Mansoura',
    'Marsa Matroh',
  ];

//  List _PriceList = [
//    '50\$',
//    '80\$',
//    '120\$',
//  ];

  RangeValues _values = RangeValues(50.0, 1000.0);

  String _cityValue;
//  String _PriceValue;

  @override
  void initState() {
    super.initState();
    _cityValue = _cityList[0];
//    _PriceValue = _PriceList[0];
  }

//  Widget _priceItem(double price){
//    return Text('${price.toStringAsFixed(0)} \$');
//  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Scaffold(
          body: ListView(
//      crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 10),
                child: Text(
                  'Filter By',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xfffd6600),
                    fontSize: 20,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DrawerDivider(
                  width: 10,
                  height: 1,
                  color: Color(0xffb8b8b8),
                ),
              ),

              // From Date Filter
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Text(
                      'From',
                      style: TextStyle(color: Color(0xff656565)),
                    ),
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          right: 8.0, bottom: 15.0, left: 25.0),
                      child: Container(
                        width: 195,
                        child: DateTimeField(
                          format: DateFormat("yyyy-MM-dd"),
                          decoration: InputDecoration(
                            hintText: 'Press to set date',
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                  style: BorderStyle.none,
                                )),
                            labelStyle: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                          onShowPicker: (context, currentValue) {
                            return showDatePicker(
                                context: context,
                                firstDate: DateTime(1900),
                                initialDate: currentValue ?? DateTime.now(),
                                lastDate: DateTime(2100));
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              // To Date Filter
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Text(
                      'To',
                      style: TextStyle(color: Color(0xff656565)),
                    ),
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          right: 8.0, bottom: 15.0, left: 25.0),
                      child: Container(
                        width: 195,
                        child: DateTimeField(
                          format: DateFormat("yyyy-MM-dd"),
                          decoration: InputDecoration(
                            hintText: 'Press to set date',
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                  style: BorderStyle.none,
                                )),
                            labelStyle: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                          onShowPicker: (context, currentValue) {
                            return showDatePicker(
                                context: context,
                                firstDate: DateTime(1900),
                                initialDate: currentValue ?? DateTime.now(),
                                lastDate: DateTime(2100));
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              // Time Filter

              // City Filter
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20.0,
                    ),
                    child: Text(
                      'City',
                      style: TextStyle(color: Color(0xff656565)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0, bottom: 15.0),
                    child: Container(
                      padding: EdgeInsets.only(
                        right: 10,
                        left: 10,
                      ),
                      decoration: ShapeDecoration(
                        color: Color(0xffeeeeee),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(width: 1.0, style: BorderStyle.none),
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        ),
                      ),
                      child: DropdownButton(
                        underline: Container(),
                        icon: Icon(Icons.expand_more),
                        value: _cityValue,
                        onChanged: (value) {
                          setState(() {
                            _cityValue = value;
                          });
                        },
                        items: List.generate(_cityList.length, (index) {
                          return DropdownMenuItem(
                            value: _cityList[index],
                            child: Container(
                              width: 150,
                              child: Text('${_cityList[index]}'),
                            ),
                          );
                        }),
                      ),
                    ),
                  ),
                ],
              ),

              // Price Filter
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Text(
                      'Price',
                      style: TextStyle(color: Color(0xff656565)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      right: 8.0,
                      bottom: 15.0,
                    ),
                    child: Container(
                        decoration: ShapeDecoration(
                          color: Color(0xffeeeeee),
                          shape: RoundedRectangleBorder(
                            side:
                                BorderSide(width: 1.0, style: BorderStyle.none),
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                          ),
                        ),
                        child: Column(
                          children: <Widget>[
                            RangeSlider(
                              values: _values,
                              min: 0.0,
                              max: 1500.0,
                              onChanged: (RangeValues value) {
                                setState(() {
                                  _values = value;
                                });
                              },
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(right: 25.0),
                                  child: Text(
                                    '${_values.start.toStringAsFixed(0)} EGP',
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 25.0),
                                  child: Text(
                                    '${_values.end.toStringAsFixed(0)} EGP',
                                    textAlign: TextAlign.right,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )),
                  ),
                ],
              ),

              ListTile(
                onTap: () {
                  Navigator.of(context).pop();
                },
                title: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    child: Text(
                      'Filter',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    decoration: BoxDecoration(
                      color: Color(0xffff6600),
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    padding: EdgeInsets.all(10),
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          right: 0.0,
          top: 0.0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Icon(Icons.close)),
          ),
        )
      ],
    );
  }
}
