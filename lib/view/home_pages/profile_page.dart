import 'package:flutter/material.dart';
import 'profile_pages/history.dart';
import 'profile_pages/info.dart';

final int infPageIndex = 0;
final int historyPageIndex = 1;

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  int _pageIndex;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageIndex = infPageIndex;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          // The title
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('My Profile',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xfffe6700),
                fontSize: 25,
              ),
            ),
          ),

          // Profile tabs
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              //Info tab
              GestureDetector(
                onTap: (){
                  setState(() {
                    setState(() {
                      _pageIndex = infPageIndex;
                    });
                  });
                },
                child: Container(
                  width: 130,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text('My Info',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xfffe6700),
                        fontSize: 20,
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: _pageIndex == infPageIndex? Color(0xffd3d3d3): Color(0xffe6e6e6),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        topLeft: Radius.circular(20)
                    ),
                  ),
                ),
              ),

              // History tab
              GestureDetector(
                onTap: (){
                  setState(() {
                    _pageIndex = historyPageIndex;
                  });
                },
                child: Container(
                  width: 130,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text('My History',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color(0xfffe6700),
                        fontSize: 20,
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: _pageIndex == historyPageIndex? Color(0xffd3d3d3): Color(0xffe6e6e6),
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(20),
                        topRight: Radius.circular(20)
                    ),
                  ),
                ),
              )
            ],
          ),
          Container(
            alignment: Alignment.center,
            child: _pageIndex == infPageIndex? ProfileInfo():
            _pageIndex == historyPageIndex? ProfileHistory():
            Container(),
          )

        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Container(
                padding: EdgeInsets.all(15),
                color: Color(0xfffe6700),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Image.asset('assets/back.png', width: 30, height: 30,),
                    Text(
                      'Previous Page',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(15),
                color: Colors.purple,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Image.asset('assets/all_events.png', width: 30, height: 30,),
                    Text(
                      'All Events',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

