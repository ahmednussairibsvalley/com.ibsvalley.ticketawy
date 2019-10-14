import 'dart:io';

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
    String _startDateText = DateFormat.yMd().format(_startDate);
    String _startTimeText = DateFormat.jm().format(_startDate);

    return ListView(
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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(eventName,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Color(0xffff6600),fontFamily: 'Verdana'
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left:8.0, right: 8.0),
                      child: Container(
                        height: 100,
                        child: Scrollable(
                          viewportBuilder: (BuildContext context, ViewportOffset position) {
                            return SingleChildScrollView(
                              child: Text(eventDescription,
                                style: TextStyle(fontFamily: 'Verdana',color: Color(0xff656565)),
                              ),
                            );
                          },
                          
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DashedDivider(
                        height: 1,
                        width: 5,
                        color: Color(0xffb8b8b8),
                      ),
                    ),
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
                                Text('${_endDate.difference(_startDate).inDays} Days',
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
                Positioned(
                  top: 180.0, left: Platform.isIOS?70.0:70.0, right: Platform.isIOS?70.0:70.0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xffff6600),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(_startDateText,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white
                        ),
                      ),
                    ),
                  ),
                ),
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
    );
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
            return IconButton(padding: EdgeInsets.only(top: 2),
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
                CircularProgressIndicator(),
              ],
            ),
          );
        },
      ),
    );
  }
}

