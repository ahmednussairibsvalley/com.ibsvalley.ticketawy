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



  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {

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

    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;


    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        resizeToAvoidBottomPadding: false,
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
              right: 0.0, left: 0.0, top: 0.0,
              child: Image.asset('assets/header.png', width: 193.2, height: 170.4,),
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

                  Stack(
                    children: <Widget>[
                      DrawerDivider(color: Colors.white, height: 2.3, width: 15,),
                    ],
                  ),

                  Stack(
                    children: <Widget>[

                      // The white background.
                      SizedBox(
                        width: _width,
                        height: _height * 0.65,
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


            Positioned(
              right: 50.0, left: 50.0, bottom: _height * .6,
              child: Material(
                color: Colors.transparent,
                elevation: 20.0,
                shadowColor: Colors.black,
                child: TextFormField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    suffixIcon: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.search, size: 40,),
                    ),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            width: 1,
                          )
                      )
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




