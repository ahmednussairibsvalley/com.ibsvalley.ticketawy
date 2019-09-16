import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'dashed_divider.dart';

class LocationPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, right: 50, left: 50,),
      child: ListView(
        shrinkWrap: true,
        itemExtent: 350,
        children: <Widget>[
          Material(
            elevation: 10,
            shadowColor: Colors.black,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Flexible(
                    child: LocationMap(),
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

