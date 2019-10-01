import 'package:flutter/material.dart';

import '../../globals.dart';

class FaqPage extends StatelessWidget {
  final Function onPreviousPagePressed;
  final Function onAllCategoriesPressed;
  final Function onWillPop;

  FaqPage({@required this.onPreviousPagePressed, @required this.onAllCategoriesPressed, @required this.onWillPop});
  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
//    Globals.pagesStack.push(PagesIndices.faqPageIndex);

    return WillPopScope(
      onWillPop: () async{
        onWillPop();
        return null;
      },
      child: Scaffold(
        body: ListView(
          children: <Widget>[Padding(
            padding: EdgeInsets.only(top: _width > 360?10:8.0, bottom: _width > 360?10:8.0),
            child: Text('FAQ',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Color(0xfffe6700),
                  fontSize: 25,
                  fontFamily: 'Verdana'
              ),
            ),
          ),
            _faqItem(context, 'Can I reserve a ticket after 15 days?', 'Yes, you can.')
          ],
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
                            color: Colors.white,
                            fontFamily: 'MyriadPro',
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
                            color: Colors.white,
                            fontFamily: 'MyriadPro',
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

  Widget _faqItem(BuildContext context, String question, String answer){
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Color(0xffff6600),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(question,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(answer,
              style: TextStyle(
                fontSize: 20,
                color: Color(0xff656565)
              ),
            ),
          ),
        ],
      ),
    );
  }
}

