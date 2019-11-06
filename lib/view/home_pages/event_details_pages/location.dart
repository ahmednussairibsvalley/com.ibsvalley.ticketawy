import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:responsive_container/responsive_container.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'dashed_divider.dart';
import 'event_map.dart';

class LocationPage extends StatelessWidget {
  final String mapUrl;
  final String startDate;
  final String endDate;

  LocationPage({@required this.mapUrl, @required this.startDate, @required this.endDate});
  @override
  Widget build(BuildContext context) {
    DateTime _startDate = DateTime.parse(startDate);
    DateTime _endDate = DateTime.parse(endDate);
    String _startTimeText = DateFormat.jm().format(_startDate);
    return ResponsiveContainer(widthPercent: 90, heightPercent: 80,
      padding: EdgeInsets.only( right: 15, left: 15, bottom: 15),
//      child: LocationMap2(mapUrl: mapUrl),
      child: Column(
        children: <Widget>[
          Flexible(
            child: Material(
              elevation: 10,
              shadowColor: Colors.black,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    Flexible(
                      child: LocationMap2(
                        mapUrl: mapUrl,
                      ),
                    ),
                  GestureDetector(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>LargerMap(url: mapUrl,)));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xffff6600),
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('View Larger Map',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontFamily: 'Verdana', color: Colors.white),
                        ),
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
                                Text('Starts at:',style: TextStyle(fontFamily: 'Verdana',color: Color(0xff656565)),),
                                Text(_startTimeText,
                                  style: TextStyle(
                                    color: Color(0xffff6600),
                                    fontFamily: 'Verdana',
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
                                Text('Duration:', style: TextStyle(fontFamily: 'Verdana',color: Color(0xff656565)),),
                                Text('${_endDate.difference(_startDate).inDays} Days',
                                  style: TextStyle(
                                    color: Color(0xffff6600),
                                    fontFamily: 'Verdana',
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
          )
        ],
      ),
    );
  }
}

// *****************************************
// *****************************************

class LocationMap extends StatefulWidget {
  @override
  _LocationMapState createState() => _LocationMapState();
}

class _LocationMapState extends State<LocationMap> {
  GoogleMapController mapController;

  final LatLng _center = const LatLng(45.521563, -122.677433);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      onMapCreated: _onMapCreated,
      initialCameraPosition: CameraPosition(
        target: _center,
        zoom: 15.0,
      ),
      markers: Set<Marker>.of([Marker(markerId: MarkerId('Test'), position: LatLng(45.521563, -122.677433))]),
    );
  }
}

// *****************************************
// *****************************************

class LocationMap2 extends StatefulWidget {
  final String mapUrl;

  LocationMap2({@required this.mapUrl});
  @override
  _LocationMap2State createState() => _LocationMap2State();
}

class _LocationMap2State extends State<LocationMap2> {
  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    return Container(
//        height: Platform.isIOS?230:370,
//        width: Platform.isIOS?270:370,
        height: _height,
        width: _width,
        child: WebView(

          initialUrl: Uri.dataFromString('<html><body><center><iframe src=${widget.mapUrl} height=$_height width=$_width frameborder=0 style=border:0; align=middle allowfullscreen="" marginheight=0 marginwidth=0></iframe></center></body></html>', mimeType: 'text/html').toString(),
          javascriptMode: JavascriptMode.unrestricted,

        ),
    );
  }
}

//Navigator.of(context).push(MaterialPageRoute(builder: (context)=>LargerMap(url: widget.mapUrl,)));
