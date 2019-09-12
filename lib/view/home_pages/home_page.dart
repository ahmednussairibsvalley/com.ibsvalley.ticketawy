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

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _current = 0;
  CarouselSlider _carouselSlider;
  PageController _pageController;
  final List child = map<Widget>(
    Globals.controller.events,
        (index, i) {
      return FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data) {
              return Padding(
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
              );
            } else {
              return Center(
                child: Text('Product Image is not available',
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
    return ListView(
      children: <Widget>[
        Column(
          children: <Widget>[
            _carouselSlider,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: map<Widget>(
                Globals.controller.events,
                    (index, url) {
                  return GestureDetector(
                    onTap: (){
                      setState(() {
                        _current = index;
                      });
                      _pageController.animateToPage(_current, duration: Duration(milliseconds: 100), curve: Curves.linear);
                    },
                    child: Container(
                      width: 15.0,
                      height: 15.0,
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
        )
      ],
    );
  }
}


