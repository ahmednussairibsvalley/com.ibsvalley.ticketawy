import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../globals.dart';
import '../../util.dart' as util;

List<T> map<T>(List list, Function handler) {
  List<T> result = [];
  for (var i = 0; i < list.length; i++) {
    result.add(handler(i, list[i]));
  }

  return result;
}

/// The home page.

class HomePage extends StatelessWidget {

  final Function(int, String) onPress;
  final Function(int) onEventPressed;
  final Function(int) onHotOfferPressed;

  HomePage(
      {@required this.onPress,
        @required this.onEventPressed,
        @required this.onHotOfferPressed});

  @override
  Widget build(BuildContext context) {
    while(Globals.pagesStack.isNotEmpty){
      Globals.pagesStack.pop();
    }
    Globals.pagesStack.push(PagesIndices.homePageIndex);
    return FutureBuilder(
      future: Connectivity().checkConnectivity(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data == ConnectivityResult.mobile ||
              snapshot.data == ConnectivityResult.wifi) {
            return FutureBuilder(
              future: util.getHomeLists(),
              builder: (context, snapshot){
                if(snapshot.connectionState == ConnectionState.done){
                  if(snapshot.hasData){
                    return Sliders(
                      data: snapshot.data,
                      onEventPressed: onEventPressed,
                      onHotOfferPressed: onHotOfferPressed,
                      onPress: onPress,
                    );
                  }
                  return Container();
                }
                return SpinKitFadingCircle(
                  itemBuilder: (context , int index) {
                    return DecoratedBox(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.deepOrange,
                      ),
                    );
                  },
                );
              },
            );
          }
          return Center(
            child: Text('There is no internet connection'),
          );
        }
        return Container();
      },
    );
  }
}

/// The sliders viewer.

class Sliders extends StatefulWidget {

  final Function(int, String) onPress;
  final Function(int) onEventPressed;
  final Function(int) onHotOfferPressed;
  final Map data;

  Sliders(
      {@required this.onPress,
        @required this.onEventPressed,
        @required this.onHotOfferPressed, @required this.data});
  @override
  _SlidersState createState() => _SlidersState();
}

class _SlidersState extends State<Sliders> {

  Widget _hotOffers;
  Widget _hotEvents;

  Widget _tmp;

  ListView _listView;

  double _lastPagePosition = 0;

  final ScrollController _scrollController = ScrollController();

  _updateHotEvents(){
    setState(() {
      _hotEvents = FutureBuilder(
        future: util.getHomeLists(),
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.done){
            if(snapshot.hasData){
              _scrollController.jumpTo(_lastPagePosition);
              return EventsSlider(
                onEventPressed: widget.onEventPressed,
                list: widget.data['homeEvents']/*Globals.controller.homeEvents*/,
                onUpdateWisthList: () {
                  _updateHotOffers();
                },
              );
            }
            return Container();
          }
          return SpinKitFadingCircle(
            itemBuilder: (context , int index) {
              return DecoratedBox(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.deepOrange,
                ),
              );
            },
          );
        },
      );
      _listView = ListView(
        controller: _scrollController,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        children: <Widget>[
          _hotEvents,
          CategoriesSlider(
            list: widget.data['homeCategories'],
            onPress: widget.onPress,
          ),
          _hotOffers,
        ],
      );
    });

  }

  _updateHotOffers(){
    setState(() {
      _hotOffers = FutureBuilder(
        future: util.getHomeLists(),
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.done){
            if(snapshot.hasData){
              return HotOffersSlider(
                onUpdateWishList: () {
                  _updateHotEvents();
                },
                onEventPressed: widget.onHotOfferPressed,
                list: snapshot.data['hotEvents'],
              );
            }
            return Container();
          }
          return SpinKitFadingCircle(
            itemBuilder: (context , int index) {
              return DecoratedBox(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.deepOrange,
                ),
              );
            },
          );
        },
      );
      _listView = ListView(
        controller: _scrollController,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        children: <Widget>[
          _hotEvents,
          CategoriesSlider(
            list: widget.data['homeCategories'],
            onPress: widget.onPress,
          ),
          _hotOffers,
        ],
      );
    });
  }

  @override
  void initState() {
    super.initState();
    _hotEvents = EventsSlider(
      onEventPressed: widget.onEventPressed,
      list: widget.data['homeEvents']/*Globals.controller.homeEvents*/,
      onUpdateWisthList: () {
        _updateHotOffers();
      },
    );

    _hotOffers = HotOffersSlider(
      onUpdateWishList: () {
        _updateHotEvents();
      },
      onEventPressed: widget.onHotOfferPressed,
      list: widget.data['hotEvents'],
    );

    _listView = ListView(
      controller: _scrollController,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      children: <Widget>[
        _hotEvents,
        CategoriesSlider(
          list: widget.data['homeCategories'],
          onPress: widget.onPress,
        ),
        _hotOffers,
      ],
    );
  }
  @override
  Widget build(BuildContext context) {
    return NotificationListener(
      child: _listView,
      onNotification: (t) {
        if (t is ScrollEndNotification) {
          _lastPagePosition = _scrollController.position.maxScrollExtent;
        }
        return null;
      },
    );
  }
}

// -------------------------------------------
// -------------------------------------------

/// The events slider.

class EventsSlider extends StatefulWidget {
  final Function onEventPressed;
  final List list;
  final Function onUpdateWisthList;
  EventsSlider(
      {@required this.onEventPressed,
        @required this.list,
        @required this.onUpdateWisthList});
  @override
  _EventsSliderState createState() => _EventsSliderState(
    onEventPressed: onEventPressed,
  );
}

class _EventsSliderState extends State<EventsSlider> {
  int _current = 0;
  static List _list = List();
  CarouselSlider _carouselSlider;
  List child;

  final Function onEventPressed;

  _EventsSliderState({@required this.onEventPressed});

  @override
  void initState() {
    _list = widget.list;
    super.initState();
    child = map<Widget>(
      _list,
          (index, i) {
        return EventItem(
          price: i['price'],
          onEventPressed: onEventPressed,
          id: i['id'],
          title: i['name'],
          imageUrl: '${Globals.imageBaseUrl}/${i['logo']}',
          onUpdateWishList: () {
            widget.onUpdateWisthList();
          },
        );
      },
    ).toList();
    _carouselSlider = CarouselSlider(
      items: child,
      viewportFraction: 1.0,
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
        Row(
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
        ),
      ],
    );
  }
}

/// The event item.

class EventItem extends StatefulWidget {
  final int id;
//  final int reservationOption;
  final String imageUrl;
  final String title;
  final double price;
  final Function(int) onEventPressed;
  final Function onUpdateWishList;

  EventItem(
      {@required this.id,
//        @required this.reservationOption,
        @required this.onEventPressed,
        @required this.imageUrl,
        @required this.title,
        @required this.price,
        @required this.onUpdateWishList});
  @override
  _EventItemState createState() => _EventItemState();
}

class _EventItemState extends State<EventItem> {
  bool _addedToWishList = false;

  RefreshController _refreshController = RefreshController(initialRefresh: false);

  FutureBuilder _eventImage;

  void _onRefresh() async{
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    setState(() {
      _eventImage = FutureBuilder(
        future: util.isImageUrlAvailable(widget.imageUrl),
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.done){
            if(snapshot.hasData){
              if(snapshot.data){
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Material(
                    elevation: 5.0,
                    shadowColor: Colors.black,
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.network(
                          widget.imageUrl,
                          fit: BoxFit.cover,
                          height: MediaQuery.of(context).size.height / 10,
                        ),
                      ),
                    ),
                  ),
                );
              }
              return Container();
            }
            return Container();
          }
          return Container(
            alignment: Alignment.center,
            child: SpinKitFadingCircle(
              itemBuilder: (context , int index) {
                return DecoratedBox(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.deepOrange,
                  ),
                );
              },
            ),
          );
        },
      );
    });
    _refreshController.refreshCompleted();
  }

  void _onLoading() async{
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
//    print('loaded');
    _refreshController.loadComplete();
  }

  @override
  void initState() {
    super.initState();
    _eventImage = FutureBuilder(
      future: util.isImageUrlAvailable(widget.imageUrl),
      builder: (context, snapshot){
        if(snapshot.connectionState == ConnectionState.done){
          if(snapshot.hasData){
            if(snapshot.data){
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Material(
                  elevation: 5.0,
                  shadowColor: Colors.black,
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.network(
                        widget.imageUrl,
                        fit: BoxFit.cover,
                        height: MediaQuery.of(context).size.height / 10,
                      ),
                    ),
                  ),
                ),
              );
            }
            return Container();
          }
          return Container();
        }
        return Container(
          alignment: Alignment.center,
          child: SpinKitFadingCircle(
            itemBuilder: (context , int index) {
              return DecoratedBox(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.deepOrange,
                ),
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      enablePullDown: true,
//      enablePullUp: true,
      onLoading: _onLoading,
      onRefresh: _onRefresh,
      controller: _refreshController,
      child: GestureDetector(
        onTap: () {
//          Globals.reservationOption = widget.reservationOption;
//          Globals.reservationOption = 0;
          widget.onEventPressed(widget.id);
        },
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            _eventImage,
//                  Positioned(
//                    top: 8.0,
//                    left: 30.0,
//                    child: Container(
//                      decoration: BoxDecoration(color: Colors.deepOrange),
//                      child: Padding(
//                        padding: const EdgeInsets.all(15.0),
//                        child: Text(
//                          'Hot',
//                          style: TextStyle(
//                              color: Color(0xffeaeae7), fontSize: 18),
//                        ),
//                      ),
//                    ),
//                  ),

            //Wishlist Button
            Globals.skipped?Container():
            Positioned(
              top: 25.0, right: 25.0,
              child: WishListButton(
                eventId: widget.id,
                onUpdateWishList: widget.onUpdateWishList,
              ),
            ),
//            Globals.skipped
//                ? Container()
//                : Positioned(
//                top: 25.0,
//                right: 25,
//                child: Container(
//                  width: 40,
//                  height: 40,
//                  decoration: new BoxDecoration(
//                      shape: BoxShape.circle,
//                      color: Colors.deepOrange),
//                  child: FutureBuilder(
//                    future: util.getWishList(),
//                    builder: (context, snapshot) {
//                      if (snapshot.connectionState ==
//                          ConnectionState.done) {
//                        return Container(
//                          width: 30,
//                          height: 30,
//                          decoration: new BoxDecoration(
//                              shape: BoxShape.circle,
//                              color: Colors.deepOrange),
//                          child: IconButton(alignment: Alignment.center,
//                              padding: EdgeInsets.only(top: 2),
//                              icon: Icon(
//                                _addedToWishList
//                                    ? Icons.favorite
//                                    : Icons.favorite_border,
//                                color: Colors.white,
//                                size: 32,
//                              ),
//                              onPressed: () async {
//                                Map response = await util
//                                    .addToRemoveFromWishList(
//                                    widget.id);
//                                if (response['result']) {
//                                  setState(() {
//                                    _addedToWishList =
//                                    _addedToWishList
//                                        ? false
//                                        : true;
//                                  });
//                                }
//                                widget.onUpdateWishList();
//                              }),
//                        );
//                      }
//                      return Container(
//                        child: Column(
//                          children: <Widget>[
//                            CircularProgressIndicator(),
//                          ],
//                        ),
//                      );
//                    },
//                  ),
//                )),

            Positioned(
              right: 0.0,
              left: 0.0,
              bottom: 0.0,
              child: Padding(
                padding: const EdgeInsets.only(
                    right: 35, left: 35, bottom: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        color: Color(0xffff6600),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            bottomLeft: Radius.circular(15)),
                      ),
                      width: widget.title.length > 20 ? 201 : 150,
                      height: widget.title.length > 29 ? 48 : 31,
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.all(0),
                        child: Text(
                          '${widget.title}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          softWrap: true,),
                      ),
                    ),
                    Container(
                      height: widget.title.length > 29 ? 48 : 31,
                      alignment: Alignment.topCenter,
                      decoration: BoxDecoration(
                        color: Color(0xffe75d02),
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(15),
                            topRight: Radius.circular(15)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '${widget.price} EGP',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
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

// -------------------------------------------
// -------------------------------------------

/// The categories slider

class CategoriesSlider extends StatefulWidget {
  final Function(int, String) onPress;
  final List list;
  CategoriesSlider({@required this.onPress, @required this.list});
  @override
  _CategoriesSliderState createState() =>
      _CategoriesSliderState(onPress: onPress);
}

class _CategoriesSliderState extends State<CategoriesSlider> {
  int _current = 0;
  static List _list;
  CarouselSlider _carouselSlider;
  List child;
  List<Map> paisList = List();

  final Function(int, String) onPress;

  _CategoriesSliderState({@required this.onPress});

  @override
  void initState() {
    super.initState();
    _list = widget.list;
    for (int i = 0; i < _list.length; i++) {
      Map pairs = Map();
      int first = i * 2;
      int second = first + 1;
      if (first >= _list.length) {
        break;
      } else {
        pairs['first'] = first;
      }

      if (second >= _list.length) {
        second = 0;
      }
      pairs['second'] = second;
      paisList.add(pairs);
    }

    child = map<Widget>(
      paisList,
          (index, i) {
        List list = List();
        if (paisList[index]['second'] > 0) {
          list.add(_list[paisList[index]['first']]);
          list.add(_list[paisList[index]['second']]);
        } else {
          list.add(_list[paisList[index]['first']]);
        }
        return CategoriesPage(
          list: list,
          onPress: onPress,
        );
      },
    ).toList();

    _carouselSlider = CarouselSlider(
      items: child,
      viewportFraction: 1.0,
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
    return Container(
      color: Color(0xfff0f0f0),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(7.0),
            child: Text(
              'Categories',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xfffe6700),
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'Verdana',
              ),
            ),
          ),
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
                        duration: Duration(milliseconds: 200),
                        curve: Curves.linear);
                  },
                  child: Container(
                    width: _width > 350 ? 12.0 : 10.0,
                    height: _width > 350 ? 12.0 : 10.0,
                    margin:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
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
      ),
    );
  }
}

/// The categories page.

class CategoriesPage extends StatelessWidget {
  final List list;
  final Function(int, String) onPress;

  CategoriesPage({@required this.list, @required this.onPress});

  @override
  Widget build(BuildContext context) {


    return GridView(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: .9,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      physics: NeverScrollableScrollPhysics(),
      children: List.generate(list.length, (index) {
        String imageUrl = 'assets/loading.png';
        switch(list[index]['categoryName']){
          case 'MUSIC':
            imageUrl = 'assets/category_music.jpg';
            break;
          case 'THEATERS':
            imageUrl = 'assets/category_theatre.jpg';
            break;
          case 'COURSES':
            imageUrl = 'assets/category_courses.jpg';
            break;
          case 'SPORTING':
            imageUrl = 'assets/category_sporting.jpg';
            break;
          case 'ENTERTAINMENT':
            imageUrl = 'assets/category_entertainment.jpg';
            break;
          case 'OTHERS':
            imageUrl = 'assets/category_others.jpg';
            break;
        }
        return GestureDetector(
          onTap: () {
            onPress(list[index]['id'], list[index]['categoryName']);
          },
          child: Padding(
            padding: EdgeInsets.all(5),
            child: Material(
              shadowColor: Colors.black,
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                        child: Image.asset(
                          imageUrl,
                          fit: BoxFit.cover,
                        )),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        '${list[index]['categoryName']}',
                        style: TextStyle(
                            color: Color(0xff656565), fontFamily: 'MyriadPro'),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}


// -------------------------------------------
// -------------------------------------------

/// The hot offers slider

class HotOffersSlider extends StatefulWidget {
  final Function(int) onEventPressed;
  final List list;
  final Function onUpdateWishList;

  HotOffersSlider(
      {@required this.onEventPressed,
        @required this.list,
        @required this.onUpdateWishList});
  @override
  _HotOffersSliderState createState() => _HotOffersSliderState();
}

class _HotOffersSliderState extends State<HotOffersSlider> {
  int _current = 0;
  static List _list = List();
  CarouselSlider _carouselSlider;
  List child;
  List<Map> paisList = List();

  @override
  void initState() {
    _list = widget.list;
    super.initState();

    for (int i = 0; i < _list.length; i++) {
      Map pairs = Map();
      int first = i * 2;
      int second = first + 1;
      if (first >= _list.length) {
        break;
      } else {
        pairs['first'] = first;
      }

      if (second >= _list.length) {
        second = 0;
      }
      pairs['second'] = second;
      paisList.add(pairs);
    }

    child = map<Widget>(
      paisList,
          (index, i) {
        List list = List();
        if (paisList[index]['second'] > 0) {
          list.add(_list[paisList[index]['first']]);
          list.add(_list[paisList[index]['second']]);
        } else {
          list.add(_list[paisList[index]['first']]);
        }
        return HotOfferPage(
          list: list,
          onEventPressed: widget.onEventPressed,
          onUpdateWishList: widget.onUpdateWishList,
        );
      },
    ).toList();

    _carouselSlider = CarouselSlider(
      items: child,
      viewportFraction: 1.0,
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
        // The title
        Padding(
          padding: const EdgeInsets.all(7.0),
          child: Text(
            'Hot offers!',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xfffe6700),
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'Verdana',
            ),
          ),
        ),
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
                  width: _width > 350 ? 12.0 : 10.0,
                  height: _width > 350 ? 12.0 : 10.0,
                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
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

/// The hot offer page

class HotOfferPage extends StatelessWidget {
  final List list;

  final Function(int) onEventPressed;
  final Function onUpdateWishList;

  HotOfferPage(
      {@required this.list,
        @required this.onEventPressed,
        @required this.onUpdateWishList});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
      const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0, bottom: 0),
      child: GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: .9,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: NeverScrollableScrollPhysics(),
        children: List.generate(list.length, (index) {
          return HotOfferItem(
            imageUrl: '${Globals.imageBaseUrl}/${list[index]['logo']}',
            title: list[index]['name'],
            id: list[index]['id'],
            onEventPressed: onEventPressed,
            price: list[index]['price'],
            onUpdateWishList: onUpdateWishList,
          );
        }),
      ),
    );
  }
}


/// The hot offer item

class HotOfferItem extends StatefulWidget {
  final int id;
  final Function(int) onEventPressed;
  final String imageUrl;
  final String title;
  final double price;
  final Function onUpdateWishList;

  HotOfferItem(
      {@required this.id,
        @required this.onEventPressed,
        @required this.imageUrl,
        @required this.title,
        @required this.price,
        @required this.onUpdateWishList});

  @override
  _HotOfferItemState createState() => _HotOfferItemState();
}

class _HotOfferItemState extends State<HotOfferItem> {

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      shadowColor: Colors.black,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: () {
            widget.onEventPressed(widget.id);
          },
          child: Column(
//                mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Stack(
                  children: <Widget>[
                    Image.network(
                      widget.imageUrl,
                      fit: BoxFit.cover,
                      height: Platform.isIOS
                          ? 150 //for IOS
                          : 150, // for Android
                    ),
//                    Positioned(
//                      left: 10.0,
//                      child: Container(
//                        decoration: BoxDecoration(color: Colors.deepPurple),
//                        child: Padding(
//                          padding: const EdgeInsets.all(10.0),
//                          child: Text(
//                            'Sale',
//                            style: TextStyle(
//                                color: Color(0xffeaeae7), fontSize: 18),
//                          ),
//                        ),
//                      ),
//                    ),
                    Globals.skipped
                        ? Container()
                        : Positioned(
                        top: 5.0,
                        right: 5,
                        child: WishListButton(
                            onUpdateWishList: widget.onUpdateWishList,
                            eventId: widget.id
                        )
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Container(
                  height: 40,
                  child: Text(
                    widget.title,
                    style: TextStyle(
                        color: Color(0xff656565), fontFamily: 'MyriadPro'),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Color(0xffff6600),
                    borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Starts from ${widget.price} EGP',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 12
                    ),
                    textAlign: TextAlign.center,
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


/// The wish list button

class WishListButton extends StatefulWidget {

  final int eventId;
  final Function onUpdateWishList;

  WishListButton({@required this.eventId, @required this.onUpdateWishList});

  @override
  _WishListButtonState createState() => _WishListButtonState();
}

class _WishListButtonState extends State<WishListButton> {

  bool _addedToWishList = false;

  initValues() async{
    List response = await util.getWishList();
    if(response != null){
      for(int i = 0; i < response.length ; i++){
        if(response[i]['id'] == widget.eventId){
          _addedToWishList = true;
          break;
        }
      }
    }

  }

  @override
  void initState() {
    super.initState();
    if(!Globals.skipped)
      initValues();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: FutureBuilder(
        future: util.getWishList(),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.done){
            if(snapshot.hasData){
              List list = snapshot.data;
              if(list != null){
                for (int i = 0; i < list.length ; i++){
                  if(list[i]['id'] == widget.eventId){
                    _addedToWishList = true;
                    break;
                  }
                }
              }
            }
            return Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.deepOrange,
              ),
              child: IconButton(padding: EdgeInsets.only(top: 2),alignment: Alignment.center,
                  icon: Icon(
                    _addedToWishList?Icons.favorite:Icons.favorite_border,
                    color: Colors.white,
                    size: 30,
                  ),
                  onPressed: () async{
                    Map response = await util.addToRemoveFromWishList(widget.eventId);
                    if(response['result']){
                      setState(() {
                        _addedToWishList = _addedToWishList?false:true;
                      });
                    }
                    widget.onUpdateWishList();
                  }),
            );
          }
          return SpinKitFadingCircle(
            itemBuilder: (context , int index) {
              return DecoratedBox(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.deepOrange,
                ),
              );
            },
          );
        },
      ),
    );
  }
}