import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
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

class HomePage extends StatefulWidget {
  final Function(int, String) onPress;
  final Function(int) onEventPressed;
  final Function(int) onHotOfferPressed;

  HomePage(
      {@required this.onPress,
        @required this.onEventPressed,
        @required this.onHotOfferPressed});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FutureBuilder _eventsSlider;
  FutureBuilder _hotOffersSlider;

  @override
  void initState() {
    super.initState();
    _eventsSlider = FutureBuilder(
      future: util.getHomeEvents(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            Globals.controller.populateHomeEvents(snapshot.data);
            return EventsSlider(
              onEventPressed: widget.onEventPressed,
              list: Globals.controller.homeEvents,
              onUpdateWisthList: () {
                _updateHoteOffers();
              },
            );
          }
          return Container();
        }
        return Container(
          child: Column(
            children: <Widget>[
              CircularProgressIndicator(),
            ],
          ),
        );
      },
    );
    _hotOffersSlider = FutureBuilder(
      future: util.getHotEvents(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            Globals.controller.populateHotEvents(snapshot.data);
            return HotOffersSlider(
              onUpdateWishList: () {
                _updateHotEvents();
              },
              onEventPressed: widget.onHotOfferPressed,
              list: Globals.controller.hotEvents,
            );
          }
          return Container();
        }
        return Container(
          child: Column(
            children: <Widget>[
              CircularProgressIndicator(),
            ],
          ),
        );
      },
    );
  }

  _updateHotEvents() {
    setState(() {
      _eventsSlider = FutureBuilder(
        future: util.getHomeEvents(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              Globals.controller.populateHomeEvents(snapshot.data);
              return EventsSlider(
                onEventPressed: widget.onEventPressed,
                list: Globals.controller.homeEvents,
                onUpdateWisthList: () {
                  _updateHoteOffers();
                },
              );
            }
            return Container();
          }
          return Container(
            child: Column(
              children: <Widget>[
                CircularProgressIndicator(),
              ],
            ),
          );
        },
      );
    });
  }

  _updateHoteOffers() {
    setState(() {
      _hotOffersSlider = FutureBuilder(
        future: util.getHotEvents(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              Globals.controller.populateHotEvents(snapshot.data);
              return HotOffersSlider(
                onEventPressed: widget.onHotOfferPressed,
                list: Globals.controller.hotEvents,
                onUpdateWishList: () {
                  _updateHotEvents();
                },
              );
            }
            return Container();
          }
          return Container(
            child: Column(
              children: <Widget>[
                CircularProgressIndicator(),
              ],
            ),
          );
        },
      );
    });
  }

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
            return ListView(
              children: <Widget>[
                _eventsSlider,
                FutureBuilder(
                  future: util.categoryList(),
                  builder: (context, snapshot){
                    if(snapshot.connectionState == ConnectionState.done){
                      if(snapshot.hasData){
                        Globals.controller.populateCategories(snapshot.data);
                        return CategoriesSlider(
                          onPress: widget.onPress,
                        );
                      }
                      return Container();
                    }
                    return Container(
                      child: Column(
                        children: <Widget>[
                          CircularProgressIndicator(),
                        ],
                      ),
                    );
                  },
                ),
                _hotOffersSlider,
              ],
            );
          }
          return Center(
            child: Text('There is no connection'),
          );
        }
        return Container();
      },
    );
  }
}

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
          reservationOption: i.reservationOption,
          price: i.price,
          onEventPressed: onEventPressed,
          id: i.id,
          title: i.title,
          imageUrl: i.imageUrl,
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

class EventItem extends StatefulWidget {
  final int id;
  final int reservationOption;
  final String imageUrl;
  final String title;
  final double price;
  final Function(int) onEventPressed;
  final Function onUpdateWishList;

  EventItem(
      {@required this.id,
        @required this.reservationOption,
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                CircularProgressIndicator(),
              ],
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
    print('loaded');
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
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
    return SmartRefresher(
      enablePullDown: true,
      enablePullUp: true,
      onLoading: _onLoading,
      onRefresh: _onRefresh,
      controller: _refreshController,
      child: GestureDetector(
        onTap: () {
          Globals.reservationOption = widget.reservationOption;
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
                      width: widget.title.length > 20 ? 200 : 150,
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
                      alignment: Alignment.center,
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

class CategoriesSlider extends StatefulWidget {
  final Function(int, String) onPress;
  CategoriesSlider({@required this.onPress});
  @override
  _CategoriesSliderState createState() =>
      _CategoriesSliderState(onPress: onPress);
}

class _CategoriesSliderState extends State<CategoriesSlider> {
  int _current = 0;
  static final List _list = Globals.controller.categories;
  CarouselSlider _carouselSlider;
  List child;
  List<Map> paisList = List();

  final Function(int, String) onPress;

  _CategoriesSliderState({@required this.onPress});

  @override
  void initState() {
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
        return GestureDetector(
          onTap: () {
            onPress(list[index].id, list[index].title);
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
                          list[index].imageUrl,
                          fit: BoxFit.cover,
                        )),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        '${list[index].title}',
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
          padding: const EdgeInsets.all(8.0),
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
            imageUrl: list[index].imageUrl,
            title: list[index].title,
            id: list[index].id,
            onEventPressed: onEventPressed,
            price: list[index].price,
            reservationOption: list[index].reservationOption,
            onUpdateWishList: onUpdateWishList,
          );
        }),
      ),
    );
  }
}

class HotOfferItem extends StatefulWidget {
  final int id;
  final Function(int) onEventPressed;
  final int reservationOption;
  final String imageUrl;
  final String title;
  final double price;
  final Function onUpdateWishList;

  HotOfferItem(
      {@required this.id,
        @required this.onEventPressed,
        @required this.reservationOption,
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
            Globals.reservationOption = widget.reservationOption;
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
                    Positioned(
                      left: 10.0,
                      child: Container(
                        decoration: BoxDecoration(color: Colors.deepPurple),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            'Sale',
                            style: TextStyle(
                                color: Color(0xffeaeae7), fontSize: 18),
                          ),
                        ),
                      ),
                    ),
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
          return Container(
            child: Column(
              children: <Widget>[
                CircularProgressIndicator(),
              ],
            ),
          );
        },
      ),
    );
  }
}