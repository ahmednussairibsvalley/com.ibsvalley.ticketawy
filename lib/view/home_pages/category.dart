import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../custom_widgets/CustomShowDialog.dart';

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
  final Function onCategoryPressed;
  final Function onAllCategoriesPressed;
  
  CategoryPage({@required this.onBack, @required this.onCategoryPressed, @required this.onAllCategoriesPressed});

  @override
  Widget build(BuildContext context) {
    Globals.pagesStack.push(PagesIndices.categoryPageIndex);
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
                  GestureDetector(
                    onTap: (){
                      _showFilterDialog(context);
                    },
                    child: Container(
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
                  ),
                ],
              ),
            ),
            Flexible(
              child: ListView(
                children: <Widget>[
                  EventsSlider(onCategoryPressed: onCategoryPressed,)
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
                child: GestureDetector(
                  onTap: onAllCategoriesPressed,
                  child: Container(
                    padding: EdgeInsets.all(15),
                    color: Colors.purple,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Image.asset('assets/all_events.png', width: 30, height: 30,),
                        Text(
                          'All Categories',
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
            ],
          ),
        ),
      ),
    );
  }

  _showFilterDialog(BuildContext context){


    showDialog(
        context: context,
        builder: (context){
          return CustomAlertDialog(
            titlePadding: EdgeInsets.all(0),
            contentPadding: EdgeInsets.all(0),
            content: Container(
              width: 300.0,
              height: 430.0,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(33.0)),
              ),

              child: FiterDialog(),
            ),
          );
        }
    );
  }
}

class EventsSlider extends StatefulWidget {
  final Function onCategoryPressed;

  EventsSlider({@required this.onCategoryPressed});
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

        return EventsPage(list: list, onCategoryPressed: widget.onCategoryPressed,);
      },
    ).toList();

    _carouselSlider = CarouselSlider(
      items: child,
      viewportFraction: .95,
      aspectRatio: 1.185,
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
  final Function onCategoryPressed;

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
            mainAxisSpacing: 1
        ),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: NeverScrollableScrollPhysics(),
        children: List.generate(list.length, (index){
          return Padding(
            padding: const EdgeInsets.all(2.0),
            child: GestureDetector(
              onTap: onCategoryPressed,
              child: Material(
                elevation: 5,
                shadowColor: Colors.black,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
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
                          padding: const EdgeInsets.all(4.0),
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

  const DrawerDivider({this.height = 1, this.color = Colors.black, this.width = 10});
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
  List _dateList = [
    '01 / 05 / 2020',
    '01 / 12 / 2019',
    '20 / 10 / 2019',
    '15 / 11 / 2019',
  ];

  List _timeList = [
    '10:30 PM',
    '10:00 AM',
    '4:00 PM',
    '3:00 PM',
  ];

  List _cityList = [
    'Cairo',
    'Alexandria',
    'Mansoura',
    'Marsa Matroh',
  ];

  List _categoryList = [
    'Sports Events',
    'Ceremony Events',
    'School Events',
    'Adventure Events',
  ];

  String _dateValue;
  String _timeValue;
  String _cityValue;
  String _categoryValue;

  @override
  void initState() {
    super.initState();
    _dateValue = _dateList[0];
    _timeValue = _timeList[0];
    _cityValue = _cityList[0];
    _categoryValue = _categoryList[0];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 10),
          child: Text('Filter By',
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

        // Date Filter
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text('Date'),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0, bottom: 15.0),
              child: Container(
                padding: EdgeInsets.only(right: 10, left: 10,),
                decoration: ShapeDecoration(
                  color: Color(0xffeeeeee),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 1.0, style: BorderStyle.none),
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  ),
                ),
                child: DropdownButton(
                  icon: Icon(Icons.expand_more),
                  value: _dateValue,
                  onChanged: (value){
                    setState(() {
                      _dateValue = value;
                    });
                  },
                  items: List.generate(_dateList.length, (index){
                    return DropdownMenuItem(
                      value: _dateList[index],
                      child: Container(
                        width: 150,
                        child: Text('${_dateList[index]}'),
                      ),
                    );
                  }),
                ),
              ),
            ),
          ],
        ),

        // Time Filter
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text('Time'),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0, bottom: 15.0),
              child: Container(
                padding: EdgeInsets.only(right: 10, left: 10,),
                decoration: ShapeDecoration(
                  color: Color(0xffeeeeee),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 1.0, style: BorderStyle.none),
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  ),
                ),
                child: DropdownButton(
                  icon: Icon(Icons.expand_more),
                  value: _timeValue,
                  onChanged: (value){
                    setState(() {
                      _timeValue = value;
                    });
                  },
                  items: List.generate(_timeList.length, (index){
                    return DropdownMenuItem(
                      value: _timeList[index],
                      child: Container(
                        width: 150,
                        child: Text('${_timeList[index]}'),
                      ),
                    );
                  }),
                ),
              ),
            ),
          ],
        ),

        // City Filter
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 20.0, ),
              child: Text('City'),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0, bottom: 15.0),
              child: Container(
                padding: EdgeInsets.only(right: 10, left: 10,),
                decoration: ShapeDecoration(
                  color: Color(0xffeeeeee),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 1.0, style: BorderStyle.none),
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  ),
                ),
                child: DropdownButton(
                  icon: Icon(Icons.expand_more),
                  value: _cityValue,
                  onChanged: (value){
                    setState(() {
                      _cityValue = value;
                    });
                  },
                  items: List.generate(_cityList.length, (index){
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

        // Category Filter
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text('Category'),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0, bottom: 15.0),
              child: Container(
                padding: EdgeInsets.only(right: 10, left: 10,),
                decoration: ShapeDecoration(
                  color: Color(0xffeeeeee),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 1.0, style: BorderStyle.none),
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  ),
                ),
                child: DropdownButton(
                  icon: Icon(Icons.expand_more),
                  value: _categoryValue,
                  onChanged: (value){
                    setState(() {
                      _categoryValue = value;
                    });
                  },
                  items: List.generate(_categoryList.length, (index){
                    return DropdownMenuItem(
                      value: _categoryList[index],
                      child: Container(
                        width: 150,
                        child: Text('${_categoryList[index]}'),
                      ),
                    );
                  }),
                ),
              ),
            ),
          ],
        ),

        ListTile(
          onTap: (){
            Navigator.of(context).pop();
          },
          title: Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              child: Text('Filter',
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
    );
  }
}


