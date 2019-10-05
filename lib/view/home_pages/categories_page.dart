import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../../globals.dart';
import '../../util.dart' as util;

List<T> map<T>(List list, Function handler) {
  List<T> result = [];
  for (var i = 0; i < list.length; i++) {
    result.add(handler(i, list[i]));
  }

  return result;
}

class AllCategoriesPage extends StatelessWidget {

  final Function(int, String) onCategoryPressed;
  final Function onPreviousPagePressed;
  final Function onAllEventsPressed;

  AllCategoriesPage({@required this.onCategoryPressed, @required this.onPreviousPagePressed, @required this.onAllEventsPressed});
  @override
  Widget build(BuildContext context) {
    Globals.pagesStack.push(PagesIndices.categoriesPageIndex);

    return Scaffold(
      body: FutureBuilder(
        future: util.categoryList(),
        builder: (context, snapshot){
          if(snapshot.hasData){
            Globals.controller.populateCategories(snapshot.data);
            return CategoriesPager(
                onCategoryPressed: onCategoryPressed,
              categoriesList: Globals.controller.categories,
            );
          }
          return Container();
        },
      ),

      // The footer buttons
      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: GestureDetector(
                onTap: (){
                  onPreviousPagePressed();
                },
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
                onTap: onAllEventsPressed,
                child: Container(
                  padding: EdgeInsets.all(15),
                  color: Color(0xff4b3d7a),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Image.asset('assets/all_events.png', width: 30, height: 30,),
                      Text(
                        'Home Page',
                        style: TextStyle(
                          color: Colors.white,fontFamily: 'MyriadPro',
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
}

class CategoriesPager extends StatefulWidget {

  final Function(int, String) onCategoryPressed;
  final List categoriesList;

  CategoriesPager({@required this.onCategoryPressed, @required this.categoriesList});

  @override
  _CategoriesPagerState createState() => _CategoriesPagerState();
}

class _CategoriesPagerState extends State<CategoriesPager> {
  int _current = 0;
  static List _list = List();
  CarouselSlider _carouselSlider;
  List child;
  List<Map> paisList = List();


  @override
  void initState() {
    super.initState();
    _list = widget.categoriesList;
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

        return CategoryItem(list: list, onCategoryPressed: widget.onCategoryPressed,);
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
                  _carouselSlider.animateToPage(_current, duration: Duration(milliseconds: 100), curve: Curves.linear);
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


class CategoryItem extends StatelessWidget {
  final List list;
  final Function(int, String) onCategoryPressed;

  CategoryItem({@required this.list, @required this.onCategoryPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1,
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
              onTap: (){
                onCategoryPressed(list[index].id, list[index].title);
              },
              child: Material(
                elevation: 5,
                shadowColor: Colors.black,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(child: Image.asset(list[index].imageUrl, fit: BoxFit.cover,)),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text('${list[index].title}'),
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
