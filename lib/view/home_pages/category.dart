import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../globals.dart';

List<T> map<T>(List list, Function handler) {
  List<T> result = [];
  for (var i = 0; i < list.length; i++) {
    result.add(handler(i, list[i]));
  }

  return result;
}

class CategoryPage extends StatelessWidget {
  
  final Function onBack;
  
  CategoryPage({@required this.onBack});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(

          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Category name here',
                    style: TextStyle(
                      color: Color(0xffff6600),
                      fontSize: 17,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color(0xffff6600),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(right: 10, left: 10, top: 5, bottom: 5),
                      child: Text('Filter By',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              child: ListView(
                children: <Widget>[
                  EventsSlider()
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
                        Image.asset('assets/back.png', width: 30, height: 30,),
                        Text(
                          'Previous Page',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(15),
                  color: Colors.purple,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Image.asset('assets/all_events.png', width: 30, height: 30,),
                      Text(
                        'All Events',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
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

class EventsSlider extends StatefulWidget {
  @override
  _EventsSliderState createState() => _EventsSliderState();
}

class _EventsSliderState extends State<EventsSlider> {
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
      int first = i * 4;
      int second = first + 1;
      int third = second + 1;
      int fourth = third + 1;
      if(first >= _list.length){
        break;
      } else {
        pairs['first'] = first;
      }

      if(second >= _list.length){
        second = 0;
      }
      pairs['second'] = second;

      if(third >= _list.length){
        paisList.add(pairs);
        break;
      } else {
        pairs['third'] = third;
      }

      if(fourth >= _list.length){
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

        if(paisList[index]['second'] > 0){
          list.add(_list[paisList[index]['second']]);
        }

        if(paisList[index].containsKey('third')){
          if(paisList[index]['third'] > 0){
            list.add(_list[paisList[index]['third']]);
          }
        }

        if(paisList[index].containsKey('fourth')){
          if(paisList[index]['fourth'] > 0){
            list.add(_list[paisList[index]['fourth']]);
          }
        }

        return EventsPage(list: list,);
      },
    ).toList();

    _carouselSlider = CarouselSlider(
      items: child,
      viewportFraction: 1.0,
      aspectRatio: 1.0,
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
    return Column(
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
    );
  }
}

class EventsPage extends StatelessWidget {

//  List list = Globals.controller.events;
  final List list;

  EventsPage({@required this.list});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
//          childAspectRatio: 1,
            crossAxisSpacing: 1,
            mainAxisSpacing: 1
        ),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: NeverScrollableScrollPhysics(),
        children: List.generate(list.length, (index){
          return Padding(
            padding: const EdgeInsets.all(2.0),
            child: Material(
              elevation: 5,
              shadowColor: Colors.black,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
//                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(child: Image.network(list[index].imageUrl, fit: BoxFit.cover,)),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text('${list[index].title}'),
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


