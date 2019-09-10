import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Widget _drawerItem(String title){
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text('$title',
            style: TextStyle(
                fontSize: 18,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: const DrawerDivider(color: Colors.grey),
        ),
      ],
    );
  }
  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;
    final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
    final _searchController = TextEditingController();

    final Map<String, Function> leftDrawerMap = {
      'Home' : (){
        Navigator.of(context).pop();
      },
      'My Profile' : (){
        Navigator.of(context).pop();
      },
      'FAQ' : (){
        Navigator.of(context).pop();
      },
      'Ideas' : (){
        Navigator.of(context).pop();
      },
      'Contact Us' : (){
        Navigator.of(context).pop();
      },
      'Sign Out' : (){
        Navigator.of(context).pop();
      },
    };

    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              Image.asset('assets/drawer_header.png', fit: BoxFit.cover,),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Column(
                  children: List.generate(leftDrawerMap.keys.toList().length, (index){
                    return ListTile(
                      title: _drawerItem(leftDrawerMap.keys.toList()[index]),
                      onTap: leftDrawerMap['${leftDrawerMap.keys.toList()[index]}'],
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
        body: Stack(
          children: <Widget>[

            // The background.
            Container(
              height: _height,
              width: _width,
              decoration: BoxDecoration(
                  color: Colors.deepPurple,
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.dstATop),
                      image: AssetImage('assets/background.png')
                  )
              ),
            ),

            // The header.
            Positioned(
              right: 0.0, left: 0.0, top: 0.0, bottom: 0.0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Image.asset('assets/logo.png', width: 70.4, height: 98.2,),
                    Text('Ticketawy',
                      style: TextStyle(
                        fontFamily: 'TicketawyFont',
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),

                    ),
                    Text('Ticket Easy!',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Umy',
                        fontWeight: FontWeight.bold,
                        color: Colors.orange.shade800,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // The top left icon.
            Positioned(
              left: 0.0, top: 0.0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: (){
                    _scaffoldKey.currentState.openDrawer();
                  },
                  child: Image.asset('assets/top_left_list_icon.png',
                    height: 40,
                    width: 40,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            // The top right icon.
            Positioned(
              right: 0.0, top: 0.0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  'assets/top_right_settings_icon.png',
                  height: 40,
                  width: 40,
                  color: Colors.white,
                  alignment: Alignment.topRight,
                ),
              ),
            ),

            // The body
            Positioned(
              bottom: 0.0, right: 0.0, left: 0.0,
              child: Column(
                children: <Widget>[

                  DrawerDivider(color: Colors.white, height: 2.3, width: 20,),

                  Stack(
                    children: <Widget>[

                      // The white background.
                      SizedBox(
                        width: _width,
                        height: _height * 0.6,
                        child: Container(
                          color: Colors.white,
                        ),
                      ),

                      // Here is the events data.
                      Positioned(
                        left: 0.0, right: 0.0, top: 0.0, bottom: 0.0,
                        child: Container(),
                      )
                    ],
                  ),
                ],
              ),
            ),





          ],
        ),
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




