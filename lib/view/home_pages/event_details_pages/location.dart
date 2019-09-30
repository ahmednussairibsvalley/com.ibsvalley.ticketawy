import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'dashed_divider.dart';

class LocationPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, right: 50, left: 50,),
      child: ListView(
        shrinkWrap: true,
        itemExtent: _width > 360?350:270,
        children: <Widget>[
          Material(
            elevation: 10,
            shadowColor: Colors.black,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Flexible(
                    child: LocationMap2(),
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
                              Text('09:00 am',
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
                              Text('2 Days',
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
          )
        ],
      ),
    );
  }
}

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

class LocationMap2 extends StatefulWidget {
  @override
  _LocationMap2State createState() => _LocationMap2State();
}

class _LocationMap2State extends State<LocationMap2> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 370,
        width: 370,
        child: WebView(
          initialUrl: Uri.dataFromString('<html><body><iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3454.4121109128837!2d31.213833215114693!3d30.025032681889385!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x145847cdee4f6545%3A0x8e04c3152a2d7f4e!2sGiza%20Zoological%20Garden!5e0!3m2!1sen!2seg!4v1568237729053!5m2!1sen!2seg" width="370" height="370" frameborder="0" style="border:0;" allowfullscreen=""></iframe></body></html>', mimeType: 'text/html').toString(),
          javascriptMode: JavascriptMode.unrestricted,


        ));
  }
}


