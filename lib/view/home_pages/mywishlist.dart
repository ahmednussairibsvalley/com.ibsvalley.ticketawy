import 'package:carousel_slider/carousel_slider.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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

class MyWishListPage extends StatelessWidget {
  final Function onBack;
  final Function(int) onCategoryPressed;
  final Function onAllCategoriesPressed;
  final Function onWillPop;

  MyWishListPage(
      {@required this.onBack,
      @required this.onCategoryPressed,
      @required this.onAllCategoriesPressed,
      @required this.onWillPop});

  @override
  Widget build(BuildContext context) {
    if(Globals.pagesStack.top() != PagesIndices.myWishListPageIndex)
      Globals.pagesStack.push(PagesIndices.myWishListPageIndex);

    return WillPopScope(
      onWillPop: ()async{
        onWillPop();
        return false;
      },
      child: FutureBuilder(
        future: Connectivity().checkConnectivity(),
        builder: (context, snapshot){
          if(snapshot.hasData){
            if (snapshot.data == ConnectivityResult.mobile ||
                snapshot.data == ConnectivityResult.wifi){
              return Scaffold(
                body: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'My wishlist',
                            style: TextStyle(
                                color: Color(0xffff6600),
                                fontSize: 17,
                                fontFamily: 'Verdana'),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      child: ListView(
                        children: <Widget>[
                          WishListViewer(onCategoryPressed: onCategoryPressed,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                bottomNavigationBar: BottomAppBar(
                  color: Colors.black,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: GestureDetector(
                          onTap: onBack,
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
              );
            }
            return Center(
              child: Text('There is no internet connection'),
            );
          }
          return Container();

        },
      ),
    );
  }
}

class WishListViewer extends StatefulWidget {

  final Function onCategoryPressed;

  WishListViewer({@required this.onCategoryPressed,});
  @override
  _WishListViewerState createState() => _WishListViewerState();
}

class _WishListViewerState extends State<WishListViewer> {

  FutureBuilder _eventsSlider;

  @override
  void initState() {
    super.initState();
    _eventsSlider = FutureBuilder(
      future: util.getWishList(),
      builder: (context, snapshot){
        if(snapshot.connectionState == ConnectionState.done){
          if(snapshot.hasData){
            List list = snapshot.data;
            if(list.length > 0){
              return EventsSlider(
                onCategoryPressed: widget.onCategoryPressed,
                list: list,
                onUpdateWishList: (){
                  _updateEventSlider();
                },
              );
            }
            return Center(
              child: Image.asset('assets/sad_ticketawy.png'),
            );

          }
          return Center(
            child: Column(
              children: <Widget>[
                Image.asset('assets/sad_ticketawy.png', width: 200,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('There is no events yet',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      color: Color(0xfffe6700),
                    ),
                  ),
                ),
              ],
            ),
          );
        }
        return Container(
          child: Column(
            children: <Widget>[
              SpinKitFadingCircle(
                itemBuilder: (context , int index) {
                  return DecoratedBox(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xffff6600),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  _updateEventSlider(){
    setState(() {
      _eventsSlider = FutureBuilder(
        future: util.getWishList(),
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.done){
            if(snapshot.hasData){
              List list = snapshot.data;
              if(list.length > 0){
                return EventsSlider(
                  onCategoryPressed: widget.onCategoryPressed,
                  list: list,
                  onUpdateWishList: (){
                    _updateEventSlider();
                  },
                );
              }
              return Center(
                child: Image.asset('assets/sad_ticketawy.png'),
              );

            }
            return Center(
              child: Column(
                children: <Widget>[
                  Image.asset('assets/sad_ticketawy.png', width: 200,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('There is no events yet',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        color: Color(0xfffe6700),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          return Container(
            child: Column(
              children: <Widget>[
                SpinKitFadingCircle(
                  itemBuilder: (context , int index) {
                    return DecoratedBox(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xffff6600),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      );
    });
  }


  @override
  Widget build(BuildContext context) {
    return _eventsSlider;
  }
}


class EventsSlider extends StatefulWidget {
  final Function(int) onCategoryPressed;
  final Function onUpdateWishList;
  final List list;

  EventsSlider({@required this.onCategoryPressed,
    @required this.list, @required this.onUpdateWishList});
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
          onUpdateWishList: widget.onUpdateWishList,
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
  final List list;
  final Function(int) onCategoryPressed;
  final Function onUpdateWishList;

  EventsPage({@required this.list, @required this.onCategoryPressed, @required this.onUpdateWishList});

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
                onCategoryPressed(list[index]['id']);
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
                          ResponsiveContainer(
                              heightPercent: 10, widthPercent: 40,
                              child: Image.network(
                                '${Globals.imageBaseUrl}/${list[index]['logo']}',
                                fit: BoxFit.fill,

                              )),
                          Positioned(
                              top: 3.0,
                              right: 3,
                              child: Container(
                                width: 30,
                                height: 30,
                                decoration: new BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.deepOrange),
                                child: IconButton(
                                    padding: EdgeInsets.only(top: 2),
                                    icon: Icon(
                                      Icons.favorite,
                                      color: Colors.white,
                                      size: 25,
                                    ),
                                    onPressed: () async{
                                      await util.addToRemoveFromWishList(list[index]['id']);
                                      onUpdateWishList();

                                    }
                                    ),
                              )
                          ),
                        ],
                      )),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                            child: Text('${list[index]['name']}',style: TextStyle(fontSize: 12),)
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Color(0xffff6600),
                            borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            'Starts from ${list[index]['price']} EGP',
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
