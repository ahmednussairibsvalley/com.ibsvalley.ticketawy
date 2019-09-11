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
  final List child = map<Widget>(
    Globals.controller.events,
        (index, i) {
      return FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data) {
              return Image.network(i.imageUrl,
                fit: BoxFit.cover,
                height: MediaQuery.of(context).size.height / 10,
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
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Column(
          children: <Widget>[
            CarouselSlider(
              items: child,
//              aspectRatio: 1.0,
              viewportFraction: 1.0,
              onPageChanged: (index) {
                setState(() {
                  _current = index;
                });
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: map<Widget>(
                Globals.controller.events,
                    (index, url) {
                  return Container(
                    width: 20.0,
                    height: 20.0,
                    margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _current == index
                            ? Color(0xffed5e00)
                            : Color(0xff7e7e7e)),
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


