import 'package:flutter/material.dart';
import '../../globals.dart';
import '../../util.dart' as util;

class SearchResults extends StatelessWidget {
  final Function(int) onEventClicked;

  SearchResults({@required this.onEventClicked});
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: util.search(Globals.keyWord),
      builder: (context, snapshot){
        if(snapshot.connectionState == ConnectionState.done){
          if(snapshot.hasData){
            return EventsPage(
              onCategoryPressed: onEventClicked,
              list: snapshot.data,
            );
          }
          return Container();
        }
        return Container(
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircularProgressIndicator(),
            ],
          ),
        );
      },
    );
  }
}

class EventsPage extends StatelessWidget {
//  List list = Globals.controller.events;
  final List list;
  final Function(int) onCategoryPressed;

  EventsPage({@required this.list, @required this.onCategoryPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1,
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
                onCategoryPressed(list[index]['event_Id']);
              },
              child: Material(
                elevation: 5,
                shadowColor: Colors.black,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Column(
//                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Stack(
                        children: <Widget>[
                          Image.network(
                            'http://40.85.116.121:8606/EventsLogo/${list[index]['logo']}',
                            fit: BoxFit.cover,
                            alignment: Alignment.center,
                          ),
                          Globals.skipped?Container():Positioned(
                              top: 3.0,
                              right: 3,
                              child: Container(
                                width: 30,
                                height: 30,
                                decoration: new BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.deepOrange),
                                child: GestureDetector(
                                  child: IconButton(
                                      padding: EdgeInsets.only(top: 2),
                                      icon: Icon(
                                        Icons.favorite,
                                        color: Colors.white,
                                        size: 25,
                                      ),
                                      onPressed: (){Icon(Icons.favorite_border);}),
                                ),
                              )),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text('${list[index]['event_name']}'),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Color(0xffff6600),
                            borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            '${list[index]['price']} EGP / Ticket',
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