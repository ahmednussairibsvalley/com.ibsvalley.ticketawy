import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../../globals.dart';
import '../../util.dart' as util;

List<T> map<T>(List list, Function handler) {
  List<T> result = [];
  for (var i = 0; i < list.length; i++) {
    result.add(handler(i, list[i]));
  }

  return result;
}

class HomePage extends StatelessWidget {
  final Function onPress;
  final Function onEventPressed;
  final Function onHotOfferPressed;

  HomePage({@required this.onPress, @required this.onEventPressed, @required this.onHotOfferPressed});

  @override
  Widget build(BuildContext context) {
    Globals.pagesStack.push(PagesIndices.homePageIndex);

    return ListView(
      children: <Widget>[
        EventsSlider(
          onEventPressed: onEventPressed,
        ),
        CategoriesSlider(onPress: onPress,),
        HotOffersSlider(onEventPressed: onHotOfferPressed,),
      ],
    );
  }
}


class EventsSlider extends StatefulWidget {
  final Function onEventPressed;
  EventsSlider({@required this.onEventPressed});
  @override
  _EventsSliderState createState() => _EventsSliderState(
    onEventPressed: onEventPressed,
  );
}

class _EventsSliderState extends State<EventsSlider> {
  int _current = 0;
  static final List _list = Globals.controller.events;
  CarouselSlider _carouselSlider;
  PageController _pageController;
  List child;

  final Function onEventPressed;

  _EventsSliderState({@required this.onEventPressed});

  @override
  void initState() {
    super.initState();
    child = map<Widget>(
      _list,
          (index, i) {
        return FutureBuilder(
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data) {
                return GestureDetector(
                  onTap: (){
                    Globals.reservationOption = i.reservationOption;
                    onEventPressed();
                  },
                  child: Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Material(
                          elevation: 5.0,
                          shadowColor: Colors.black,
                          child: Container(

                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.network(i.imageUrl,
                                fit: BoxFit.cover,
                                height: MediaQuery.of(context).size.height / 10,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        right: 0.0,
                        left: 0.0,
                        bottom: 0.0,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 50, left: 50, bottom: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                  color: Color(0xffff6600),
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(15), bottomLeft: Radius.circular(15)),
                                ),
                                width: 150,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('${i.title}',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Color(0xffe75d02),
                                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(15), topRight: Radius.circular(15)),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('${i.price} \$',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                );
              } else {
                return Center(
                  child: Text('Image is not available',
                    textAlign: TextAlign.center,),
                );
              }
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 50,
                  width: 50,
                  child: CircularProgressIndicator(),
                )
              ],
            );
          },
          future: util.isImageUrlAvailable(i.imageUrl),
        );
      },
    ).toList();
    _carouselSlider = CarouselSlider(
      items: child,
      viewportFraction: 1.0,
      onPageChanged: (index) {
        setState(() {
          _current = index;
        });
      },
    );
    _pageController = _carouselSlider.pageController;
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
            _list, (index, url) {
              return GestureDetector(
                onTap: (){
                  setState(() {
                    _current = index;
                  });
                  _pageController.animateToPage(_current, duration: Duration(milliseconds: 100), curve: Curves.linear);
                },
                child: Container(
                  width: _width > 350? 12.0 : 10.0,
                  height: _width > 350? 12.0 : 10.0,
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

class CategoriesSlider extends StatefulWidget {

  final Function onPress;
  CategoriesSlider({@required this.onPress});
  @override
  _CategoriesSliderState createState() => _CategoriesSliderState(onPress: onPress);
}

class _CategoriesSliderState extends State<CategoriesSlider> {
  int _current = 0;
  static final List _list = Globals.controller.categories;
  CarouselSlider _carouselSlider;
  PageController _pageController;
  List child;
  List<Map> paisList = List();

  final Function onPress;

  _CategoriesSliderState({@required this.onPress});


  @override
  void initState() {
    super.initState();




    for(int i = 0; i < _list.length; i++){
      Map pairs = Map();
      int first = i * 2;
      int second = first + 1;
      if(first >= _list.length){
        break;
      } else {
        pairs['first'] = first;
      }

      if(second >= _list.length){
        second = 0;
      }
      pairs['second'] = second;
      paisList.add(pairs);
    }

    child = map<Widget>(
      paisList,
          (index, i) {
        List list = List();
        if(paisList[index]['second'] > 0){
          list.add(_list[paisList[index]['first']]);
          list.add(_list[paisList[index]['second']]);
        } else {
          list.add(_list[paisList[index]['first']]);
        }
        return CategoriesPage(list: list, onPress: onPress,);
      },
    ).toList();

    _carouselSlider = CarouselSlider(
      items: child,
      viewportFraction: 1.0,
      onPageChanged: (index) {
        setState(() {
          _current = index;
        });
      },
    );

    _pageController = _carouselSlider.pageController;
  }
  @override
  Widget build(BuildContext context) {

    final _width = MediaQuery.of(context).size.width;
    return Container(
      color: Color(0xfff0f0f0),
      child: Column(
        children: <Widget>[

          _carouselSlider,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: map<Widget>(
              paisList,
                  (index, url) {
                return GestureDetector(
                  onTap: (){
                    setState(() {
                      _current = index;
                    });
                    _pageController.animateToPage(_current, duration: Duration(milliseconds: 100), curve: Curves.linear);
                  },
                  child: Container(
                    width:  _width > 350? 12.0 : 10.0,
                    height:  _width > 350? 12.0 : 10.0,
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
          ),
        ],
      ),
    );
  }
}


class CategoriesPage extends StatelessWidget {

  final List list;
  final Function onPress;

  CategoriesPage({@required this.list, @required this.onPress});

  @override
  Widget build(BuildContext context) {
    return GridView(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: .9,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5
      ),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      physics: NeverScrollableScrollPhysics(),
      children: List.generate(list.length, (index){
        return GestureDetector(
          onTap: (){
            onPress();
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
                    Expanded(child: Image.network(list[index].imageUrl, fit: BoxFit.cover,)),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text('${list[index].title}',
                        style: TextStyle(
                            color: Color(0xff656565),
                            fontFamily: 'MyriadPro'
                        ),
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

  final Function onEventPressed;

  HotOffersSlider({@required this.onEventPressed});
  @override
  _HotOffersSliderState createState() => _HotOffersSliderState();
}

class _HotOffersSliderState extends State<HotOffersSlider> {
  int _current = 0;
  static final List _list = Globals.controller.events;
  CarouselSlider _carouselSlider;
  PageController _pageController;
  List child;
  List<Map> paisList = List();


  @override
  void initState() {
    super.initState();

    for(int i = 0; i < _list.length; i++){
      Map pairs = Map();
      int first = i * 2;
      int second = first + 1;
      if(first >= _list.length){
        break;
      } else {
        pairs['first'] = first;
      }

      if(second >= _list.length){
        second = 0;
      }
      pairs['second'] = second;
      paisList.add(pairs);
    }

    child = map<Widget>(
      paisList,
          (index, i) {
        List list = List();
        if(paisList[index]['second'] > 0){
          list.add(_list[paisList[index]['first']]);
          list.add(_list[paisList[index]['second']]);
        } else {
          list.add(_list[paisList[index]['first']]);
        }
        return HotOfferPage(list: list, onEventPressed: widget.onEventPressed,);
      },
    ).toList();

    _carouselSlider = CarouselSlider(
      items: child,
      viewportFraction: 1.0,
      onPageChanged: (index) {
        setState(() {
          _current = index;
        });
      },
    );

    _pageController = _carouselSlider.pageController;
  }
  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    return Column(
      children: <Widget>[
        // The title
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Hot offers!',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Color(0xfffe6700),
                fontSize: 18, fontWeight: FontWeight.bold,
              fontFamily: 'Verdana',
            ),
          ),
        ),
        _carouselSlider,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: map<Widget>(
            paisList,
                (index, url) {
              return GestureDetector(
                onTap: (){

                  setState(() {
                    _current = index;
                  });
                  _pageController.animateToPage(_current, duration: Duration(milliseconds: 100), curve: Curves.linear);

                },
                child: Container(
                  width:  _width > 350? 12.0 : 10.0,
                  height:  _width > 350? 12.0 : 10.0,
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
        ),
      ],
    );
  }
}



class HotOfferPage extends StatelessWidget {
  final List list;

  final Function onEventPressed;

  HotOfferPage({@required this.list, @required this.onEventPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0, bottom: 0),
      child: GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          childAspectRatio: .9,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5
        ),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: NeverScrollableScrollPhysics(),
        children: List.generate(list.length, (index){
          return Material(
            elevation: 5,
            shadowColor: Colors.black,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: (){
                  Globals.reservationOption = list[index].reservationOption;
                  onEventPressed();
                },
                child: Column(
//                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(child: Image.network(list[index].imageUrl, fit: BoxFit.cover,)),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text('${list[index].title}',
                        style: TextStyle(
                          color: Color(0xff656565),
                          fontFamily: 'MyriadPro'
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Color(0xffff6600),
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('${list[index].price}\$ / Ticket',
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
          );
        }),
      ),
    );
  }
}





