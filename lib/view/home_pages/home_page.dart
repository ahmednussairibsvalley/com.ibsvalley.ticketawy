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
              aspectRatio: 1.0, viewportFraction: 1.0,
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
                    width: 8.0,
                    height: 8.0,
                    margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _current == index
                            ? Color.fromRGBO(0, 0, 0, 0.9)
                            : Color.fromRGBO(0, 0, 0, 0.4)),
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



//class EventScroller extends StatefulWidget {
//  @override
//  _EventScrollerState createState() => _EventScrollerState();
//}
//
//class _EventScrollerState extends State<EventScroller> with TickerProviderStateMixin{
//  TabController _tabController;
//  int _currentPageIndex = 0;
//
//  @override
//  void initState() {
//    super.initState();
//    _tabController = TabController(
//      vsync: this,
//      length: Globals.controller.events.length,
//      initialIndex: _currentPageIndex,
//    );
//
//    _tabController.addListener((){
//      setState(() {
//        _currentPageIndex = _tabController.index;
//      });
////      print('$_currentPageIndex');
//    });
//
//  }
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      resizeToAvoidBottomPadding: false,
//      resizeToAvoidBottomInset: false,
//      body: TabBarView(
//        controller: _tabController,
//        children: List.generate(Globals.controller.events.length, (index){
//
//          return FutureBuilder(
//            future: util.isImageUrlAvailable(Globals.controller.events[index].imageUrl),
//            builder: (context, snapshot){
//              if(snapshot.connectionState == ConnectionState.done){
//                if(snapshot.hasData){
//                  return Padding(
//                    padding: const EdgeInsets.all(8.0),
//                    child: snapshot.data?
//                    Image.network('${Globals.controller.events[index].imageUrl}',)
//                        :Container(),
//                  );
//                }
//                return Container();
//              }
//              return Column(
//                mainAxisAlignment: MainAxisAlignment.center,
////                crossAxisAlignment: CrossAxisAlignment.center,
//                children: <Widget>[
//                  Container(
//                    height: 50,
//                    width: 50,
//                    child: CircularProgressIndicator(),
//                  )
//                ],
//              );
//            },
//          );
//        }),
//      ),
//    );
//  }
//}

