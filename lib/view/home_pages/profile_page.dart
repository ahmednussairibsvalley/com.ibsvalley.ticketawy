import 'package:flutter/material.dart';
import '../../globals.dart';
import 'profile_pages/history.dart';
import 'profile_pages/info.dart';

final int infPageIndex = 0;
final int historyPageIndex = 1;

class ProfilePage extends StatelessWidget {
  final Function onPreviousPagePressed;
  final Function onAllCategoriesPressed;
  final Function onWillPop;
  final Function(String) onHistoryItemPressed;

  ProfilePage({@required this.onPreviousPagePressed,
    @required this.onAllCategoriesPressed,
    @required this.onWillPop, @required this.onHistoryItemPressed});

  @override
  Widget build(BuildContext context) {
    if(Globals.pagesStack.top() != PagesIndices.profilePageIndex)
      Globals.pagesStack.push(PagesIndices.profilePageIndex);

    return WillPopScope(
      onWillPop: () async{
        onWillPop();
        return null;
      },
      child: Scaffold(
        body: ProfileTabs(
          onHistoryItemPressed: onHistoryItemPressed,
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.black,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: GestureDetector(
                  onTap: onPreviousPagePressed,
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
                            color: Colors.white,fontFamily: 'MyriadPro',
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: onAllCategoriesPressed,
                  child: Container(
                    padding: EdgeInsets.all(15),
                    color: Color(0xff4b3d7a),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Image.asset('assets/all_events.png', width: 30, height: 30,),
                        Text(
                          'All Categories',
                          style: TextStyle(
                            color: Colors.white,fontFamily: 'MyriadPro',
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileTabs extends StatefulWidget {
  final Function(String) onHistoryItemPressed;

  ProfileTabs({@required this.onHistoryItemPressed});
  @override
  _ProfileTabsState createState() => _ProfileTabsState();
}

class _ProfileTabsState extends State<ProfileTabs> with TickerProviderStateMixin{

  int _pageIndex;

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _pageIndex = infPageIndex;
    _tabController = TabController(
      vsync: this,
      length: 2,
    )
    ..addListener((){
      setState(() {
        _pageIndex = _tabController.index;
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    final _width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Column(
        children: <Widget>[

          // The title
          Padding(
            padding: EdgeInsets.only(top: _width > 360?10:8.0, bottom: _width > 360?10:8.0),
            child: Text('My Profile',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xfffe6700),
                fontSize: 25,
                fontFamily: 'Verdana'
              ),
            ),
          ),

          // Tabs
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
                    _tabController.animateTo(_pageIndex);
                  });
                },
                child: Container(
                  width: 130,
                  child: Padding(
                    padding: EdgeInsets.all(15),
                    child: Text('My Info',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xfffe6700),
                        fontSize: 16,
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
                  _tabController.animateTo(_pageIndex);
                },
                child: Container(
                  width: 130,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text('My History',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xfffe6700),
                        fontSize: 16,
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

          // My Profile Body.
          Flexible(

            child: TabBarView(
              controller: _tabController,
              physics: NeverScrollableScrollPhysics(),
              children: <Widget>[
                ProfileInfo(),
                ProfileHistory(
                  onHistoryItemPressed: widget.onHistoryItemPressed,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}


