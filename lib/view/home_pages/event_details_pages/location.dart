import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';

import 'dashed_divider.dart';

class LocationPage extends StatelessWidget {

  final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  checkThePlatform() async{
    if(Platform.isAndroid){
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      print('${androidInfo.version.sdkInt}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, right: 50, left: 50),
          child: Material(
            elevation: 10,
            shadowColor: Colors.black,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset('assets/map.png',
                    fit: BoxFit.fill,
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
                            Text('Starts at:'),
                            Text('09:00 am',
                              style: TextStyle(
                                color: Color(0xffff6600),
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
                            Text('Duration:'),
                            Text('2 Days',
                              style: TextStyle(
                                color: Color(0xffff6600),
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
          ),
        ),
      ],
    );
  }
}

//class LocationMap extends StatefulWidget {
//  @override
//  _LocationMapState createState() => _LocationMapState();
//}
//
//class _LocationMapState extends State<LocationMap> {
//  GoogleMapController mapController;
//
//  final LatLng _center = const LatLng(45.521563, -122.677433);
//
//  void _onMapCreated(GoogleMapController controller) {
//    mapController = controller;
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return GoogleMap(
//      onMapCreated: _onMapCreated,
//      initialCameraPosition: CameraPosition(
//        target: _center,
//        zoom: 11.0,
//      ),
//
//        gestureRecognizers: Set()
//          ..add(Factory<PanGestureRecognizer>(() => PanGestureRecognizer()))
//    );
//  }
//}

