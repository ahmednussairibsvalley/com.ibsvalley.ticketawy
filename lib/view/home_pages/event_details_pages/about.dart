import 'dart:io';

import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:responsive_container/responsive_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';

import '../../../globals.dart';
import 'dashed_divider.dart';

import '../../../util.dart' as util;

class AboutPage extends StatelessWidget {

  final String eventName;
  final String eventDescription;
  final String imageUrl;
  final String startDate;
  final String endDate;

  AboutPage({@required this.eventName, @required this.eventDescription,
    @required this.imageUrl, @required this.startDate, @required this.endDate});

  @override
  Widget build(BuildContext context) {

    DateTime _startDate = DateTime.parse(startDate);
    DateTime _endDate = DateTime.parse(endDate);
//    String _startDateText = DateFormat.yMd().format(_startDate);
    String _startTimeText = DateFormat.jm().format(_startDate);



    return ResponsiveContainer(widthPercent: 90, heightPercent: 80,child: ListView(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: Platform.isIOS?0.0:1.0, bottom: 8.0, right: 25, left: 25),
          child: Material(
            elevation: 10,
            shadowColor: Colors.black,
            child: Stack(
              children: <Widget>[
                Column(
                  children: <Widget>[

                    // Event Image
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FutureBuilder(
                        future: util.isImageUrlAvailable(imageUrl),
                        builder: (context, snapshot){
                          if(snapshot.hasData){
                            if(snapshot.data){
                              return Image.network(imageUrl,
                                height: 185,
                                fit: BoxFit.fill,
                              );
                            }
                            return Container();
                          }
                          return Image.asset('assets/loading.png',
                            height: 185,
                            fit: BoxFit.fill,
                          );
                        },
                      ),
                    ),

                    // Event Title
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(eventName,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Color(0xffff6600),fontFamily: 'Verdana'
                        ),
                      ),
                    ),

                    // Event Description
                    Padding(
                      padding: const EdgeInsets.only(left:8.0, right: 8.0),
                      child: Container(
//                        height: 70,
                        child: Html(
                          data: eventDescription,
                        ),
                      ),
                    ),

                    // Dashed Line Divider
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DashedDivider(
                        height: 1,
                        width: 5,
                        color: Color(0xffb8b8b8),
                      ),
                    ),

                    // Time and Duration
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset('assets/event_time.png', width: 25, height: 25,),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text('Starts at:',style: TextStyle(fontFamily: 'Verdana',color: Color(0xff656565))),
                                Text(_startTimeText,
                                  style: TextStyle(
                                      color: Color(0xffff6600),
                                      fontFamily: 'Verdana'
                                  ),
                                ),
                              ],
                            ),
                          ],

                        ),
                        Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset('assets/event_duration.png', width: 25, height: 25,),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text('Duration:',style: TextStyle(fontFamily: 'Verdana',color: Color(0xff656565))),
                                Text('${_endDate.difference(_startDate).inDays} Day(s)',
                                  style: TextStyle(
                                      color: Color(0xffff6600),
                                      fontFamily: 'Verdana'
                                  ),
                                ),
                              ],
                            ),
                          ],

                        ),
                      ],
                    )
                  ],
                ),

                // Event Date
                Positioned(
                  top: 180.0, left: Platform.isIOS?70.0:70.0, right: Platform.isIOS?70.0:70.0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xffff6600),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text('${_startDate.year}-${_startDate.month}-${_startDate.day}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white
                        ),
                      ),
                    ),
                  ),
                ),

                // Wishlist icon
                Globals.skipped?Container():Positioned(
                    top: 15,
                    right: 25,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: new BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.deepOrange),
                      child: WishListButton(),
                    )),
              ],
            ),
          ),
        ),
      ],
    ),);
  }
}

class WishListButton extends StatefulWidget {
  @override
  _WishListButtonState createState() => _WishListButtonState();
}

class _WishListButtonState extends State<WishListButton> {

  bool _addedToWishList = false;

  initValues() async{
    List response = await util.getWishList();
    if(response != null){
      for(int i = 0; i < response.length ; i++){
        if(response[i]['id'] == Globals.eventId){
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
                  if(list[i]['id'] == Globals.eventId){
                    _addedToWishList = true;
                    break;
                  }
                }
              }
            }
            return IconButton(padding: EdgeInsets.only(top: 2),alignment: Alignment.center,
                icon: Icon(
                  _addedToWishList?Icons.favorite:Icons.favorite_border,
                  color: Colors.white,
                  size: 30,
                ),
                onPressed: () async{
                  Map response = await util.addToRemoveFromWishList(Globals.eventId);
                  if(response['result']){
                    setState(() {
                      _addedToWishList = _addedToWishList?false:true;
                    });
                  }
                });
          }
          return Container(
            child: Column(
              children: <Widget>[
                SpinKitFadingCircle(
                  itemBuilder: (context , int index) {
                    return DecoratedBox(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xffff6600),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

//class EventDescriptionViewer extends StatefulWidget {
//
//  final String eventDescription;
//
//  EventDescriptionViewer({@required this.eventDescription});
//  @override
//  _EventDescriptionViewerState createState() => _EventDescriptionViewerState();
//}
//
//class _EventDescriptionViewerState extends State<EventDescriptionViewer> {
//
//  final ScrollController _scrollController = ScrollController();
//
//  SingleChildScrollView _scrollView;
//
//  double _current = 0;
//  double _max = 100;
//
//  @override
//  void initState() {
//    super.initState();
////    _scrollView = SingleChildScrollView(
////      controller: _scrollController,
////      child: Text(widget.eventDescription,
////        style: TextStyle(fontFamily: 'Verdana',color: Color(0xff656565)),
////      ),
////    );
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return NotificationListener(
//      child: Stack(
//        children: <Widget>[
//          Html(data: widget.eventDescription,),
////          _current > 0?
////          Positioned(
////            top: 0.0, right: 0.0,
////            child: GestureDetector(
////                onTap: (){
////                },
////                child: Icon(Icons.arrow_drop_up, size: 50, color: Colors.black.withOpacity(0.3),)
////            ),
////          ):Container(),
////          _current < _max?
////          Positioned(
////            bottom: 0.0, right: 0.0,
////            child: GestureDetector(
////                onTap: (){
////                },
////                child: Icon(Icons.arrow_drop_down, size: 50, color: Colors.black.withOpacity(0.3),)
////            ),
////          ):Container(),
//        ],
//      ),
//      onNotification: (t){
//        if (t is ScrollEndNotification) {
//          _max = _scrollController.position.maxScrollExtent;
//          setState(() {
//            _current = _scrollController.position.pixels;
//          });
//        }
//        return null;
//      },
//    );
//  }
//}


