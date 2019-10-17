import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:ticketawy/view/home_pages/event_details_pages/dashed_divider.dart';

import '../../../globals.dart';
import '../../../util.dart' as util;

class ProfileHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Connectivity().checkConnectivity(),
      builder: (context, snapshot){
        if(snapshot.hasData){
          if(snapshot.hasData){
            if (snapshot.data == ConnectivityResult.mobile ||
                snapshot.data == ConnectivityResult.wifi){
              return FutureBuilder(
                future: util.getOrdersHistory(),
                builder: (context, snapshot){
                  if(snapshot.hasData){
                    if(snapshot.data.length > 0){
                      return HistorySlider(
                        list: snapshot.data,
                      );
                    }
                    return Center(
                      child: Text('You don\'t have any orders'),
                    );
                  }
                  return Container();
                },
              );
            }
            return Center(
              child: Text('There is no connection'),
            );
          }
        }
        return Container();
      },
    );
  }
}


class HistorySlider extends StatefulWidget {

  final List list;

  HistorySlider({@required this.list});
  @override
  _HistorySliderState createState() => _HistorySliderState();
}

class _HistorySliderState extends State<HistorySlider> with TickerProviderStateMixin{

  TabController _tabController;
  List<Map> paisList = List();

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < widget.list.length; i++) {
      Map pairs = Map();
      int first = i * 2;
      int second = first + 1;
      if (first >= widget.list.length) {
        break;
      } else {
        pairs['first'] = first;
      }

      if (second >= widget.list.length) {
        second = 0;
      }
      pairs['second'] = second;
      paisList.add(pairs);
    }
    _tabController = TabController(
      vsync: this,
      length: paisList.length,
    );
  }
  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: _tabController,
      children: List.generate(_tabController.length, (index){
        List list = List();
        if (paisList[index]['second'] > 0) {
          list.add(widget.list[paisList[index]['first']]);
          list.add(widget.list[paisList[index]['second']]);
        } else {
          list.add(widget.list[paisList[index]['first']]);
        }
        return HistoryPage(list: list,);
      }),
    );
  }
}


class HistoryPage extends StatelessWidget {

  final List list;

  HistoryPage({@required this.list});
  @override
  Widget build(BuildContext context) {
    return GridView(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: .6,
          crossAxisSpacing: 1,
          mainAxisSpacing: 1),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      physics: NeverScrollableScrollPhysics(),
      children: List.generate(list.length, (index) {
        return HistoryItem(
          imageUrl: '${Globals.imageBaseUrl}/${list[index]['event_Logo']}',
          title: list[index]['event_Name'],
          code: '#${list[index]['order_Id']}',
        );
      }),
    );
  }
}

class HistoryItem extends StatelessWidget {

  final String imageUrl;
  final String title;
  final String code;


  HistoryItem({Key key, @required this.imageUrl, @required this.title, @required this.code}):  super(key: key);
  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        elevation: 10,
        shadowColor: Colors.black,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[

              Image.network(imageUrl,
                height: MediaQuery.of(context).size.height / 10,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.fill,
              ),

              // Event title
              Padding(
                padding: const EdgeInsets.only(top: 4.0, right: 4.0, left: 4.0),
                child: Container(
                  height: title.length > 20 ? 90 : 50 ,
                  child: Text(title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 18
                    ),
                  ),
                ),
              ),



              // Divider
              Padding(
                padding: EdgeInsets.only(top: 4.0, right: 4.0, left: 4.0),
                child: DashedDivider(
                  height: 1,
                  width: 5,
                  color: Colors.grey,
                ),
              ),

              // code
              Padding(
                padding: const EdgeInsets.only(top: 4.0, right: 4.0, left: 4.0),
                child: Text(code,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 18
                  ),
                ),
              ),

              // Ticket Type
              Padding(
                padding: const EdgeInsets.only(top: 4.0, right: 4.0, left: 8.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Color(0xfffe6700),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 4 , bottom: 4 , left: 9 , right: 9),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Flexible(child: Image.asset('assets/ticket_type.png', width: 35, height: 35,)),
                        Flexible(
                          child: Text('Class A 120 EGP',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Delete history
//              Padding(
//                padding: const EdgeInsets.only(top: 8.0, right: 4.0, left: 4.0),
//                child: Container(
//                  decoration: BoxDecoration(
//                    borderRadius: BorderRadius.circular(30),
//                    color: Color(0xfffe6700),
//                  ),
//                  child: Padding(
//                    padding: const EdgeInsets.only(top: 4 , bottom: 4 , left: 9 , right: 9),
//                    child: Row(
//                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                      children: <Widget>[
//                        Image.asset('assets/delete_history.png', width: 35, height: 35,),
//                        Text('Delete history',
//                          textAlign: TextAlign.center,
//                          style: TextStyle(
//                            color: Colors.white,
//                          ),
//                        ),
//                      ],
//                    ),
//                  ),
//                ),
//              ),


            ],
          ),
        ),
      ),
    );
  }
}

